//
//  ZReportService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-14.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZDailyReportDTO;
@class ZConditionDTO;

@interface ZReportService : NSObject

-(void)queryDailyReport:(NSString*)date type:(id)delegate;
-(void)queryDailySumReport:(ZConditionDTO*)dto type:(id)delegate;
-(void)checkedDailyReport:(ZDailyReportDTO*)dto type:(id)delegate;

@end
