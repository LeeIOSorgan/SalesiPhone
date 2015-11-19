//
//  ZItemCGTradeDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-12.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemCGTradeDTO : Jastor

@property(nonatomic)NSNumber* toShopId;
@property(nonatomic)NSString* toShopName;

@property(nonatomic)NSNumber* tradeId;
@property(nonatomic)NSNumber* companyId;
@property(nonatomic)NSString* company;

@property(nonatomic)NSNumber* cgtradeType;
@property(nonatomic)NSArray* orderDTOs;
@property(nonatomic)NSNumber* totalMoney;
@property(nonatomic)NSNumber* totalCount;
@property(nonatomic ) BOOL deleted;
@property(nonatomic)NSString* created;
@property(nonatomic)NSString* memo;

@property(nonatomic)NSNumber* payedFee;
@property(nonatomic)NSNumber* unpayed;
@property (nonatomic )NSNumber* ownedFee;

@property (nonatomic )NSNumber* payedCash;
@property (nonatomic )NSNumber* payedCard;
@property (nonatomic )NSNumber* payedRemit;

@property (nonatomic )NSNumber* returnedFee;
@property (nonatomic )NSNumber* returnedCash;
@property (nonatomic )NSNumber* returnedCard;
@property (nonatomic )NSNumber* returnedRemit;

@property (nonatomic )NSNumber* balanceFee;
@property (nonatomic )NSNumber* balanceFeeHistory;
//退款
@property (nonatomic )NSNumber* refundFee;

@property(nonatomic ) BOOL accountOnly;

@property(nonatomic ) BOOL printed;

@property(nonatomic)NSNumber* totalBuy;
@property(nonatomic)NSNumber* totalReturn;
@property(nonatomic)NSNumber* status;
@end
