//
//  ZItemDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemInventoryRecordDataPage.h"
#import "ZInventoryHandleDTO.h"

@implementation ZItemInventoryRecordDataPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZItemInventoryDataPage--dealloc-");
    _inventoryRecordDTOs = nil;
    _totalInventoryCount = nil;
    _totalStockCount = nil;
    _totalFee = nil;
}

+ (Class)inventoryRecordDTOs_class { // used by Jastor
	return [ZInventoryHandleDTO class];
}

@end
