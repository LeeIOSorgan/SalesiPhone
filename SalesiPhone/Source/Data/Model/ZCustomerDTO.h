//
//  ZCustomerDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZCustomerDTO : Jastor

@property(nonatomic )NSNumber* customerId;
@property(nonatomic )NSString*  name;
@property(nonatomic )NSString* province;
@property(nonatomic )NSString* city;
@property(nonatomic )NSString* area;

@property(nonatomic )NSString* telephone;
@property(nonatomic )NSString* address;
@property(nonatomic )NSString* lastestTradeTime;
@property(nonatomic )NSNumber*  tradeCount;
@property(nonatomic )NSString* memo;
@property(nonatomic )NSNumber* kuaidiId;
@property(nonatomic )NSString* kuaiDiName;
@property(nonatomic )NSString* syncTime;
@property(nonatomic )NSString* created;
@property(nonatomic )BOOL used;

@property (nonatomic )NSNumber* balanceFee;
@property(nonatomic )NSNumber*  shouldPayFee;
@property(nonatomic )NSNumber*  unpayedFee;
@property(nonatomic )NSNumber*  payedFee;

@property(nonatomic )NSNumber*  unpayStill;

@property(nonatomic )NSNumber*  payedCash;
@property(nonatomic )NSNumber*  payedCard;
@property(nonatomic )NSNumber*  payedRemit;

@property(nonatomic )NSNumber*  shopSalerId;
@property(nonatomic )NSString*  salerName;

@property(nonatomic )NSNumber*  point;


@end
