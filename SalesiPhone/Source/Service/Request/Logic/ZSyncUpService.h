//
//  ZSyncUpService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-22.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSyncUpService : NSObject

-(void)syncUpItem:(NSString*)dateStr type:(id)delegate;
-(void)syncUpItemFZ:(NSString*)dateStr type:(id)delegate;
-(void)syncUpCustomer:(NSString*)dateStr type:(id)delegate;
-(void)syncUpUser:(NSString*)dateStr type:(id)delegate;
-(void)syncUpSaler:(NSString*)dateStr type:(id)delegate;
-(void)syncUpSupplier:(NSString*)dateStr type:(id)delegate;
-(void)syncUpCustomerItems:(NSString*)dateStr type:(id)delegate;
@end
