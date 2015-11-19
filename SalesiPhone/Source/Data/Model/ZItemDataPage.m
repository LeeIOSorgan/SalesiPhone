//
//  ZItemDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemDataPage.h"
#import "ZItemDTO.h"

@implementation ZItemDataPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZItemDataPage--dealloc-");
    _itemDTOs = nil;
    _totalCount = nil;
    _totalCount = nil;
}

+ (Class)itemDTOs_class { // used by Jastor
	return [ZItemDTO class];
}

@end
