//
//  ZReportDailySumPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-10-16.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZDataPage.h"

@interface ZReportDailySumPage : ZDataPage

@property(nonatomic )NSArray* dailyReports;
@property(nonatomic )NSNumber* totalSaledCount; // 累计售出
@property(nonatomic )NSNumber* totalReturnedCount; // 累计退货
@property(nonatomic )NSNumber* totalSaledTotalFee; // 累计营业额
@property(nonatomic )NSNumber* totalSaledTotalProfit;
@property(nonatomic )NSNumber* totalSaledTotalItemFee; // 累计实收
@property(nonatomic )NSNumber* totalReturnedFeeSum; // 累计还款
@property(nonatomic )NSNumber* totalExpenseSum; // 累计支出
@property(nonatomic )NSNumber* totalSumTotal; // 累计小计



@end
