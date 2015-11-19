//
//  ZShopSalerDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-2-25.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZShopSalerDTO : Jastor

@property (nonatomic ) NSNumber *salerId;
@property(nonatomic ) NSString *name;
@property(nonatomic ) NSString *nickName;

@property (nonatomic ) NSNumber *upSalerId;
@property(nonatomic ) NSString *upSalerName;
@property (nonatomic ) NSNumber *shopId;

@property(nonatomic ) NSString *sfzm;
@property(nonatomic ) NSString *birthday;
@property(nonatomic ) NSString *telephone;
@property(nonatomic ) NSString *memo;
@property(nonatomic ) NSNumber *totalSales;
@property(nonatomic ) NSNumber *downSalerCount;
@property(nonatomic ) NSString *mdAddress;
@property(nonatomic ) NSString *syncTime;
@property(nonatomic ) BOOL used;

@end
