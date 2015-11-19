//
//  ZItemCGDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-21.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"
#import "ZDataPage.h"
@interface ZItemCGDataPage : ZDataPage

@property(nonatomic )NSNumber* totalFee;
@property(nonatomic )NSNumber* totalCost;
@property(nonatomic )NSNumber* totalCount;
@property(nonatomic )NSArray* itemCGOrderDTOs;

@end
