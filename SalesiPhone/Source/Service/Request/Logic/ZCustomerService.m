//
//  ZCustomerService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-23.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZCustomerService.h"
#import "HttpManager.h"
#import "ZRequestInc.h"
#import "ZCustomerDTO.h"
#import "ZUtility.h"
#import "ZQueryItemConditionDTO.h"


@implementation ZCustomerService

/*
 可用的查询参数：name，telephone，category， pageNo（默认为1），pageSize（默认为20），
 sortField（默认为客户最后拿货时间）， sortDirection（默认为Desc），customerType（默认为all,  可选的值为owed， extraFee， all）
 */
-(void)queryAllCustomers:(NSMutableDictionary*)params type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
//    NSString *type = @"customerType=%@";
//    if(!custType) {
//        custType = @"all";
//    }
    
    NSString *param = [ZUtility parametersWithDic:params];
    
//    NSString *param = [NSString stringWithFormat:type, custType];
    hp.strUrl = [NSString stringWithFormat:urlCustQry, param] ;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZCustomerDataPage";
    hp.delegate = delegate;  
    hp.type = kCustomer_Qry;
    ZLogInfo(@"Request Service queryAllCustomers type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryCustomerDetails:(NSNumber*)customerId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    
    //    NSString *param = [NSString stringWithFormat:type, custType];
    hp.strUrl = [NSString stringWithFormat:urlCustQryDetail, customerId] ;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZCustomerDTO";
    hp.delegate = delegate;
    hp.type = kCustomer_AddressDetail;
    ZLogInfo(@"Request Service queryCustomerDetails type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)createCustomer:(ZCustomerDTO*)customer1 type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlCustCreate;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZCustomerDTO";
    hp.delegate = delegate;  
    hp.type = kCustomer_Create;
    hp.requestObj=customer1;
//    hp.showLoading = NO;
    
    ZLogInfo(@"Request Service createCustomer type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)modifyCustomer:(ZCustomerDTO*)customer1 type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlCustUpdate;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZCustomerDTO";
    hp.delegate = delegate;
    hp.type = kCustomer_Modify;
    hp.requestObj=customer1;
    //    hp.showLoading = NO;
    
    ZLogInfo(@"Request Service modifyCustomer type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryCustomerAccount:(NSNumber *)customerId type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    
    hp.strUrl = [NSString stringWithFormat:urlCustQryById, customerId] ;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZCustomerDTO";
    hp.delegate = delegate;
//    hp.showLoading= NO;
    hp.type = kCustomer_QryById;
    ZLogInfo(@"Request Service queryCustomerAccount type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)changeCustomer:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlCustEnable;
        hp.type = kCustomer_En;
    } else {
        hp.strUrl = urlCustDisable;
        hp.type = kCustomer_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeCustomer type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)queryCustomerSaleStatistic:(ZQueryItemConditionDTO*)params type:(id)delegate {
    //    NSString *tmps = [ZUtility parametersWithDic:params];
    
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"sortDirection=desc&%@", tmps];
    hp.strUrl = urlCustStatisticQry;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZCustomerSalerRecordPage";
    hp.delegate = delegate;
    hp.requestObj= params;
    hp.type = kCustomer_Statistic_Qry;
    
    ZLogInfo(@"Request Service queryCustomerSaleStatistic type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

@end
