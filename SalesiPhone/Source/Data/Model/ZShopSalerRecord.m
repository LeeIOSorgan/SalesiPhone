//
//  ZShopSalerRecord.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-2-25.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZShopSalerRecord.h"

@implementation ZShopSalerRecord

-(NSString*)created{
    NSRange range = NSMakeRange(5,11);
    if (_created) {
        if(_created.length > 7) {
            NSString* creatDate = [_created substringWithRange:range];
            return creatDate;
        }
    }
    return _created;
}

@end
