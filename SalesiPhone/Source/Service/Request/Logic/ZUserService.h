//
//  ZUserService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-16.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRequestInc.h"
#import "ZResponse.h"
#import "ZUserDTO.h"

@class ZQueryItemConditionDTO;
@class ZShopSalerDTO;
@interface ZUserService : NSObject

-(void)queryUsers:(NSMutableDictionary*)params type:(id)delegate;
-(void)addUser:(ZUserDTO*)user1 type:(id)delegate;
-(void)enableUser:(NSNumber*)userId type:(id)delegate;
-(void)changeUserPwd:(ZUserDTO*)user type:(id)delegate;

-(void)disableUser:(NSNumber*)userId type:(id)delegate;
-(void)resetUserPwd:(NSNumber*)userId type:(id)delegate;
-(void)queryLoginAccount:(id)delegate;
-(void)updateLoginUser:(ZUserDTO*)user1 type:(id)delegate;

-(void)querySaler:(ZQueryItemConditionDTO*)conditionDTO type:(id)delegate;
-(void)addSaler:(ZShopSalerDTO*)user1 type:(id)delegate;
-(void)updateSaler:(ZShopSalerDTO*)user1 type:(id)delegate;
-(void)deleteSaler:(ZShopSalerDTO*)user1 type:(id)delegate;
-(void)cleanSaledFee:(NSNumber*)userId type:(id)delegate;


-(void)querySalerRecords:(ZQueryItemConditionDTO*)conditionDTO type:(id)delegate;
-(void)querySalerMonthlyRecords:(ZQueryItemConditionDTO*)conditionDTO type:(id)delegate;

@end
