//
//  ZClient.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZClient : NSObject

+ (ZClient*)instance;
- (void)sendData:(NSString*)textData;

@end
