//
//  ZDailyReportDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-14.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZDailyReportDTO : Jastor

@property(nonatomic)NSNumber* rowid;
@property(nonatomic)NSNumber* shopId;

@property(nonatomic)NSString* shopName;
@property(nonatomic)NSString* memo;
@property(nonatomic)NSNumber* purchaseCount;
@property(nonatomic)NSNumber* purchaseFee;
@property(nonatomic)NSNumber* purchasePayedFee;
@property(nonatomic)NSNumber* purchaseOwnFee;

@property(nonatomic)NSNumber* tradeNum;
@property(nonatomic)NSNumber* tradeNumDeleted;

@property(nonatomic)NSNumber* saledCount;
@property(nonatomic)NSNumber* returnedCount;
@property(nonatomic)NSNumber* saledFee;
@property(nonatomic)NSNumber* saledTotalFee;
@property(nonatomic)NSNumber* saledTotalItemFee;
@property(nonatomic)NSNumber* saledProfit;

@property(nonatomic)NSNumber* payedCashSum;
@property(nonatomic)NSNumber* payedCardSum;
@property(nonatomic)NSNumber* payedRemitSum;

@property(nonatomic)NSNumber* returnedFeeSum;
@property(nonatomic)NSNumber* returnedCash;
@property(nonatomic)NSNumber* returnedCard;
@property(nonatomic)NSNumber* returnedRemit;

@property(nonatomic)NSNumber* ownedFeeSum;
@property(nonatomic)NSNumber* expenseSum;
@property(nonatomic)NSNumber* returnGoodsFee;
@property(nonatomic)NSString* created;
@property(nonatomic)NSString* reportDate;

@property(nonatomic )NSArray* ownedCustomers;
@property(nonatomic )NSArray* returnedCustomers;
@property(nonatomic )NSArray* expenseSubList;

@property(nonatomic)NSNumber* numberInStock;
@property(nonatomic)NSNumber* moneyInStock;

@property(nonatomic)NSNumber* moneyShouldGather;
@property(nonatomic)NSNumber* moneyShouldPay;
@property(nonatomic)NSNumber* sumTotal;


@end
