//
//  ZExpenseRecord.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZExpenseRecord.h"
#import "ZExpenseRecordSubExp.h"

@implementation ZExpenseRecord

-(void)dealloc
{
    _subExps = nil;
}
+ (Class)subExps_class { // used by Jastor
	return [ZExpenseRecordSubExp class];
}

-(NSString*)created
{
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
