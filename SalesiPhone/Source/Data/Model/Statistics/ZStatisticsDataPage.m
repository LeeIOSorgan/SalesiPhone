//
//  ZStatisticsDataPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-17.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZStatisticsDataPage.h"
#import "ZStatisticsDTO.h"
@implementation ZStatisticsDataPage

-(void)dealloc
{
    _returnValues = nil;
}
+ (Class)returnValues_class { // used by Jastor
	return [ZStatisticsDTO class];
}

@end
