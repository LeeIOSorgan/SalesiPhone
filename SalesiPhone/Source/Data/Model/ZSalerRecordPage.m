//
//  ZSalerRecordPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-2-25.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZSalerRecordPage.h"
#import "ZShopSalerRecord.h"
#import "ZShopSalerPmMonthly.h"

@implementation ZSalerRecordPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZSalerRecordPage--dealloc-");
    _salerRecords = nil;
}

+ (Class)salerRecords_class { // used by Jastor
	return [ZShopSalerRecord class];
}


+ (Class)salerMonthlyRecords_class { // used by Jastor
	return [ZShopSalerPmMonthly class];
}
@end
