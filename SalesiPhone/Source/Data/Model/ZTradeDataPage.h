//
//  ZTradeDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDataPage.h"

@interface ZTradeDataPage : ZDataPage

@property (nonatomic,  retain) NSMutableArray *tradeDTOs;
@property (nonatomic ) NSNumber* totalCount;
@property (nonatomic ) NSNumber* totalSaledCount;
@property (nonatomic ) NSNumber* totalReturnedCount;

@property(nonatomic )NSNumber* totalSaleFee;
@property(nonatomic )NSNumber* totalPayFee;
@property(nonatomic )NSNumber* totalUnPayFee;

@property(nonatomic )NSNumber* totalProfit;
@end
