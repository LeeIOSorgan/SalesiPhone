//
//  ZDailyReportDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-14.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDailyReportDTO.h"
#import "ZCustomerDTO.h"
#import "ZExpenseRecordSubExp.h"
@implementation ZDailyReportDTO
-(void)dealloc
{
    _ownedCustomers = nil;
    _returnedCustomers = nil;
    _expenseSubList = nil;
}
-(NSString*)created{
    NSRange range = NSMakeRange(5,11);
    if (_created) {
        if(_created.length > 7) {
            NSString* creatDate = [_created substringWithRange:range];
            return creatDate;
        }
    }
    return _created;
}
-(NSString*)reportDate{
    NSRange range = NSMakeRange(0,10);
    if (_reportDate) {
        if(_reportDate.length > 7) {
            NSString* creatDate = [_reportDate substringWithRange:range];
            return creatDate;
        }
    }
    return _reportDate;
}

+ (Class)ownedCustomers_class { // used by Jastor
	return [ZCustomerDTO class];
}
+ (Class)returnedCustomers_class { // used by Jastor
	return [ZCustomerDTO class];
}

+ (Class)expenseSubList_class { // used by Jastor
	return [ZExpenseRecordSubExp class];
}

@end
