//
//  ZItemCGOrderDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-21.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemCGOrderDTO : Jastor

@property(nonatomic)NSString* kuanHao;
@property(nonatomic)NSString* itemCompany;

@property(nonatomic)NSNumber* itemBrandId;
@property(nonatomic)NSString* itemBrand;

@property(nonatomic)NSNumber* itemCategoryId;
@property(nonatomic)NSString* itemCategory;
@property(nonatomic)NSString* name;
@property(nonatomic)NSString* memo;
@property(nonatomic)NSString* pictureUrl;
@property(nonatomic)NSString* created;
@property(nonatomic)NSNumber* orderId;
@property(nonatomic)NSNumber* itemId;
@property(nonatomic)NSNumber* disCount;
@property(nonatomic)NSArray* skuPropertyDTOs;
@property(nonatomic)Boolean fzItem;

@property(nonatomic)NSNumber* buyerPrice;
@property(nonatomic)NSNumber* itemPrice;
@property(nonatomic)NSNumber* total;
@property(nonatomic)NSNumber* totalCount;
//@property(nonatomic)NSNumber* buyCount;
//@property(nonatomic)NSNumber* returnCount;


@end
