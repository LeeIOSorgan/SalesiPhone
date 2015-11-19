//
//  ZOrderDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZOrderDTO.h"
#import "ZSkuPropertyDTO.h"

@implementation ZOrderDTO

//@synthesize total,itemPrice,itemCount;
-(void)dealloc
{
//    ZLogInfo(@"---Into----ZOrderDTO--dealloc-");
    _skuPropertyDTOs = nil;
    _itemCompany = nil;
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
-(void)setSkuPropertyDTOs:(NSMutableArray*)setOrders{
    _skuPropertyDTOs = setOrders;
    int buyNum = 0;
    int rtnNum = 0;
    for (int i=0; i <[setOrders count]; i++) {
        ZSkuPropertyDTO *dishItem = [setOrders objectAtIndex:i];
        if(!_fzItem) {//辅助对象不统计在内
            if([dishItem.count intValue] > 0) {
                buyNum = buyNum + [dishItem.count intValue];
            } else {
                rtnNum = rtnNum + [dishItem.count intValue];
            }
        }
    }
    _buyCount = [[NSNumber alloc]initWithInt:buyNum];
    _returnCount = [[NSNumber alloc]initWithInt:rtnNum];
}
+ (Class)skuPropertyDTOs_class { // used by Jastor
	return [ZSkuPropertyDTO class];
}
@end
