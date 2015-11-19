//
//  ZExpenseService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZExpenseRecord.h"
#import "ZExpenseRecordSubExp.h"
#import "ZItemExpenseDTO.h"
#import "ZQueryExpenseConditionDTO.h"

@interface ZExpenseService : NSObject

-(void)addExpenseRecord:(ZExpenseRecord*)dto1 type:(id)delegate;

-(void)queryExpenseRecordList:(ZConditionDTO*)dto type:(id)delegate;

-(void)queryRecordDetail:(NSNumber*)recordId type:(id)delegate;

-(void)deleteRecord:(NSNumber *)recordId type:(id)delegate;

-(void)deleteExpenseSub:(NSNumber *)recordId type:(id)delegate;

-(void)queryExpenseRecordSubsList:(ZQueryExpenseConditionDTO *)dto type:(id)delegate;
@end
