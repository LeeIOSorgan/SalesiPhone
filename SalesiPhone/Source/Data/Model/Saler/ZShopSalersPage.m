//
//  ZShopSalersPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-2-26.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZShopSalersPage.h"
#import "ZShopSalerDTO.h"

@implementation ZShopSalersPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZSalerRecordPage--dealloc-");
    _salers = nil;
}

+ (Class)salers_class { // used by Jastor
	return [ZShopSalerDTO class];
}

@end
