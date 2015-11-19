//
//  ZItemDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDataPage.h"
@interface ZItemDataPage : ZDataPage

@property (nonatomic, assign)NSMutableArray* itemDTOs;
@property(nonatomic )NSNumber* totalCount;  //库存总量
@property(nonatomic )NSNumber* totalFee;   //库存金额
@property(nonatomic )NSNumber* totalCostFee;   //库存金额
@property(nonatomic )NSNumber* totalInStock;   //库存金额
@property(nonatomic )NSNumber* totalIn;   //库存金额
@property(nonatomic )NSNumber* totalOut;   //库存金额
@property(nonatomic )NSNumber* totalSaled;   //库存
@property(nonatomic )NSNumber* totalAdd;   //库存金额


@end
