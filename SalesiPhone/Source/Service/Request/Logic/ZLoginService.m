//
//  ZLoginService.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/12/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZLoginService.h"
#import "ZMD5Util.h"
#import "ZMacAddress.h"
#import "HttpManager.h"
#import "ZShopDeviceRegister.h"
#import "ZShopRegisterDTO.h"

@implementation ZLoginService

-(void)login:(NSString*)name pwd:(NSString*)pwd ifDemo:(BOOL)demo type:(id)delegate{
    
    HttpParam* hp = [[HttpParam alloc] init];
    [hp makeLoginHead];
    hp.strUrl = [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"login"];
    hp.strMethod = @"POST";
    
    pwd = [ZMD5Util getMD5pwd:pwd];
    NSString *mac = [ZMacAddress getDeviceId];// [ZMacAddress getUUID];
    if (demo) {
//        mac = @"adsdfssess8893";kll
        mac = @"1122334455FF";
    } else if ([name isEqualToString:@"ZTaoTech"]) {
        mac =@"539821B3-E483-4674-8298-DDC3FCA80D25";
    }
    hp.strBody = [NSString stringWithFormat:@"username=%@&password=%@&mac_addr=%@", name, pwd, mac];
    hp.respClassType =@"ZUserDTO";
    hp.type = kLogin;//kLogin
    hp.delegate = delegate;
     
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)loginNew:(NSString*)name pwd:(NSString*)pwd ifDemo:(BOOL)demo type:(id)delegate{
    
    HttpParam* hp = [[HttpParam alloc] init];
    [hp makeLoginHead];
    hp.strUrl = [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"persistLogin"];
    hp.strMethod = @"POST";
    
    pwd = [ZMD5Util getMD5pwd:pwd];
    NSString *mac = [ZMacAddress getDeviceId];// [ZMacAddress getUUID];
    if (demo) {
        mac = @"1122334455FF";
    } else if ([name isEqualToString:@"ZTaoTech"]) {
        mac =@"539821B3-E483-4674-8298-DDC3FCA80D25";
    }
    hp.strBody = [NSString stringWithFormat:@"username=%@&password=%@&mac_addr=%@", name, pwd, mac];
    hp.respClassType =@"ZUserDTO";
    hp.type = kLogin;
    hp.delegate = delegate;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}


-(void)openShop:(ZShopRegisterDTO*)dto type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
//    [hp makeLoginHead];
    hp.strUrl = urlOpenMyShop;
     NSString *mac = [ZMacAddress getDeviceId];
    dto.deviceId = mac;
    dto.shopType = [NSNumber numberWithInt:100];

    hp.strMethod = @"POST";
    hp.requestObj = dto;
    hp.type = kLogin_OpenShop;
    hp.delegate = delegate;
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)pingServer:(id)delegate{
    
    HttpParam* hp = [[HttpParam alloc] init];
    [hp makeLoginHead];
    hp.strUrl = [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"login/success"];
    hp.strMethod = @"GET";
    hp.type = kLogin_Ping;
    hp.delegate = delegate;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
;
//;
-(void)queryMyShops:(NSNumber*)shopId type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlMyShops;
    hp.strMethod = @"GET";
    hp.respClassType=@"ZMyShopsDTO";
    hp.type = kLogin_MyShops;
    hp.showLoading = NO;
    hp.delegate = delegate;
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)refreshCurrentShop:(NSNumber*)shopId type:(id)deleaget
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlUpdateCurrentShop, [shopId stringValue]];
    hp.strMethod = @"POST";
    hp.type = kLogin_UpdateShopId;
    hp.delegate = deleaget;
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)logout{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults removeObjectForKey:kUserName];
    [accountDefaults removeObjectForKey:kPassword];
    [accountDefaults synchronize];
    HttpManager* hm = [HttpManager getInstance];
    [hm cancleAllRequest];
    [hm clear];
}

-(void)addDeviceForShop:(ZShopDeviceRegister*)device type:(id)deleaget
{
    NSString *mac = [ZMacAddress getDeviceId];
    device.deviceId = mac;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlShopCreate;
    hp.strMethod = @"POST";
    hp.type = kShop_Create;
    hp.delegate = deleaget;
    hp.requestObj = device;
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}


@end
