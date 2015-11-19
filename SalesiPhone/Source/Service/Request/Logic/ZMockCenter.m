
//
//  ZMockCenter.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/12/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZMockCenter.h"

@implementation ZMockCenter

+ (ZMockCenter*)instance
{
    static ZMockCenter* _instance = nil;
    if (_instance == nil)
    {
        _instance = [[ZMockCenter alloc] init];
    }
    
    return _instance;
}

+ (void)mock:(ZResponse*)response
{
    //do anythine here
}

- (NSString*)textWithType:(int)type
{
    return nil;
}

- (NSData*)dataWithType:(int)type
{
    return nil;
}
@end
