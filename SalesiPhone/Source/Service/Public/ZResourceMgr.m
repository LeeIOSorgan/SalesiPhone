//
//  ZResourceMgr.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-10.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZResourceMgr.h"
#import "ZContants.h"


static int shopType;
@implementation ZResourceMgr
+(NSString*)getString:(NSString*)key
{
    if (shopType == 1000) {
       return NSLocalizedStringFromTable(key, @"redWine", @"");
    } else if(shopType <1000) {
        return NSLocalizedStringFromTable(key, @"sjqSeller", @"");
    }
    return NSLocalizedStringFromTable(key, @"normal", @"");
}

+(void)shopType:(int) type{
    shopType = type;
}

+(BOOL)isRedWine
{
    if(shopType == 1000)
    {
        return YES;
    }
    return NO;
}
//clothing wholesale
+(BOOL)isClothingWholesale
{
    if(shopType < 1000) {
        
        return YES;
    }
    return NO;
}

+(BOOL)isChildWearWholesale
{
//    if(shopType == 200) {
//        
//        return YES;
//    }
    return NO;
}

+(BOOL)isShopWholesale{
    if(shopType == 100 || shopType == 200) {
        //成衣批发，童装批发
        return YES;
    }
    return NO;
}
+(BOOL)isShopRetail{
    if(shopType == 110 || shopType == 210) {
        //成衣批发，童装批发
        return YES;
    }
    return NO;
}
// 服装销售 子店铺。
+(BOOL)isShopClothingRetail{
    if(shopType == 101) {
        //成衣批发
        return YES;
    }
    return NO;
}

+(BOOL)isShopNeedColorSize
{
    if(shopType < 1000) {
        
        return YES;
    }
    return NO;
}

@end
