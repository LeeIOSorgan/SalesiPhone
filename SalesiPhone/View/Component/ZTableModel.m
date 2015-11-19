//
//  ZTableModel.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTableModel.h"

@implementation ZTableModel

-(void)dealloc
{
//    ZLogInfo(@"---Into----ZTableModel--dealloc-");
    _title  = nil;
    _key  = nil;
    _actionName  = nil;
    _action = nil;
}

@end
