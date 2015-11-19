//
//  ZQueryItemConditionDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-11.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZConditionDTO.h"

@interface ZQueryItemConditionDTO : ZConditionDTO

@property(nonatomic)NSString* kuanHao;
@property(nonatomic)NSString* itemName;
@property(nonatomic)NSString* itemCompany;
@property(nonatomic)NSString* itemBrand;
@property(nonatomic)NSString* category;
@property(nonatomic)NSString* timeType;
@property(nonatomic)BOOL used;
@property(nonatomic)NSNumber* itemType;
@property(nonatomic)NSNumber* tradeType;
@property(nonatomic)BOOL hasError;
@property(nonatomic)NSNumber* customerId;
@property(nonatomic)NSNumber* salerId;
@property(nonatomic)NSNumber* itemId;
@property(nonatomic)BOOL deleted;
@property(nonatomic)BOOL onlyReturn;
@property(nonatomic)NSNumber* queryType;
@property(nonatomic)NSNumber* status;
@property(nonatomic)BOOL queryNagative;
@end
