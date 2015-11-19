//
//  ZExpenseRecordDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDataPage.h"

@interface ZExpenseRecordDataPage : ZDataPage
@property(nonatomic )NSNumber* totalFee;
@property(nonatomic )NSNumber* totalCount;
@property(nonatomic )NSArray* records;

@end
