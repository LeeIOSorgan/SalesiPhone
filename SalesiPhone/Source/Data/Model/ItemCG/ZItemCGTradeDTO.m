//
//  ZItemCGTradeDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-12.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemCGTradeDTO.h"
#import "ZItemCGOrderDTO.h"
#import "ZContants.h"

@implementation ZItemCGTradeDTO

-(void)dealloc
{
    ZLogInfo(@"---Into----ZItemCGTradeDTO--dealloc-");
    
    _orderDTOs = nil;
    _cgtradeType = nil;
    _totalCount = nil;
    _totalMoney = nil;
    _payedCard = nil;
    _payedCash = nil;
    _payedFee = nil;
    _payedRemit = nil;
    _memo = nil;
    _refundFee = nil;
    _returnedCard = nil;
    _returnedCash = nil;
    _returnedFee = nil;
    _returnedRemit = nil;
    _balanceFee = nil;
    _balanceFeeHistory = nil;
}
-(void)setOrderDTOs:(NSArray*)setOrders{
    _orderDTOs = setOrders;
    int countNum = 0;
    int countBuy = 0;
    int countReturn = 0;
    for (int i=0; i <[setOrders count]; i++) {
        ZItemCGOrderDTO *dishItem = [setOrders objectAtIndex:i];
//        //调出，返货 必须为负数//[_cgtradeType intValue] ==kItemCGItemIO_Out ||
        if ([_cgtradeType intValue] ==kItemCGItemIO_Out ||[_cgtradeType intValue] ==kItemCGItemIO_Lost)
        {
            if([dishItem.totalCount intValue] > 0)
            {
                countNum = 0;
                break;
            }
        } else if([_cgtradeType intValue] ==kItemCGItemIO_In) {
            if([dishItem.totalCount intValue] < 0)
            {
                countNum = 0;
                break;
            }
        }
        if([dishItem.totalCount intValue] > 0)
        {
            countBuy = countBuy +[dishItem.totalCount intValue];
        }
        if([dishItem.totalCount intValue] < 0)
        {
            countReturn = countReturn +[dishItem.totalCount intValue];
        }
        //辅助货品 不统计
        if(! dishItem.fzItem) {
            countNum = countNum + [dishItem.totalCount intValue];
        }
    }
    _totalCount = [[NSNumber alloc]initWithInt:countNum];
    _totalBuy = [[NSNumber alloc]initWithInt:countBuy];
    _totalReturn = [[NSNumber alloc]initWithInt:countReturn];
}

+ (Class)orderDTOs_class { // used by Jastor
	return [ZItemCGOrderDTO class];
}

-(NSString*)created{
    NSRange range = NSMakeRange(5,11);
    if (_created) {
        if(_created.length > 11) {
            NSString* creatDate = [_created substringWithRange:range];
            return creatDate;
        }
    }
    return _created;
}

@end
