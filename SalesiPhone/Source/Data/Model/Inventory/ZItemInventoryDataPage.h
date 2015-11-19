//
//  ZItemDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDataPage.h"
@interface ZItemInventoryDataPage : ZDataPage

@property (nonatomic )NSArray* inventoryOrderDTOs;
@property(nonatomic )NSNumber* totalInventoryCount;  //库存总量
@property(nonatomic )NSNumber* totalStockCount;   //库存金额
@property(nonatomic )NSNumber* totalFee;   //库存金额
@end
