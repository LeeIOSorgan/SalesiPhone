//
//  ZItemInventoryService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZQueryItemConditionDTO;
@class ZItemInventoryDTO;

@interface ZItemInventoryService : NSObject

-(void)addInventories:(NSArray*)orders1 type:(id)delegate;

-(void)queryInventories:(ZQueryItemConditionDTO*)dto1 type:(id)delegate;
-(void)queryUnInventoryItems:(ZQueryItemConditionDTO*)dto1 type:(id)delegate;

-(void)inventoryStart:(id)delegate;

-(void)inventoryHandle:(ZItemInventoryDTO*)dto1 memo:(NSString*)memo type:(id)delegate;
-(void)queryInventoryRecords:(ZQueryItemConditionDTO*)dto1 type:(id)delegate;

@end
