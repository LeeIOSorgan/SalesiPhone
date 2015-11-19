//
//  ZKuaiDiInfoService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-10-9.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZKuaiDiInfoService.h"
#import "ZKuaiDiInfoDTO.h"
#import "ZType.h"
#import "HttpParam.h"
#import "HttpManager.h"

#import "ZCustomerPrintInfoDTO.h"

@implementation ZKuaiDiInfoService

-(void)queryAllKuaiDi:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlKuaiDiQryAll;
    hp.strMethod = @"GET";
    hp.isArray = YES;
    hp.respClassType =@"ZKuaiDiInfoDTO";
    hp.delegate = delegate;
    hp.type = kKuaiDiInfo_QryAll;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}


-(void)updateMyKuaiDiInfo:(NSArray*)dtos used:(BOOL)enable type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlKuaiDiEn;
        hp.type = kKuaiDiInfo_En;
    } else {
        hp.strUrl = urlKuaiDiDis;
        hp.type = kKuaiDiInfo_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    hp.requestObj = dtos;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryMyKuaiDiList:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlKuaiDiGet;
    hp.strMethod = @"GET";
    hp.isArray = YES;
    hp.respClassType =@"ZKuaiDiInfoDTO";
    hp.delegate = delegate;
    hp.type = kKuaiDiInfo_GetMy;
    hp.showLoading = NO;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)sentPrintKuaiDiRequest:(ZCustomerPrintInfoDTO*)dto type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlKuaiDiPrint;
    hp.strMethod = @"POST";
    hp.requestObj = dto;
//    hp.respClassType =@"ZKuaiDiInfoDTO";
    hp.delegate = delegate;
    hp.type = kKuaiDiInfo_Print;
    hp.showLoading = YES;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
