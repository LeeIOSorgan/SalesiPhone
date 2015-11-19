//
//  ZMockCenter.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/12/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZRequestInc.h"

@interface ZMockCenter : NSObject

+ (ZMockCenter*)instance;

- (NSString*)textWithType:(int)type;
- (NSData*)dataWithType:(int)type;

+ (void)mock:(ZResponse*)response;

@end
