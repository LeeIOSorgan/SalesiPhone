//
//  ZCustomerPrintInfoDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-10-9.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZCustomerPrintInfoDTO.h"

@implementation ZCustomerPrintInfoDTO
-(void)dealloc
{
    ZLogInfo(@"---Into----ZCustomerPrintInfoDTO--dealloc--");
    _customerId = nil;
}

+ (Class)customerIds_class { // used by Jastor
	return [NSNumber class];
}
@end
