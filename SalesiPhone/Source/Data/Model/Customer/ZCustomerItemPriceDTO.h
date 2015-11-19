//
//  ZCustomerItemPriceDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-10-19.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZCustomerItemPriceDTO : Jastor

@property(nonatomic )NSNumber* itemId;
@property(nonatomic )NSNumber* customerId;
@property(nonatomic )NSNumber* lastPrice;
@property(nonatomic )NSNumber* lastDiscount;
@property(nonatomic )BOOL used;
@property(nonatomic)NSString* created;

@end
