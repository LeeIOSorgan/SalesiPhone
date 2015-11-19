//
//  ZExpenseRecord.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZExpenseRecord : Jastor
@property(nonatomic)NSNumber* rowid;
@property(nonatomic)NSNumber* totalCount;
@property(nonatomic)NSString* memo;
@property(nonatomic)NSNumber* totalMoney;
@property(nonatomic)NSNumber* payedFee;
@property(nonatomic)NSNumber* payedCash;
@property(nonatomic)NSNumber* payedCard;
@property(nonatomic)NSNumber* payedRemit;
@property(nonatomic)NSNumber* unpayed;
@property(nonatomic)NSMutableArray* subExps;
@property(nonatomic)NSString* pici;
@property(nonatomic) BOOL  printed;
@property(nonatomic)NSString* lsh;
@property(nonatomic)NSString* created;
@end
