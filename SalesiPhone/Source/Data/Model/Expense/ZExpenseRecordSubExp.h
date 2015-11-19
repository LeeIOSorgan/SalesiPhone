//
//  ZExpenseRecordSubExp.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"
@class ZItemExpenseDTO;

@interface ZExpenseRecordSubExp : Jastor

@property(nonatomic)NSNumber* rowid;
@property(nonatomic)ZItemExpenseDTO* itemExpense;
@property(nonatomic)NSString* name;
@property(nonatomic)NSNumber* itemPrice;
@property(nonatomic)NSNumber* total;
@property(nonatomic)NSNumber* disCount;
@property(nonatomic)NSNumber* totalCount;
@property(nonatomic)NSString* created;

@end
