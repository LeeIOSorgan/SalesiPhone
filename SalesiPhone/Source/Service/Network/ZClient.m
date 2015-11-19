//
//  ZClient.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZClient.h"

#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestConfig.h"

#import "ZJson.h"

#import "ZTestMenu.h"

#import "ZModel.h"

@interface ZClient ()


@end

@implementation ZClient

+ (ZClient*)instance
{
    static ZClient* _instance = nil;
    if (_instance == nil){
        _instance = [[ZClient alloc] init];
    }
    
    return _instance;
}

- (void)acceptJsonData:(NSData*)jsonData
{
//    ZJson* json = [[ZJson alloc] init];
//    NSDictionary* data = (NSDictionary*)[json parse:jsonData];
//    ZTest *oo = [[ZTest alloc] initWithDictionary:data];
//    ZLogInfo(@"oo = %@", oo);
//    NSObject* jj = [ZModel modelWithJSON:data];
//    ZLogInfo(@"jj = %@", jj);
}

- (void)sendDataWithAsiHttp:(NSString*)data
{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSString *response = [request responseString];
        ZLogInfo(@"response = %@", response);
        
        NSData* jsonData = [request responseData];
        [self acceptJsonData:jsonData];
    }
    else{
        ZLogError(@"error: %@", [error description]);
    }
}

- (void)sendDataWithGcdAsyncSocket:(NSString*)data
{
    
}

- (void)sendData:(NSString*)textData{
    
    [self sendDataWithAsiHttp:textData];
}

@end
