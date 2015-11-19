//
//  ZServer.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZServer : NSObject

+ (ZServer*)instance;

- (void)start;
- (void)stop;

@end
