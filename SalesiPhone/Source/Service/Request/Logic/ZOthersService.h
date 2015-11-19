//
//  ZOthersService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-24.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZShopInfoDTO;
@class ZRegisterDeviceDTO;
@interface ZOthersService : NSObject


-(void)queryShopInfo:(id)delegate;

-(void)saveShopInfo:(ZShopInfoDTO*)shopInfo type:(id)delegate;

-(void)registerDeviceWithCode:(ZRegisterDeviceDTO*)dto type:(id)delegate;

@end
