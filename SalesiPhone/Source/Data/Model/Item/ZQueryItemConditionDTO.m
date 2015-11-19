//
//  ZQueryItemConditionDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-11.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZQueryItemConditionDTO.h"

@implementation ZQueryItemConditionDTO

-(void)dealloc
{
    ZLogInfo(@"--Into---ZQueryItemConditionDTO---dealloc----");
    _kuanHao = nil;
    _itemBrand = nil;
    _itemCompany = nil;
    _category = nil;
    _tradeType = nil;
    _customerId = nil;
}
@end
