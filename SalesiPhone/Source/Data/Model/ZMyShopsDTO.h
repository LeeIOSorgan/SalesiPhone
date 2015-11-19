//
//  ZMyShopsDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-11.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@class ZShopDTO;

@interface ZMyShopsDTO : Jastor

@property(nonatomic)ZShopDTO* defaultShop;
@property(nonatomic)NSArray* ownShops;

@end
