//
//  ZDataService.m
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/6/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZDataService.h"

#import "HttpParam.h"
#import "HttpManager.h"

#import "ZMockCenter.h"
#import "ZLoginService.h"

@interface ZDataService ()<HttpManagerDelegate>

@property (nonatomic ) NSMutableDictionary*  delegateDict;
//@property (nonatomic ) ZBaseService*  baseService;

@end

@implementation ZDataService

- (void)clear{
    if (_delegateDict){
        [_delegateDict removeAllObjects];
//        [_delegateDict release];
        _delegateDict = nil;
    }
}

+ (ZDataService*)sharedService{
    static ZDataService* _instance = nil;
    if (_instance == nil)
    {
        _instance = [[ZDataService alloc] init];
    }
    
    return _instance;
}

- (id)init
{
   if (self = [super init])
   {
       arrayResponseHandler_ = [[NSMutableArray alloc] initWithCapacity:10];
       arrayFileHandler_ = [[NSMutableArray alloc]initWithCapacity:10];
       lockFile_ = [[NSCondition alloc]init];
       lock_ = [[NSCondition alloc]init];
   }
    
    return self;
}



- (NSMutableDictionary*)delegateDict{
    if (_delegateDict == nil) {
        _delegateDict = [[NSMutableDictionary alloc] init];
    }
    
    return _delegateDict;
}

- (void)postRequest:(HttpParam*) hp
{
//    HttpParam* hp = [_requestService createRequest:request];
    HttpManager* hm = [HttpManager getInstance];
    hm.delegate = self;
    [hm postHttpRequest:hp];
}

- (void)registerObserver:(id)delegate type:(int)businessType
{
    [self.delegateDict setObject:delegate forKey:ZNumber(businessType)];
}

- (void)unregisterObserver:(id)delegate type:(int)businessType
{
    [self.delegateDict removeObjectForKey:ZNumber(businessType)];
}


- (void)handleResponse:(ZResponse*)response
{
    int type = response.businessType;
    id delegate = [self.delegateDict objectForKey:ZNumber(type)];
    
//    [ZMockCenter mock:response];
    
    if ([delegate respondsToSelector:@selector(handleResponse:)]){
        [delegate handleResponse:response];
    }
}

@end
