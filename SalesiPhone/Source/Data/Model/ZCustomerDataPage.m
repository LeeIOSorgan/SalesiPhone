//
//  ZCustomerDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZCustomerDataPage.h"
#import "ZCustomerDTO.h"
@implementation ZCustomerDataPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZCustomerDataPage--dealloc-");
    _customerDTOs = nil;
}

+ (Class)customerDTOs_class { // used by Jastor
	return [ZCustomerDTO class];
}
@end
