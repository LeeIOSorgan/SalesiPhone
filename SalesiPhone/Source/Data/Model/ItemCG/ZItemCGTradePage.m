//
//  ZItemCGTradeDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-13.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemCGTradePage.h"
#import "ZItemCGTradeDTO.h"
#import "ZTradeDTO.h"
@implementation ZItemCGTradePage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZItemCGDataPage--dealloc-");
    _itemCGTradeDTOs = nil;
}
+ (Class)itemCGTradeDTOs_class { // used by Jastor
	return [ZItemCGTradeDTO class];
}

@end
