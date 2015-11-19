//
//  ZReportDailySumPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-10-16.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZReportDailySumPage.h"
#import "ZDailyReportDTO.h"
@implementation ZReportDailySumPage
-(void)dealloc
{
    ZLogInfo(@"---Into----ZReportDailySumPage--dealloc-");
    _dailyReports = nil;
}

+ (Class)dailyReports_class { // used by Jastor
	return [ZDailyReportDTO class];
}

@end
