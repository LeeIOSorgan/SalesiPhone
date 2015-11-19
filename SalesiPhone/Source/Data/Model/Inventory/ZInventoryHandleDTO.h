//
//  ZInventoryHandleRecord.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-29.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZInventoryHandleDTO : Jastor

@property(nonatomic)NSNumber* itemId;
@property(nonatomic)NSString* memo;

@property(nonatomic)NSString* kuanHao;
@property(nonatomic)NSString* name;

@property(nonatomic)NSNumber* inventoryCount;
@property(nonatomic)NSNumber* itemCount;
@property(nonatomic)NSString* createdOn;

@end
