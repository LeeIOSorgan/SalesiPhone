//
//  ZAccountCompany.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-5.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZAccountCompany : Jastor

@property(nonatomic)NSNumber* coAccountId;
@property(nonatomic)NSNumber* itemCompanyId;
@property(nonatomic)NSNumber* tradeId;

@property(nonatomic)NSString* memo;
@property(nonatomic)NSString* created;
@property(nonatomic)NSString* name;
@property(nonatomic)NSString* contactName;
@property(nonatomic)NSString* telephone;

@property(nonatomic)NSNumber* ownedFee;
@property(nonatomic)NSNumber* shouldPay;
@property(nonatomic)NSNumber* payedFee;

@property (nonatomic )NSNumber* payedCash;
@property (nonatomic )NSNumber* payedCard;
@property (nonatomic )NSNumber* payedRemit;

@property (nonatomic )NSNumber* unpayStill;
@property(nonatomic)NSNumber* balanceFee;


@end
