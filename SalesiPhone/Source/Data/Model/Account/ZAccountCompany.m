//
//  ZAccountCompany.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-5.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZAccountCompany.h"

@implementation ZAccountCompany


-(void)dealloc
{
    ZLogInfo(@"---Into----ZAccountCompany--dealloc-");
    _coAccountId = nil;
    _itemCompanyId = nil;
    _tradeId = nil;
    
    _memo = nil;
    _created = nil;
    _name = nil;
    _contactName = nil;
    _telephone = nil;
    
    _ownedFee = nil;
    _shouldPay = nil;
    _payedFee = nil;
    _payedCash = nil;
    _payedCard = nil;
    _payedRemit = nil;
    
    _unpayStill = nil;
    _balanceFee = nil;
}

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
