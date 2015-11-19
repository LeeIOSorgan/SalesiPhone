//
//  ZSalerRecordPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-2-25.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZDataPage.h"

@interface ZSalerRecordPage : ZDataPage

@property(nonatomic )NSArray* salerRecords;
@property(nonatomic )NSArray* salerMonthlyRecords;
@property(nonatomic )NSNumber* totalFee;
@property(nonatomic )NSNumber* totalFeeSecond;
@property(nonatomic )NSNumber* totalFeeThird;

@end
