//
//  ZSyncBaseData.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-1-9.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZSyncBaseData.h"
#import "ZItemBrandDTO.h"
#import "ZItemExpenseDTO.h"
#import "ZItemDiscountDTO.h"
#import "ZItemCompanyDTO.h"
#import "ZItemColorDTO.h"
#import "ZItemSizeDTO.h"
#import "ZShopDTO.h"
#import "ZItemCategoryDTO.h"
#import "ZItemOrderMemo.h"
#import "ZItemSeason.h"

@implementation ZSyncBaseData

-(void)dealloc
{
    _itemBrandDTOs = nil;
    _itemCategoryList = nil;
    _itemColorDTOs = nil;
    _itemDiscountDTOs = nil;
    _itemExpenseList = nil;
    _itemSizeDTOs = nil;
    _shopDTOs = nil;
    _itemOrderMemoList = nil;
}

+ (Class)itemBrandDTOs_class { // used by Jastor
	return [ZItemBrandDTO class];
}
+ (Class)itemOrderMemoList_class { // used by Jastor
	return [ZItemOrderMemo class];
}
+ (Class)itemExpenseList_class { // used by Jastor
	return [ZItemExpenseDTO class];
}
+ (Class)itemDiscountDTOs_class { // used by Jastor
	return [ZItemDiscountDTO class];
}
+ (Class)itemColorDTOs_class { // used by Jastor
	return [ZItemColorDTO class];
}
+ (Class)itemSizeDTOs_class { // used by Jastor
	return [ZItemSizeDTO class];
}
+ (Class)itemCategoryList_class { // used by Jastor
	return [ZItemCategoryDTO class];
}
+ (Class)shopDTOs_class { // used by Jastor
	return [ZShopDTO class];
}
+ (Class)itemSeason_class { // used by Jastor
    return [ZItemSeason class];
}

@end
