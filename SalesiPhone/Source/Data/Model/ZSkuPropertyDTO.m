//
//  ZSkuPropertyDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-25.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZSkuPropertyDTO.h"

@implementation ZSkuPropertyDTO

-(void)dealloc
{
//    ZLogInfo(@"---Into----ZSkuPropertyDTO--dealloc-");
    _itemColor = nil;
    _itemColorId = nil;
    _itemSize = nil;
    _itemSizeId = nil;
    _pictureUrl = nil;
    _created = nil;
    _count = nil;
}
@end
