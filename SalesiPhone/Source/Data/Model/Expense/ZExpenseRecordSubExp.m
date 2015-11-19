//
//  ZExpenseRecordSubExp.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZExpenseRecordSubExp.h"

@implementation ZExpenseRecordSubExp

-(void)dealloc
{
    _itemExpense = nil;
}
-(NSString*)created{
    NSRange range = NSMakeRange(5,5);
    if (_created) {
        if(_created.length > 7) {
            NSString* creatDate = [_created substringWithRange:range];
            return creatDate;
        }
    }
    return _created;
}

@end
