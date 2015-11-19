//
//  ZTradeService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-22.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTradeService.h"
#import "HttpManager.h"
#import "ZRequestInc.h"
#import "ZTradeDTO.h"
#import "ZOrderDTO.h"
#import "ZTradeDataPage.h"
#import "ZUtility.h"
#import "ZQueryItemConditionDTO.h"

@implementation ZTradeService


-(void)createTrade:(ZTradeDTO*)trade1 type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlTradeCreate;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.respClassType =@"ZTradeDTO";
    hp.type = kTrade_Add;
    hp.requestObj = trade1;
    ZLogInfo(@"Request Service createTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)createNewTrade:(ZTradeDTO*)trade1 type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlTradeCreateNew;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.respClassType =@"ZTradeDTO";
    hp.type = kTrade_Add;
    hp.requestObj = trade1;
    ZLogInfo(@"Request Service createTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)createOrderTempTrade:(ZTradeDTO*)trade1 type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlTrade_OrderTemp_Create;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.respClassType =@"ZTradeDTO";
    hp.type = kTrade_OrderTemp_Add;
    hp.requestObj = trade1;
    ZLogInfo(@"Request Service createTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)deleteOrderTempTrade:(NSNumber*)tradeId type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlTrade_OrderTemp_Delete, tradeId];
    hp.strMethod = @"DELETE";
    hp.delegate = delegate;
    hp.type = kTrade_OrderTemp_Delete;
    ZLogInfo(@"Request Service deleteTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryTradeOrderTemp:(ZQueryItemCGConditionDTO*)params type:(id)delegate {
    //    NSString *param = [ZUtility parametersWithDic:params];
    
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"timeType=%@", @"today"];
    hp.strUrl = urlTrade_OrderTemp_Qry;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZTradeDataPage";
    hp.requestObj = params;
    hp.delegate = delegate;
    
    hp.type = kTrade_OrderTemp_Qry;
    ZLogInfo(@"Request Service queryTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryTradeOrderTempDetail:(NSNumber*)tradeId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlTrade_OrderTemp_Detail, tradeId] ;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZTradeDTO";
    hp.delegate = delegate;
    
    hp.type = kTrade_OrderTemp_Detail;
    ZLogInfo(@"Request Service queryTradeDetail type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

//http://{server.ip}:{server.port}/{server.name}/rs/trade/set_printed
-(void)setTradePrinted:(NSNumber*)tradeId1 type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlTradePrinted, tradeId1];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.type = kTrade_Printed;
    ZLogInfo(@"Request Service setTradePrinted type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

-(void)deleteTrade:(NSNumber*)tradeId type:(id)delegate
{
 
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlTradeDelete, tradeId];
    hp.strMethod = @"DELETE";
    hp.delegate = delegate;
    hp.type = kTrade_Delete;
    ZLogInfo(@"Request Service deleteTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)confirmTrade4Customer:(NSNumber*)tradeId type:(id)delegate
{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlTradeConfirmByCustomer, tradeId];
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kTrade_Confirm4Customer;
    ZLogInfo(@"Request Service confirmTrade4Customer type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

/*
 dianyuan，customerName，begin_time，end_time，pageNo（默认为1），pageSize（默认为20），
 sortField（默认为创建时间）， sortDirection（默认为Desc），timeType(默认为today)
 */
-(void)queryTrade:(ZQueryItemCGConditionDTO*)params type:(id)delegate {
//    NSString *param = [ZUtility parametersWithDic:params];
    
    HttpParam* hp = [[HttpParam alloc] init];
//    NSString* param = [NSString stringWithFormat:@"timeType=%@", @"today"];
    hp.strUrl = urlTradeQry;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZTradeDataPage";
    hp.requestObj = params;
    hp.delegate = delegate;
     
    hp.type = kTrade_Qry;
    ZLogInfo(@"Request Service queryTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)queryTrade4Customer:(ZQueryItemCGConditionDTO*)params type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlTradeQry4Customer;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZTradeDataPage";
    hp.requestObj = params;
    hp.delegate = delegate;
    
    hp.type = kTrade_Qry4Customer;
    ZLogInfo(@"Request Service queryTrade4Customer type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

//订单详情信息查询接口
-(void)queryTradeDetail:(NSNumber*)tradeId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlTradeDetail, tradeId] ;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZTradeDTO";
    hp.delegate = delegate;
     
    hp.type = kTrade_Detail;
    ZLogInfo(@"Request Service queryTradeDetail type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)queryTradeOrderSum:(ZQueryItemConditionDTO*)params type:(id)delegate;{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlOrdersSumQry;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZOrderDataPage";
    hp.requestObj = params;
    hp.delegate = delegate;
    
    hp.type = kTrade_QrySumItems;
    ZLogInfo(@"Request Service queryTradeOrderDetail type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

//订单子order详情信息查询接口
-(void)queryTradeOrderDetail:(NSNumber*)orderId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlTradeOrderDetail, orderId] ;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZOrderDTO";
    hp.delegate = delegate;
    
    hp.type = kTradeOrders_Detail;
    ZLogInfo(@"Request Service queryTradeOrderDetail type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
/*
 可用的查询参数：kuan_hao，item_company，category，begin_time，end_time， pageNo（默认为1），pageSize（默认为20），
 sortField（默认为创建时间）， sortDirection（默认为Desc）

 */
-(void)queryOrders:(ZQueryItemConditionDTO*)params type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlOrdersQry;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZOrderDataPage";
    hp.delegate = delegate;
    hp.requestObj = params;
    hp.type = kTradeOrders;
    ZLogInfo(@"Request Service queryOrders type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)querySaledStatistics:(ZConditionDTO*)params staticType:(int)type type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    NSNumber* typeNum = [NSNumber numberWithInt:type];
    if(type < 10) {
        hp.strUrl = [NSString stringWithFormat:urlStatistics_Trade, typeNum];
    } else if(type>10 && type < 20) {
        hp.strUrl = [NSString stringWithFormat:urlStatistics_Item, typeNum];
    } else if(type > 20) {
        hp.strUrl =[NSString stringWithFormat:urlStatistics_ItemCG, typeNum];
    }
    hp.strMethod = @"POST";
    hp.respClassType =@"ZStatisticsDataPage";
    hp.delegate = delegate;
    hp.requestObj = params;
    hp.type = kStatistics_Saled;
    ZLogInfo(@"Request Service querySaledStatistics type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
