//
//  ZCustomerSalerRecordPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-4-29.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZCustomerSalerRecordPage.h"
#import "ZCustomerSaleRecordDTO.h"

@implementation ZCustomerSalerRecordPage

-(void)dealloc {
    _returnValues = nil;
}
+ (Class)returnValues_class { // used by Jastor
	return [ZCustomerSaleRecordDTO class];
}

@end
