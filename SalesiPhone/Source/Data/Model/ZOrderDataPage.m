//
//  ZOrderDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZOrderDataPage.h"
#import "ZOrderDTO.h"
@implementation ZOrderDataPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZOrderDTO--dealloc-");
    _orderDTOs = nil;
}

+ (Class)orderDTOs_class { // used by Jastor
	return [ZOrderDTO class];
}

@end
