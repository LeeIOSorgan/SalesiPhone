//
//  ZItemExpenseDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemExpenseDTO : Jastor

@property(nonatomic )NSNumber* rowid;
@property(nonatomic )NSString* name;
@property(nonatomic )NSNumber* price;
@property(nonatomic )BOOL used;

@end
