//
//  HttpManager.h
//  cloud
//
//  Created by ZTaoTech ZG on 3/31/12.
//  Copyright 2012 ZTaoTech All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "HttpParam.h"

#import "ZResponse.h"
#import "ZType.h"

@class MBProgressHUD;
@protocol HttpManagerDelegate <NSObject>

@required
- (void)handleResponse:(ZResponse*)response;


//-(void)fileReponse:(NSString*)uniquenessID withStatus:(int)status;
//-(void)fileProgress:(NSString*)uniquenessID Progress:(float)progress;
//
//-(void)httpFileProgress:(NSString*)uniquenessID Progress:(float)progress;

@optional

-(void)httpFileReponse:(NSString*)uniquenessID withStatus:(int)status;
-(void)httpFileProgress:(NSString*)uniquenessID Progress:(float)progress;

//-(void)httpMangagerResponse:(NSString*)strResponse withType:(int)type withStatus:(int)status;

@end


@interface HttpManager : NSObject


@property (nonatomic,assign ) id<HttpManagerDelegate> delegate;
@property (nonatomic )     NSString *sessionID;
@property (nonatomic ) NSString* token;

+ (HttpManager*)getInstance;

-(void)postHttpRequest:(HttpParam*)hp;
-(void)addHttpDownFileRequest:(NSDictionary*)dic ;
-(void)addHttpUpLoadFileRequest:(NSDictionary *)dic header:(NSDictionary*)hdic;
-(void)stopFileDownOrUp:(NSString*)taskID;
-(void)cancleAllRequest;
-(void)clear;

//2013.08.23
//- (void)addHttpUpLoadFileRequest:(int)bizType filePath:(NSString*)filePath url:(NSString*)upUrl
//                        delegate:(id)delegate
//                       indicator:(UIProgressView*)indicator;
- (void)addHttpUpLoadFileRequest:(int)bizType
                        fileData:(NSData*)data
                        filePath:(NSString*)filePath
                             url:(NSString*)upUrl
                        delegate:(id)delegate
                       indicator:(UIProgressView*)indicator
                   respClassType:(NSString*)respType;
@end
