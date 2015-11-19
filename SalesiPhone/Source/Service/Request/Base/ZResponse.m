//
//  ZResponse.m
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/6/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZResponse.h"

@implementation ZResponse

- (id)init
{
    if (self = [super init]){
        _code = [[ZCode alloc] init];
    }
    
    return self;
}

-(void)dealloc
{
    ZLogInfo(@"---Into----ZResponse--dealloc--");
    _code  = nil;
    _data  = nil;
    _respObj  = nil;
    [_mutDic removeAllObjects];
    _mutDic  = nil;
    _text  = nil;
    _respClassType  = nil;
}

@end
