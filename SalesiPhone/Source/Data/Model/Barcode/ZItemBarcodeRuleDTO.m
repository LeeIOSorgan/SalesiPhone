//
//  ZItemBarcodeRuleDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14/11/5.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZItemBarcodeRuleDTO.h"
#import "ZBarcodeRuleDTO.h"

@implementation ZItemBarcodeRuleDTO


-(void)dealloc
{
    ZLogInfo(@"---Into----ZCustomerDataPage--dealloc-");
    _barcodeRules = nil;
}

+ (Class)barcodeRules_class { // used by Jastor
	return [ZBarcodeRuleDTO class];
}

@end
