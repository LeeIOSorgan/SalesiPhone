//
//  HttpManager.m
//  cloud
//
//  Created by ZTaoTech ZG on 3/31/12.
//  Copyright 2012 ZTaoTech All rights reserved.
//

#import "HttpManager.h"
//#import "TransferParam.h"
#import "ZNotification.h"
#import "MBProgressHUD.h"
#import "ZArchive.h"


#define kRespClassIsArray   @"ResponseClassIsArray"
#define kRespClassType      @"ResponseClassType"
#define kRespDelegate       @"ResponseDelegate"

#define kBusinessType       @"BusinessType"
#define kUniquenessID       @"UniquenessID"

#define kFileID             @"FileID"
#define kSavePath           @"SavePath"
#define kDownUrl            @"DownUrl"


#define kUpTaskID           @"UpTaskID"
#define kUpUrl              @"UpUrl"
#define kUpData             @"UpData"

#import "ZResponse.h"
#import "JSONKit.h"
#import "Jastor.h"
#import "NSString+HXAddtions.h"

#define kLoadingTag 10000

@interface HttpManager(Private)
-(id)initWith :(id)handler;
-(void)removeRequest:(ASIHTTPRequest*)request state:(int)state;
@end
//MBProgressHUD* HUD;

@interface HttpManager()
{
    MBProgressHUD* _HUD;
    BOOL _exit;
    
    NSOperationQueue *requestQueue_;
    NSMutableArray *requestList_;
    
    NSMutableArray *downFileRequestList_;
    NSMutableArray *upLoadFileRequestList_;
}

@end

@implementation HttpManager

static HttpManager* ins_ = nil;

+ (HttpManager*)getInstance
{
    if (ins_ == nil)
    {        
        ins_ = [[HttpManager alloc] init];
    }
    
    return ins_;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        _exit = NO;
        requestQueue_ = [[NSOperationQueue alloc] init];
        requestList_ = [[NSMutableArray alloc]initWithCapacity:4];
        downFileRequestList_ = [[NSMutableArray alloc]initWithCapacity:4];
        upLoadFileRequestList_ = [[NSMutableArray alloc]initWithCapacity:4];
    }

    return self;
}

-(void)clear {
    ins_ = nil;
    {
        requestQueue_= nil;
        [requestList_  removeAllObjects];
        [downFileRequestList_ removeAllObjects];
        [upLoadFileRequestList_ removeAllObjects];
//        [_sessionID release];
        _sessionID= nil;
    }
}

-(void)cancleAllRequest{
    int i;
    for (i = 0; i < [requestList_ count]; i++) {
        ASIHTTPRequest *request = [requestList_ objectAtIndex:i];
        [request cancel];
        [request clearDelegatesAndCancel];
    }
    
    for ( i = 0 ; i < [downFileRequestList_ count]; i++) {
        ASIHTTPRequest *request = [requestList_ objectAtIndex:i];
        [request cancel];
        [request clearDelegatesAndCancel];
    }
}


-(void)postHttpRequest:(HttpParam*)hp
{
    if(hp.showLoading) {
        if ([hp.delegate isKindOfClass:[UIView class]]) {
            ZLogInfo(@" Show Loading view");
            UIView * view = (UIView*)hp.delegate;
            MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:view];
            HUD.tag = kLoadingTag;
            [view addSubview:HUD];
            HUD.labelText = @"Loading";
            HUD.removeFromSuperViewOnHide = YES;
            [HUD show:YES];
        }
    }
    [self postHttpRequestTask:hp];
}

-(void)postHttpRequestTask:(HttpParam *)hp
{
    @autoreleasepool {
        
        hp.strUrl = [hp.strUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        ASIHTTPRequest * request_ = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:hp.strUrl]];
        
        [ASIHTTPRequest setSessionCookies:nil];
        request_.shouldAttemptPersistentConnection = NO;
        BOOL isProxy = [hp.strUrl hasPrefix:@"http://xxx.com.cn"];
        if (isProxy) {
            request_.proxyDomain = @"axxx.com.cn";
            request_.proxyHost = @"";
            request_.proxyPort = 80;
        }
        
        if ([hp.strMethod length])
        {
            [request_ setRequestMethod:hp.strMethod];
        }
        //如果有设置超时时间，就设置到http请求中去
        if (hp.timeout > 0)
        {
            [request_  setTimeOutSeconds:hp.timeout];
        }
        if ([hp.dictHead count])
        {
            NSArray* arrayKey = [hp.dictHead allKeys];
            for (NSString* strkey in arrayKey)
            {
                NSString* strValue = [hp.dictHead objectForKey:strkey];
                //            ZLogInfo(@"%d key = %@, value = %@", hp.type, strkey, strValue);
                [request_ addRequestHeader:strkey value:strValue];
            }
        }
        ZLogInfo(@"Request strUrl = %@ ,key=%d", hp.strUrl, hp.type);
        if(nil != _sessionID) {
            [request_ addRequestHeader:@"Cookie" value:_sessionID];
        }
        
        if(nil != _token) {
            [request_ addRequestHeader:@"USR-TOKEN" value:_token];
        } else {
            _token = [[ZArchive instance]getHTTPToken];
        }
        if(hp.requestObj) {
            if([hp.requestObj isKindOfClass:[Jastor class]]) {
                Jastor* obj = (Jastor*)hp.requestObj;
                NSDictionary *toDic = [obj toDictionary];
                NSString * resultJSon = [toDic JSONString];
                [request_ appendPostData:[resultJSon dataUsingEncoding:NSUTF8StringEncoding]];
                ZLogInfo(@" Request JSon %d = %@", hp.type, resultJSon);
            } else if([hp.requestObj isKindOfClass:[NSArray class]]) {
                //
                NSString *resultJSon = [NSString jsonStringWithArray: hp.requestObj];
                [request_ appendPostData:[resultJSon dataUsingEncoding:NSUTF8StringEncoding]];
                ZLogInfo(@" Request JSon %d = %@", hp.type, resultJSon);
            }
        } else if ([hp.strBody length])
        {
            ZLogInfo(@" Request strBody %d = %@", hp.type, hp.strBody);
            [request_ appendPostData:[hp.strBody dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [request_ setValidatesSecureCertificate:NO];
        
        request_.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:hp.type],
                             kBusinessType, hp.delegate, kRespDelegate, hp.respClassType, kRespClassType,
                             [NSNumber numberWithBool:hp.isArray], kRespClassIsArray, nil];
        
        [requestList_ addObject:request_];
        request_.delegate = self;
        
        [requestQueue_ addOperation:request_];
        ZLogInfo(@"-End postHttpRequestTask--- ");
    }
}

-(void)stopFileDownOrUp:(NSString*)taskID{
    //查找fileRequestList_中http对象，然后停止
    BOOL ret = FALSE;
    for (int i = 0; i < [downFileRequestList_ count]; i++) {
        ASIHTTPRequest *request = [downFileRequestList_ objectAtIndex:i];
        if ([taskID isEqualToString:[request.userInfo valueForKey:kUniquenessID]]) {
            ZLogInfo(@"stop kUniquenessID = %@ down",taskID);
            [request cancel];
            ret = TRUE;
            break;
        }
    }
    
    if (!ret) {
        for (int i = 0; i < [upLoadFileRequestList_ count]; i++) {
            ASIHTTPRequest *request = [upLoadFileRequestList_ objectAtIndex:i];
            if ([taskID isEqualToString:[request.userInfo valueForKey:kUniquenessID]]) {
                ZLogInfo(@"stop kUniquenessID = %@ down",taskID);
                [request cancel];
                break;
            }
        }
    }
}

- (NSString*)encodeURL:(NSString *)string
{
//    NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByAddingPercentEscapes(
//                                                                                                 kCFAllocatorDefault,
//                                                                                                 (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
//                                                                                            CFStringConvertNSStringEncodingToEncoding([self stringEncoding])) autorelease]);
    
    NSString *newString = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                (CFStringRef)string, nil,
                                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    if (newString) {
        return newString;
    }
    return @"";
}

-(void)addHttpDownFileRequest:(NSDictionary*)dic {
    //字典保存http请求对象和文件id

    NSString *fileID =  [dic valueForKey:kFileID];
    NSString *savePath = [dic valueForKey:kSavePath];
    NSString *downUrl =  [dic valueForKey:kDownUrl];
    ASIHTTPRequest *request  = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:downUrl]];
   // request.isShowProgress = YES;
    request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:fileID,kUniquenessID, nil];
    NSString *tempPath = [NSString stringWithFormat:@"%@_temp",savePath];
    [request setTemporaryFileDownloadPath:tempPath];
    [request setDownloadDestinationPath:savePath];
    [request setAllowResumeForFileDownloads:YES];
    request.delegate = self;
    [request startAsynchronous];
    [downFileRequestList_ addObject:request];
}


//- (void)addHttpUpLoadFileRequest:(int)bizType
//                        filePath:(NSString*)filePath
//                             url:(NSString*)upUrl
//                        delegate:(id)delegate
//                       indicator:(UIProgressView*)indicator
- (void)addHttpUpLoadFileRequest:(int)bizType
                        fileData:(NSData*)data
                        filePath:(NSString*)filePath
                             url:(NSString*)upUrl
                        delegate:(id)delegate
                       indicator:(UIProgressView*)indicator
                   respClassType:(NSString*)respType
{
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:upUrl]];
//   [ASIFormDataRequest setSessionCookies:nil];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:upUrl]];
    
    request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:bizType],
                        kBusinessType,filePath, kUniquenessID, delegate, kRespDelegate,respType, kRespClassType, nil];
    if(nil != _sessionID) {
        [request addRequestHeader:@"Cookie" value:_sessionID];
    }
    [request addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
    [request setRequestMethod:@"POST"];
    [request appendPostData:data];
//    [request setFile:filePath forKey:@"file"];
    [request setTimeOutSeconds:60];
    
    [request setUploadProgressDelegate:indicator];
    
    ZLogInfo(@"filePath = %@ ", filePath);
    //ZLogInfo(@"strUrl = %@  data size = %d", upUrl,[data length]);
    request.delegate = self;
    [request startAsynchronous];
    request.shouldAttemptPersistentConnection = NO;
    [upLoadFileRequestList_ addObject:request];
}

-(void)addHttpUpLoadFileRequest:(NSDictionary *)dic header:(NSDictionary*)hdic {

    NSString *upTaskID = [dic valueForKey:kUpTaskID];
    NSString *upUrl =  [dic valueForKey:kUpUrl];
    NSData *data  =[dic valueForKey:kUpData];

    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:upUrl]];
    request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:upTaskID,kUniquenessID, nil];
    [request addRequestHeader:@"Content-Type" value:[hdic objectForKey:@"Content-Type"]];
    [request addRequestHeader:@"Authorization" value:[hdic objectForKey:@"Authorization"]];
    [request addRequestHeader:@"rangeType" value:[hdic objectForKey:@"rangeType"]];
    [request addRequestHeader:@"Range" value:[hdic objectForKey:@"Range"]];
    [request addRequestHeader:@"contentSize" value:[hdic objectForKey:@"contentSize"]];
    [request addRequestHeader:@"UploadtaskID" value:[hdic objectForKey:@"UploadtaskID"]];
    [request addRequestHeader:@"Content-Length" value:[hdic objectForKey:@"Content-Length"]];
    [request setRequestMethod:@"POST"];
//    request.isShowProgress = YES;
//    request.isUpLoad = TRUE;
    [request appendPostData:data];
    ZLogInfo(@"strUrl = %@  data size = %d", upUrl,[data length]);
    ZLogInfo(@"hdic = %@",hdic);
    request.delegate = self;
    [request startAsynchronous];
    request.shouldAttemptPersistentConnection = NO;
    [upLoadFileRequestList_ addObject:request];
}

- (void) requestFinished:(ASIHTTPRequest *)request 
{
    [self removeRequest:request state:0];
    
}


- (void) requestFailed:(ASIHTTPRequest *)request 
{

    [self removeRequest:request state:-1];
    

}

- (void)request:(ASIHTTPRequest *)request DownProgress:(NSNumber*)progress{
    if (_delegate)
    {
        //NSString *strFileID = [request.userInfo valueForKey:kUniquenessID];
        if ([_delegate respondsToSelector:@selector(httpFileProgress:Progress:)]) 
        {
            //[_delegate httpFileProgress:strFileID Progress:[progress floatValue]];
        }
    }
}

- (void)request:(ASIHTTPRequest *)request UpProgress:(NSNumber*)progress{
    if (_delegate) 
    {
        NSString *strFileID = [request.userInfo valueForKey:kUniquenessID];
        if ([_delegate respondsToSelector:@selector(httpFileProgress:Progress:)]) 
        {
            [_delegate httpFileProgress:strFileID Progress:[progress floatValue]];
        }
    }
}
@end


@implementation HttpManager(Private)
-(id)initWith :(id)handler{
    return nil;
}

-(void)removeRequest:(ASIHTTPRequest*)request state:(int)state{
    @autoreleasepool {
        ZLogInfo(@"--Into-removeRequest--- %d --", state);
        id tmpDelegate = [request.userInfo objectForKey:kRespDelegate];
        
        if([request responseStatusCode] == 401)
        {
            if([tmpDelegate isKindOfClass:[UIView class]]) {
                UIView* tmp = (UIView*)tmpDelegate;
                MBProgressHUD * hud = (MBProgressHUD *)[tmp viewWithTag:kLoadingTag];
                [hud hide:YES];
            }
            _exit=YES;
            tmpDelegate = nil;
            _sessionID = nil;
            [[ZNotification sharedInstance] notify:kLogOut];
        }
        if (tmpDelegate)
        {
            if ([tmpDelegate respondsToSelector:@selector(handleResponse:)])
            {
                
                ZResponse* response = [[ZResponse alloc] init];
                response.code.code = [request responseStatusCode];
                response.code.status = state;
                response.businessType = [[request.userInfo valueForKey:kBusinessType] intValue];
                response.respClassType =[request.userInfo objectForKey:kRespClassType];
                response.isArray = [[request.userInfo objectForKey:kRespClassIsArray] boolValue];
                if([request responseStatusCode] == 0) {
                    response.text= @"";
                } else {
                    response.text = [NSString stringWithFormat:@"%@", [request responseString]];
                }
                NSString * tmpStr = [[request responseHeaders] objectForKey:@"Set-Cookie"];
                if (nil != tmpStr && nil == _sessionID) {
                    //sessionID需要长久保存，不能被回收。
                    _sessionID = [tmpStr copy];
                }
                WYLog(@"response.text %@",response.text);
                ZLogInfo(@"Send sessionId  %@",_sessionID);
                ZLogInfo(@"Received String httpcode %d bizcode %d : %@",response.code.code, response.businessType, [NSString stringWithFormat:@"%@", [request responseString]]);
                id tmpDelegate = [request.userInfo objectForKey:kRespDelegate];
                response.data = [NSData dataWithData:[request responseData]];
                
                if(response.respClassType) {
                    NSError *error = nil;
                    if (response.isArray) {
                        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: response.data options: NSJSONReadingMutableContainers error: &error];
                        if (nil != jsonArray) {
                            Class tmpClass = NSClassFromString(response.respClassType);
                            if(tmpClass){
                                NSMutableArray * arrayObj = [[NSMutableArray alloc]init];
                                for(id jsonObj in jsonArray) {
                                    //获取需要返回的class类型。
                                    @try {
                                        //使用Jastor将dictionary转换成class的实例
                                        NSObject *obj = [[tmpClass alloc]initWithDictionary:jsonObj];
                                        [arrayObj addObject:obj];
                                        // ZLogInfo(@"Received JSON Dictionary : %@", jsonObj);
                                    }@catch (NSException * e) {
                                        ZLogInfo(@"NSException Dictionary : %@", e);
                                    }
                                }
                                response.respObj = arrayObj;
                            }
                        }
                    } else {
                        id jsonObject = [NSJSONSerialization JSONObjectWithData:response.data options:NSJSONReadingAllowFragments error:&error];
                        if (nil != jsonObject) {
                            //如果json数据解析成功
                            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                                NSDictionary *resultDic = (NSDictionary *)jsonObject;
                                @try {
                                    //获取需要返回的class类型。
                                    Class tmpClass = NSClassFromString(response.respClassType);
                                    if(tmpClass){
                                        //使用Jastor将dictionary转换成class的实例
                                        NSObject *obj = [[tmpClass alloc]initWithDictionary:resultDic];
                                        response.respObj = obj;
                                    }
                                    //ZLogInfo(@"Received JSON Dictionary : %@", resultDic);
                                }@catch (NSException * e) {
                                    ZLogError(@"NSException Dictionary : %@", e);
                                }
                            } else {
                                ZLogInfo(@"Error JSON data.");
                            }
                        }
                        
                    }
                }
                @try {
                    [tmpDelegate handleResponse:response];
                }
                @catch (NSException *e) {
                    ZLogError(@"NSException Dictionary : %@", e);
                }
                @finally {
                    //                    [response release];
                }
            }
        }
        //}
        if(_exit)
        {
            return;
        }
        BOOL flag = FALSE;
        for (int i = 0; i < [requestList_ count]; i++) {
            ASIHTTPRequest *tempHttp = (ASIHTTPRequest *)[requestList_ objectAtIndex:i];
            if ([tempHttp isEqual:request]) {
                flag = TRUE;
                [requestList_ removeObject:request];
                break;
            }
        }
        
        if (!flag) {
            for (int i = 0; i < [downFileRequestList_ count]; i++) {
                ASIHTTPRequest *tempHttp = (ASIHTTPRequest *)[downFileRequestList_ objectAtIndex:i];
                if ([tempHttp isEqual:request]) {
                    flag = TRUE;
                    ZLogInfo(@"downFileRequestList_ removeObject");
                    [downFileRequestList_ removeObject:request];
                    break;
                }
            }
        }
        
        if (!flag) {
            for (int i = 0; i < [upLoadFileRequestList_ count]; i++) {
                ASIHTTPRequest *tempHttp = (ASIHTTPRequest *)[upLoadFileRequestList_ objectAtIndex:i];
                if ([tempHttp isEqual:request]) {
                    ZLogInfo(@"upLoadFileRequestList_ removeObject");
                    [upLoadFileRequestList_ removeObject:request];
                    break;
                }
            }
        }
        ZLogInfo(@"--Out-removeRequest--- %d --", state);
        if([tmpDelegate isKindOfClass:[UIView class]]) {
            UIView* tmp = (UIView*)tmpDelegate;
//            MBProgressHUD * hud = (MBProgressHUD *)[tmp viewWithTag:kLoadingTag];
            [MBProgressHUD hideHUDForView:tmp animated:NO];
//            [hud hide:YES];
        }
    }
}

@end
