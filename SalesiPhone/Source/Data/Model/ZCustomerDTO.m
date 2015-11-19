
//
//  ZCustomerDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZCustomerDTO.h"

@implementation ZCustomerDTO

-(NSString*)lastestTradeTime{
    NSRange range = NSMakeRange(5,11);
    if (_lastestTradeTime) {
        if(_lastestTradeTime.length > 7) {
            NSString* creatDate = [_lastestTradeTime substringWithRange:range];
            return creatDate;
        }
    }
    return _lastestTradeTime;
}
@end
