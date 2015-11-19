//
//  ZCustomerService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-23.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCustomerDTO;
@class ZQueryItemConditionDTO;

@interface ZCustomerService : NSObject

-(void)queryAllCustomers:(NSMutableDictionary*)params type:(id)delegate;
-(void)queryCustomerDetails:(NSNumber*)customerId type:(id)delegate;
-(void)createCustomer:(ZCustomerDTO*)customer1 type:(id)delegate;
-(void)modifyCustomer:(ZCustomerDTO*)customer1 type:(id)delegate;
-(void)queryCustomerAccount:(NSNumber*)customerId type:(id)delegate;
-(void)changeCustomer:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;
-(void)queryCustomerSaleStatistic:(ZQueryItemConditionDTO*)params type:(id)delegate ;

@end
