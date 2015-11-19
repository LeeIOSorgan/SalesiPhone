//
//  ZItemDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemInventoryDataPage.h"
#import "ZItemInventoryDTO.h"

@implementation ZItemInventoryDataPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZItemInventoryDataPage--dealloc-");
    _inventoryOrderDTOs = nil;
    _totalInventoryCount = nil;
    _totalStockCount = nil;
    _totalFee = nil;
}

+ (Class)inventoryOrderDTOs_class { // used by Jastor
	return [ZItemInventoryDTO class];
}

@end
