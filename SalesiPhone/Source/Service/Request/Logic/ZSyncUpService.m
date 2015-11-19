//
//  ZSyncUpService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-22.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZSyncUpService.h"
#import "HttpManager.h"
#import "ZRequestInc.h"
#import "ZItemDTO.h"
#import "ZItemDataPage.h"
#import "ZItemCategoryDTO.h"
#import "ZItemColorDTO.h"
#import "ZItemCompanyDTO.h"
#import "ZType.h"

@implementation ZSyncUpService

/*
 在登陆成功后，同步商品，辅助商品，客户，用户数据。
 在后台轮询时，只同步商品。
 同步商品数据接口（根据提供的上一次更新时间，获取从上传更新时间到现在有所更新的商品，查询参数last_updated， 时间格式为yyyy-MM-dd HH:mm:ss）， 如果查询参数不填，返回所有的记录
 
 */
-(void)syncUpItem:(NSString*)dateStr type:(id)delegate {
//    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
//    NSDate *date = [NSDate date];
//    NSString * tmpdate = [dateFormatter stringFromDate:date];
    NSString * tmpdate = dateStr;
    HttpParam* hp = [[HttpParam alloc] init];
    
    if (tmpdate){
//        tmpdate = [hp encodeURL:tmpdate];
        hp.strUrl = [NSString stringWithFormat:urlItemSyncUp, tmpdate];
    }else{
        hp.strUrl = [NSString stringWithFormat:@"%@%@", kHttpPrefix, @"item/last_updated"];
    }
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemDTO";
    hp.delegate = delegate;
     
    hp.isArray = YES;
    hp.showLoading = NO;
    hp.type = kItem_Sync;
    ZLogInfo(@"Request Service syncUpItem type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)syncUpItemFZ:(NSString*)dateStr type:(id)delegate {
//    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
//    NSDate *date = [NSDate date];
//    NSString * tmpdate = [dateFormatter stringFromDate:date];
    NSString * tmpdate = dateStr;
    HttpParam* hp = [[HttpParam alloc] init];
//    tmpdate = [hp encodeURL:tmpdate];
    hp.strUrl = [NSString stringWithFormat:urlItemFZSyncUp, tmpdate];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemDTO";
    hp.delegate = delegate;
     
    hp.isArray = YES;
    hp.type = kItemFZ_Sync;
    hp.showLoading = NO;
    ZLogInfo(@"Request Service syncUpItemFZ type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)syncUpCustomer:(NSString*)dateStr type:(id)delegate {
//    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
//    NSDate *date = [NSDate date];
//    NSString * tmpdate = [dateFormatter stringFromDate:date];
    NSString * tmpdate = dateStr;
    HttpParam* hp = [[HttpParam alloc] init];
//    tmpdate = [hp encodeURL:tmpdate];
    hp.strUrl = [NSString stringWithFormat:urlCustomerSyncUp, tmpdate];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZCustomerDTO";
    //这个变量是retain的修饰。所以在赋值后，需要release;
    hp.delegate = delegate;
     
    hp.isArray = YES;
    hp.type = kCustomer_Sync;
    hp.showLoading = NO;
    ZLogInfo(@"Request Service syncUpCustomer type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)syncUpUser:(NSString*)dateStr type:(id)delegate {
//    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
//    NSDate *date = [NSDate date];
//    NSString * tmpdate = [dateFormatter stringFromDate:date];
    NSString * tmpdate = dateStr;
    HttpParam* hp = [[HttpParam alloc] init];
//    tmpdate = [hp encodeURL:tmpdate];
    hp.strUrl = [NSString stringWithFormat:urlUserSyncUp, tmpdate];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZUserDTO";
    hp.delegate = delegate;
     
    hp.isArray = YES;
    hp.type = kUser_Sync;
    hp.showLoading = NO;
    ZLogInfo(@"Request Service syncUpUser type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)syncUpSaler:(NSString*)dateStr type:(id)delegate {
    NSString * tmpdate = dateStr;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlSalerSyncUp, tmpdate];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZShopSalerDTO";
    hp.delegate = delegate;
    
    hp.isArray = YES;
    hp.type = kSaler_Sync;
    hp.showLoading = NO;
    ZLogInfo(@"Request Service syncUpUser type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)syncUpSupplier:(NSString*)dateStr type:(id)delegate {
    NSString * tmpdate = dateStr;
    HttpParam* hp = [[HttpParam alloc] init];
//    tmpdate = [hp encodeURL:tmpdate];
    hp.strUrl = [NSString stringWithFormat:urlSupplierSyncUp, tmpdate];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemCompanyDTO";
    hp.delegate = delegate;
     
    hp.isArray = YES;
    hp.type = kSupplier_Sync;
    hp.showLoading = NO;
    ZLogInfo(@"Request Service syncUpSupplier type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)syncUpCustomerItems:(NSString*)dateStr type:(id)delegate {
    NSString * tmpdate = dateStr;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlCustomerItmsSyncUp, tmpdate];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZCustomerItemPriceDTO";
    hp.delegate = delegate;
    
    hp.isArray = YES;
    hp.type = kCustomerItems_Sync;
    hp.showLoading = NO;
    ZLogInfo(@"Request Service syncUpCustomerItems type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)syncUpOtherShops:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlAllShops;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZShopDTO";
    hp.delegate = delegate;
    
    hp.isArray = YES;
    hp.type = kAllShops_Sync;
    hp.showLoading = NO;
    ZLogInfo(@"Request Service syncUpUser type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
