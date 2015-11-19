//
//  ZReportService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-14.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZReportService.h"
#import "HttpManager.h"
#import "ZRequestInc.h"
#import "ZUtility.h"
#import "ZConditionDTO.h"
#import "ZDailyReportDTO.h"

@implementation ZReportService

-(void)queryDailyReport:(NSString*)date type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"timeType=%@", @"today"];
    hp.strUrl = [NSString stringWithFormat:urlReportDaily, date];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZDailyReportDTO";
    hp.requestObj = date;
    hp.delegate = delegate;
    
    hp.type = kReport_Daily;
    ZLogInfo(@"Request Service queryDailyReport type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryDailySumReport:(ZConditionDTO*)dto type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"timeType=%@", @"today"];
    hp.strUrl = urlReportDailySum;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZReportDailySumPage";
    hp.requestObj = dto;
    hp.delegate = delegate;
    
    hp.type = kReport_Daily_sumQuery;
    ZLogInfo(@"Request Service queryDailySumReport type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)checkedDailyReport:(ZDailyReportDTO*)dto type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"timeType=%@", @"today"];
    hp.strUrl = [NSString stringWithFormat:urlReportDaily_checked, dto.rowid];
    hp.strMethod = @"POST";
//    hp.respClassType =@"ZDailyReportDTO";
    hp.requestObj = dto;
    hp.delegate = delegate;
    
    hp.type = kReport_Daily_checked;
    ZLogInfo(@"Request Service checkedDailyReport type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
