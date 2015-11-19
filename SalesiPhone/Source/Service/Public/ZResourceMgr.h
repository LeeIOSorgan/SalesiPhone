//
//  ZResourceMgr.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-10.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZResourceMgr : NSObject

+(NSString*)getString:(NSString*)key;
+(void)shopType:(int) type;

+(BOOL)isRedWine;
+(BOOL)isClothingWholesale;
+(BOOL)isShopNeedColorSize;
+(BOOL)isChildWearWholesale;
+(BOOL)isShopClothingRetail;
+(BOOL)isShopWholesale;
+(BOOL)isShopRetail;

@end
