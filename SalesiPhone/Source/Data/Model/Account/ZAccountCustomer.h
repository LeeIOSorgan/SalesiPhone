//
//  ZAccountCustomer.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-5.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZAccountCustomer : Jastor
@property(nonatomic)NSNumber* coAccountId;
@property(nonatomic)NSNumber* customerId;
@property(nonatomic)NSNumber* tradeId;
@property(nonatomic)NSString* name;
@property(nonatomic)NSString* telephone;
@property(nonatomic)NSString* memo;
@property(nonatomic)NSString* created;

@property(nonatomic)NSNumber* shouldRepay;
@property(nonatomic)NSNumber* payedFee;
@property(nonatomic)NSNumber* unpayedFee;

@property (nonatomic )NSNumber* payedCash;
@property (nonatomic )NSNumber* payedCard;
@property (nonatomic )NSNumber* payedRemit;
@property(nonatomic)NSNumber* refundFee;//退款

@property(nonatomic)NSNumber* balanceFee;
@property(nonatomic)NSNumber* unpayStill;


@property(nonatomic)NSNumber* tradeType;

@end
