//
//  ZLoginService.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/12/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRequestInc.h"
#import "ZResponse.h"
@class ZShopDeviceRegister;
@class ZShopRegisterDTO;

@interface ZLoginService : NSObject

-(void)login:(NSString*)name pwd:(NSString*)pwd ifDemo:(BOOL)demo type:(id)delegate;
-(void)loginNew:(NSString*)name pwd:(NSString*)pwd ifDemo:(BOOL)demo type:(id)delegate;
-(void)logout;
-(void)pingServer:(id)delegate;
-(void)openShop:(ZShopRegisterDTO*)dto type:(id)delegate;

-(void)queryMyShops:(NSNumber*)shopId type:(id)delegate;
-(void)refreshCurrentShop:(NSNumber*)shopId type:(id)deleaget;

-(void)addDeviceForShop:(ZShopDeviceRegister*)device type:(id)deleaget;

@end
