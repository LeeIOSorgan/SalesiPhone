//
//  ZCache.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/5/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCache : NSObject

- (void)setCacheValue:(id)object key:(NSObject*)key;

- (id)cacheValue:(id)key;


@end
