//
//  ZExpenseRecordDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZExpenseRecordDataPage.h"
#import "ZExpenseRecord.h"

@implementation ZExpenseRecordDataPage

-(void)dealloc
{
    _records = nil;
}

+ (Class)records_class { // used by Jastor
	return [ZExpenseRecord class];
}

@end
