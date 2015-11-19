//
//  ZAccountCompanyPage.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-5.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZAccountCompanyPage.h"
#import "ZAccountCompany.h"
@implementation ZAccountCompanyPage

-(void)dealloc
{
    ZLogInfo(@"---Into----ZAccountCompanyPage--dealloc-");
    _coAccountDTOs = nil;
}

+ (Class)coAccountDTOs_class { // used by Jastor
	return [ZAccountCompany class];
}


@end
