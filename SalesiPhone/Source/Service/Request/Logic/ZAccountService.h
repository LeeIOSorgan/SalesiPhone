//
//  ZAccountService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-5.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZAccountCompany;
@class ZAccountCustomer;
@class ZQueryAccountDTO;
@interface ZAccountService : NSObject

-(void)queryCusotmerAccount:(ZQueryAccountDTO*)params type:(id)delegate;
-(void)queryCompanyAccount:(ZQueryAccountDTO*)params type:(id)delegate;

-(void)addCustomerAccount:(ZAccountCustomer*)dto type:(id)delegate;
-(void)addCompanyAccount:(ZAccountCompany*)dto type:(id)delegate;

-(void)removeCustomerAccount:(ZAccountCustomer*)dto type:(id)delegate;
-(void)removeCompanyAccount:(ZAccountCompany*)dto type:(id)delegate;


@end
