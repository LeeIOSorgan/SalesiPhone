//
//  ZCustomerDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDataPage.h"

@interface ZCustomerDataPage : ZDataPage

@property(nonatomic )NSArray* customerDTOs;
@property(nonatomic )NSNumber* totalFee; // 累计余额
@property(nonatomic )NSNumber* totalBlance; // 累计余额
@property(nonatomic )NSNumber* totalOwn; // 累计欠款
@property(nonatomic )NSNumber* totalTradeNum; // 累计交易次数



@end
