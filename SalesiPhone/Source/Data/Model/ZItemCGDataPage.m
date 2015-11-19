//
//  ZItemCGDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-21.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemCGDataPage.h"
#import "ZItemCGOrderDTO.h"
@implementation ZItemCGDataPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZItemCGDataPage--dealloc-");
    _itemCGOrderDTOs = nil;
}
+ (Class)itemCGOrderDTOs_class { // used by Jastor
	return [ZItemCGOrderDTO class];
}
@end
