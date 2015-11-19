//
//  ZItemCGOrderDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-21.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemInventoryDTO.h"
#import "ZSkuPropertyDTO.h"
@implementation ZItemInventoryDTO

-(void)dealloc
{
//    ZLogInfo(@"---Into----ZItemCGOrderDTO--dealloc-");
    _kuanHao = nil;
    _name= nil;
    _memo= nil;
    _orderId= nil;
    _itemId= nil;
    _skuPropertyDTOs= nil;
}

+ (Class)skuPropertyDTOs_class { // used by Jastor
	return [ZSkuPropertyDTO class];
}


+ (Class)itemSkuPropertyDTOs_class { // used by Jastor
	return [ZSkuPropertyDTO class];
}


//输入的日期字符串形如：@"1992-05-21 13:08:08"
- (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];

    NSDate *destDate= [dateFormatter dateFromString:dateString];
//    [dateFormatter release];
    return destDate;
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
//    [dateFormatter release];
    return destDateString;
}

@end
