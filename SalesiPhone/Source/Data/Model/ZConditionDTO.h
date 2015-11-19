//
//  ZConditionDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-11.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZConditionDTO : Jastor

@property(nonatomic)NSNumber* shopId;
@property(nonatomic)NSString* begin_time;
@property(nonatomic)NSString* end_time;
@property(nonatomic)NSNumber* pageNo;
@property(nonatomic)NSNumber* pageSize;
@property(nonatomic)NSString* sortField;
@property(nonatomic)NSString* sortDirection;
@property(nonatomic)NSString* timeType;

@end
