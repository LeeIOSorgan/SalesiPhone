//
//  ZItemCGTradeDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-13.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"
#import "ZDataPage.h"

@interface ZItemCGTradePage :ZDataPage

@property(nonatomic)NSNumber* totalCost;
@property(nonatomic)NSNumber* totalCount;
@property(nonatomic)NSNumber* totalFee;
@property(nonatomic)NSNumber* totalCGFee;
@property(nonatomic)NSNumber* totalInStock;
@property(nonatomic)NSNumber* totalCostFee;
@property(nonatomic)NSNumber* totalBuy;
@property(nonatomic)NSNumber* totalReturn;
@property(nonatomic)NSNumber* totalUnpayFee;

@property(nonatomic )NSArray* itemCGTradeDTOs;
@end
