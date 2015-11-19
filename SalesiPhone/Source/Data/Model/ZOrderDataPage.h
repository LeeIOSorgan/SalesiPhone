//
//  ZOrderDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDataPage.h"

@interface ZOrderDataPage : ZDataPage
@property(nonatomic )NSMutableArray* orderDTOs;
@property(nonatomic )NSNumber* totalCount;
@property(nonatomic )NSNumber* totalFee;
@property(nonatomic )NSNumber* totalSaledCount;
@property(nonatomic )NSNumber* totalReturnedCount;

@end
