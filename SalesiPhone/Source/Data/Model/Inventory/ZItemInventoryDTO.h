//
//  ZItemCGOrderDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-21.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemInventoryDTO : Jastor

@property(nonatomic)NSNumber* orderId;
@property(nonatomic)NSNumber* itemId;
@property(nonatomic)NSString* kuanHao;
@property(nonatomic)NSString* name;
@property(nonatomic)NSString* memo;
@property(nonatomic)NSNumber* totalCount;
@property(nonatomic)NSNumber* totalItemCount;
@property(nonatomic)NSArray* skuPropertyDTOs;

@property(nonatomic)NSArray* itemSkuPropertyDTOs;
@property(nonatomic)BOOL hasError;


@end
