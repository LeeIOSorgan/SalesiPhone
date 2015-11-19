//
//  ZAccountService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-5.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZAccountService.h"
#import "ZType.h"
#import "HttpParam.h"
#import "HttpManager.h"
#import "ZAccountCustomer.h"
#import "ZAccountCompany.h"
#import "ZUtility.h"

@implementation ZAccountService

-(void)queryCusotmerAccount:(ZQueryAccountDTO*)params type:(id)delegate
{
//    NSString *tmps = [ZUtility parametersWithDic:params];
    
    HttpParam* hp = [[HttpParam alloc] init];
//    NSString* param = [NSString stringWithFormat:@"&%@", tmps];
    hp.strUrl = urlAccountCustomerQry;
    hp.strMethod = @"POST";
    hp.requestObj = params;
    hp.respClassType =@"ZAccountCustomerPage";
    hp.delegate = delegate;
    hp.type = kCoAccount_Cust_Qry;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryCompanyAccount:(ZQueryAccountDTO*)params type:(id)delegate
{
//    NSString *tmps = [ZUtility parametersWithDic:params];
    
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"&%@", tmps];
    hp.strUrl = urlAccountCompanyQry;
    hp.strMethod = @"POST";
    hp.requestObj = params;
    hp.respClassType =@"ZAccountCompanyPage";
    hp.delegate = delegate;
    hp.type = kCoAccount_Com_Qry;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)addCustomerAccount:(ZAccountCustomer*)dto type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlAccountCustomerCreate;
    hp.strMethod = @"POST";
    hp.requestObj = dto;
    hp.respClassType =@"ZAccountCustomer";
    hp.delegate = delegate;
    hp.type = kCoAccount_Cust_Add;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)addCompanyAccount:(ZAccountCompany*)dto type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlAccountCompanyCreate;
    hp.strMethod = @"POST";
    hp.requestObj = dto;
    hp.respClassType =@"ZAccountCompany";
    hp.delegate = delegate;
    hp.type = kCoAccount_Com_Add;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)removeCustomerAccount:(ZAccountCustomer*)dto type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlAccountCustomerRemove, dto.coAccountId, dto.customerId];
    hp.strMethod = @"PUT";
    hp.requestObj = dto;
    hp.delegate = delegate;
    hp.type = kCoAccount_Cust_Del;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)removeCompanyAccount:(ZAccountCompany*)dto type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlAccountCompanyRemove, dto.coAccountId,dto.itemCompanyId];
    hp.strMethod = @"PUT";
    hp.requestObj = dto;
    hp.delegate = delegate;
    hp.type = kCoAccount_Com_Del;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
