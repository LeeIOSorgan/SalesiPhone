//
//  ZDataService.h
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/6/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZResponse.h"
#import "ZCode.h"
#import "HttpParam.h"

#define ZService    [ZDataService sharedService]

@interface HandleParam : NSObject
{
    id handler_;
    int type_;
}

@property(nonatomic ) id handler;
@property(nonatomic ) int type;

@end


@interface FileParam : NSObject
{
    id handler_;
    
    //down
    NSString *strFileID_;
    NSString *savePath_;
    NSString *downUrl_;
    
    //upLoad
    NSString *filePath_;
    NSString *upUrl_;
    NSString *upTaskID_;
}

@property(nonatomic ) id handler;
@property(nonatomic, copy) NSString *upTaskID;
@property(nonatomic, copy) NSString *savePath;
@property(nonatomic, copy) NSString *downUrl;
@property(nonatomic, copy) NSString *strFileID;
@property(nonatomic, copy) NSString *filePath;
@property(nonatomic, copy) NSString *upUrl;
@end
//---------------------------------


//@protocol ZDataServiceDelegate <NSObject>
//
//- (void)requestFinished:(ZResponse*)response;
//
//@end




@interface ZDataService : NSObject
{
    NSMutableArray* arrayResponseHandler_;
    NSMutableArray* arrayFileHandler_;
    NSCondition* lock_;
    NSCondition* lockFile_;
}

+ (ZDataService*)sharedService;

- (void)postRequest:(HttpParam*)request;
- (void)registerObserver:(id)delegate type:(int)businessType;
- (void)unregisterObserver:(id)delegate  type:(int)businessType;

@end
