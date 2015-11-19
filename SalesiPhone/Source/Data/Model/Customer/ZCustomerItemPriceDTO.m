//
//  ZCustomerItemPriceDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-10-19.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZCustomerItemPriceDTO.h"

@implementation ZCustomerItemPriceDTO

-(void)dealloc
{
    _itemId = nil;
    _customerId = nil;
    _lastPrice = nil;
    _lastDiscount = nil;
}

-(NSString*)created{
    NSRange range = NSMakeRange(0,19);
    if (_created) {
        if(_created.length >= 19) {
            NSString* creatDate = [_created substringWithRange:range];
            return creatDate;
        }
    }
    return _created;
}

@end
