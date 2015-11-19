//
//  ZCustomerSaleRecordDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-4-29.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZCustomerSaleRecordDTO : Jastor

@property(nonatomic )NSNumber* shopId;
@property(nonatomic )NSNumber* itemId;
@property(nonatomic )NSString*  kuanhao;
@property(nonatomic )NSString* itemName;
@property(nonatomic )NSString* customerName;
@property(nonatomic )NSNumber* buyCount;
@property(nonatomic )NSNumber* returnCount;

@end
