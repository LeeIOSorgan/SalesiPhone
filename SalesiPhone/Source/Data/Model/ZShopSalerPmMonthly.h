//
//  ZShopSalerPmMonthly.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-2-25.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZShopSalerPmMonthly : Jastor
@property(nonatomic)NSNumber* shopId;
@property(nonatomic)NSNumber* salerId;
@property(nonatomic)NSString* salerName;
@property(nonatomic)NSString* created;

@property(nonatomic)NSNumber* sale;
@property(nonatomic)NSNumber* profit;

@property(nonatomic)NSNumber* downSalerCount;
@property(nonatomic)NSNumber* sumfee;
@property(nonatomic)NSNumber* sumfeeSecond;
@property(nonatomic)NSNumber* sumfeeThird;



@end
