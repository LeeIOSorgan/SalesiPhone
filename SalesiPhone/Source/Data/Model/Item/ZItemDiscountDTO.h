//
//  ZItemDiscountDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-16.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemDiscountDTO : Jastor
@property(nonatomic )NSNumber* rowid;
@property (nonatomic )NSNumber* discount;
@property (nonatomic )BOOL used;
@property (nonatomic )BOOL system;

@end
