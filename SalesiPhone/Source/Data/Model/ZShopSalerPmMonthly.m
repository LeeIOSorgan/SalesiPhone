//
//  ZShopSalerPmMonthly.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-2-25.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZShopSalerPmMonthly.h"

@implementation ZShopSalerPmMonthly


-(NSString*)created{
    NSRange range = NSMakeRange(0,7);
    if (_created) {
        if(_created.length > 7) {
            NSString* creatDate = [_created substringWithRange:range];
            return creatDate;
        }
    }
    return _created;
}

@end
