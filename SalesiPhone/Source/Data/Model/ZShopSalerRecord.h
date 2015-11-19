//
//  ZShopSalerRecord.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-2-25.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZShopSalerRecord : Jastor
@property(nonatomic)NSNumber* shopId;
@property(nonatomic)NSNumber* tradeId;

@property(nonatomic)NSNumber* sale;
@property(nonatomic)NSNumber* profit;
@property(nonatomic)NSNumber* downSalerCount;
@property(nonatomic)NSNumber* rate;
@property(nonatomic)NSNumber* fee;
@property(nonatomic)NSNumber* downSalerCountSecond;
@property(nonatomic)NSNumber* rateSecond;
@property(nonatomic)NSNumber* feeSecond;
@property(nonatomic)NSNumber* downSalerCountThird;
@property(nonatomic)NSNumber* rateThird;
@property(nonatomic)NSNumber* feeThird;

@property(nonatomic)NSString* salerName;
@property(nonatomic)NSNumber* salerId;
@property(nonatomic)NSString* salerSecName;
@property(nonatomic)NSNumber* salerSecId;
@property(nonatomic)NSString* salerThdName;
@property(nonatomic)NSNumber* salerThdId;

@property(nonatomic)NSString* created;
@end
