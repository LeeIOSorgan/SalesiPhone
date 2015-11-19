//
//  ZOthersService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-24.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZOthersService.h"
#import "ZShopInfoDTO.h"
#import "ZType.h"
#import "HttpParam.h"
#import "HttpManager.h"
#import "ZRegisterDeviceDTO.h"

@implementation ZOthersService

-(void)queryShopInfo:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlShopInfo;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZShopInfoDTO";
    hp.delegate = delegate;  
    hp.type = kShopInfo_Qry;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)saveShopInfo:(ZShopInfoDTO*)shopInfo type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlShopInfo;
    hp.strMethod = @"POST";
    hp.respClassType=@"ZShopInfoDTO";
    hp.delegate = delegate;  
    hp.requestObj = shopInfo;
    hp.type = kShopInfo_Save;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)registerDeviceWithCode:(ZRegisterDeviceDTO*)dto type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlRegisterDevice;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.requestObj = dto;
    hp.type = kRegisterDevice;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
