//
//  ZExpenseRecordSubExpDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZExpenseRecordSubExpDataPage.h"
#import "ZExpenseRecordSubExp.h"
@implementation ZExpenseRecordSubExpDataPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZItemCGDataPage--dealloc-");
    _subExps = nil;
}

+ (Class)subExps_class { // used by Jastor
	return [ZExpenseRecordSubExp class];
}

@end
