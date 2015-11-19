//
//  ZItemCGOrderDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-21.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemCGOrderDTO.h"
#import "ZSkuPropertyDTO.h"
@implementation ZItemCGOrderDTO

-(void)dealloc
{
    ZLogInfo(@"---Into----ZItemCGOrderDTO--dealloc-");
    _kuanHao = nil;
    _itemCompany= nil;
    _itemCategory= nil;
    _name= nil;
    _buyerPrice= nil;
    _memo= nil;
    _totalCount= nil;
    _pictureUrl= nil;
    _itemPrice= nil;
    _created= nil;
    _orderId= nil;
    _itemId= nil;
    //TODO
//    [_skuPropertyDTOs removeAllObjects];
    _skuPropertyDTOs= nil;
    _total= nil;
}

+ (Class)skuPropertyDTOs_class { // used by Jastor
	return [ZSkuPropertyDTO class];
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
-(NSNumber*)totalCount{
    if([_totalCount intValue] != 0) {
        return _totalCount;
    }
    int buyNum = 0;
    int rtnNum = 0;
    int itemCount = 0;
    if([_skuPropertyDTOs count]>0) {
        for(ZSkuPropertyDTO* dto in _skuPropertyDTOs) {
            itemCount = itemCount + [dto.count intValue];
            if(!_fzItem) {//辅助对象不统计在内
                if([dto.count intValue] > 0) {
                    buyNum = buyNum + [dto.count intValue];
                } else {
                    rtnNum = rtnNum + [dto.count intValue];
                }
            }
        }
    }
//    _buyCount = [[NSNumber alloc]initWithInt:buyNum];
//    _returnCount = [[NSNumber alloc]initWithInt:rtnNum];
    _totalCount = [NSNumber numberWithInt: itemCount];
    return _totalCount;
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
