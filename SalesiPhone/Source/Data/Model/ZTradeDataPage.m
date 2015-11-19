//
//  ZTradeDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTradeDataPage.h"
#import "ZTradeDTO.h"
@implementation ZTradeDataPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZTradeDataPage--dealloc-");
    _tradeDTOs = nil;
}

+ (Class)tradeDTOs_class { // used by Jastor
	return [ZTradeDTO class];
}

@end
