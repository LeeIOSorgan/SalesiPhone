//
//  ZItemDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemDTO : Jastor

@property(nonatomic)NSNumber* itemId;
@property(nonatomic)NSString* shopName;
@property(nonatomic)NSString* kuanHao;
@property(nonatomic)NSString* itemCompany;
@property(nonatomic)NSString* name;
@property(nonatomic)NSNumber* itemCategoryId;
@property(nonatomic)NSString* itemCategory;
@property(nonatomic)NSNumber* itemSeasonId;
@property(nonatomic)NSString* itemSeason;
@property(nonatomic)NSNumber* buyerPrice;
@property(nonatomic)NSNumber* salePrice;
@property(nonatomic)NSNumber* pointValue;
@property(nonatomic)NSString* created;
@property(nonatomic)NSString* updatedOn;

//@property(nonatomic)NSString* color;
//@property(nonatomic)NSString* size;
@property(nonatomic)NSNumber* total;// 采购货品
@property(nonatomic)NSNumber* inCount;
@property(nonatomic)NSNumber* addCount;

@property(nonatomic)NSNumber* outCount;
@property(nonatomic)NSNumber* saledCount;

@property(nonatomic)NSNumber* remainCount;
@property(nonatomic)NSNumber* countError;

@property(nonatomic)NSString* pictureUrl;
@property(nonatomic)NSString* syncTime;
@property(nonatomic)NSMutableArray* skuPropertyDTOs;
@property(nonatomic)NSString* memo;
@property(nonatomic)BOOL used;

@property(nonatomic)NSNumber* disCount;
@property(nonatomic)NSNumber* decanteDuration;
@property(nonatomic)NSNumber* itemBrandId;
@property(nonatomic)NSString* itemBrand;
@property(nonatomic)NSNumber* itemType;

@end
