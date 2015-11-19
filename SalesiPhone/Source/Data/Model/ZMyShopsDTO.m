//
//  ZMyShopsDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-11.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZMyShopsDTO.h"
#import "ZShopDTO.h"

@implementation ZMyShopsDTO

-(void)dealloc
{
    _ownShops = nil;
}
+ (Class)ownShops_class { // used by Jastor
	return [ZShopDTO class];
}
@end
