//
//  ZSyncBaseData.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-1-9.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"
@class ZShopDTO;

@interface ZSyncBaseData : Jastor

@property(nonatomic,assign)NSArray* itemBrandDTOs;
@property(nonatomic,assign)NSArray* itemExpenseList;
@property(nonatomic,assign)NSArray* itemDiscountDTOs;

@property(nonatomic,assign)NSArray* itemSeason;
@property(nonatomic,assign)NSArray* itemColorDTOs;
@property(nonatomic,assign)NSArray* itemSizeDTOs;
@property(nonatomic,assign)NSArray* itemCategoryList;
@property(nonatomic,assign)NSArray* itemOrderMemoList;
@property(nonatomic,assign)NSArray* shopDTOs;
@property(nonatomic,assign)ZShopDTO* myShop;

@end
