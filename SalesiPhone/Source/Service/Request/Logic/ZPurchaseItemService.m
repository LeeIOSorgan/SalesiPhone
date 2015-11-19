//
//  ZPurchaseItemService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-21.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZPurchaseItemService.h"
#import "HttpManager.h"
#import "ZRequestInc.h"
#import "ZItemCGOrderDTO.h"
#import "ZUtility.h"
#import "ZItemCGTradeDTO.h"

#define urlPurchase_Add [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg"]
#define urlPurchase_AddBatch [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/batch"]
#define urlPurchase_Qry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/orders"]

#define urlPurchase_Inventory [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/inventory"]
#define urlPurchase_ItemIO [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/itemIO"]
#define urlPurchase_Printed [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/%@/set_printed"]

#define urlPurchase_Account [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/inventory/accountonly"]
#define urlPurchase_Delete [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/%@/delete"]
#define urlItemIO_Confirmed [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/itemIO/confirm/%@"]
#define urlItemIO_ConfirmedSelf [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/itemIO/confirmself/%@"]

#define urlPurchase_Detail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/%@/detail"]
#define urlPurchaseTrade_Detail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/%@/trade/detail"]
#define urlPurchase_Update [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/update"]

#define urlItem_Inventory [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/item/inventory"]
#define urlItem_Create [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/item/add"]
#define urlPurchaseTrade_Qry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/cgtrades"]

@implementation ZPurchaseItemService

/*
 url: http://{server.ip}:{server.port}/{server.name}/rs/item_cg
 method: post
 content-type: application/json
 上传对象： ItemCGOrderDTO
 返回结果： 如果成功，返回http code 204
 */
-(void)addPurchase:(ZItemCGOrderDTO*)cgorder1 type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];

    hp.strUrl = urlPurchase_Add;
    hp.strMethod = @"POST";
    hp.delegate = delegate;  
//    hp.respClassType= @"ZItemCGOrderDTO";
    hp.type = kItemPurchase_Add;
    hp.requestObj = cgorder1;
    ZLogInfo(@"Request Service addPurchase type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
/*
 url: http://{server.ip}:{server.port}/{server.name}/rs/item_cg/batch
 method： post
 content-type: application/json
 上传对象： List<ItemCGOrderDTO>
 返回结果： 如果成功，返回http code 204
 */
-(void)addBatchPurchase:(NSArray*)orders1 type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlPurchase_AddBatch;
    hp.strMethod = @"POST";
    hp.delegate = delegate;  
    hp.type = kItemPurchase_AddBatch;
    hp.requestObj = orders1;
    hp.isArray = YES;
    ZLogInfo(@"Request Service addBatchPurchase type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

//-(void)addInventoryPurchase:(NSArray*)orders1 type:(id)delegate {
//    
//    HttpParam* hp = [[HttpParam alloc] init];
//    hp.strUrl = urlPurchase_Inventory;
//    hp.strMethod = @"POST";
//    hp.delegate = delegate;  
//    hp.type = kItemPurchase_Inventory;
//    hp.requestObj = orders1;
//    hp.isArray = YES;
//    
//    ZLogInfo(@"Request Service addBatchPurchase type = %d", hp.type);
//    HttpManager* hm = [HttpManager getInstance];
//    [hm postHttpRequest:hp];
//}
-(void)addInventoryPurchaseDTO:(ZItemCGTradeDTO*)orders1 type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlPurchase_Inventory;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItemPurchase_Inventory;
    hp.requestObj = orders1;
    hp.respClassType=@"ZItemCGTradeDTO";
    ZLogInfo(@"Request Service addInventoryPurchaseDTO type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)setItemCGTradePrinted:(NSNumber*)tradeId1 type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlPurchase_Printed, tradeId1];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.type = kItemPurchase_Print;
    ZLogInfo(@"Request Service setItemCGTradePrinted type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

-(void)addItemIODTO:(ZItemCGTradeDTO*)orders1 type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlPurchase_ItemIO;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItemPurchase_ItemIO;
    hp.requestObj = orders1;
    ZLogInfo(@"Request Service addItemIODTO type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)deleteTrade:(NSNumber*)tradeId type:(id)delegate
{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlPurchase_Delete, tradeId];
    hp.strMethod = @"DELETE";
    hp.delegate = delegate;
    hp.type = kItemPurchase_Delete;
    ZLogInfo(@"Request Service deleteTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)confirmItemIOTrade:(NSNumber*)tradeId memo:(NSString*)memo type:(id)delegate
{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemIO_Confirmed, tradeId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    hp.requestObj = memo;
    
    hp.type = kItemIO_ItemConfirm;
    ZLogInfo(@"Request Service confirmItemIOTrade type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)confirmItemIOTradeSelf:(NSNumber*)tradeId memo:(NSString*)memo type:(id)delegate
{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemIO_ConfirmedSelf, tradeId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    hp.requestObj = memo;
    
    hp.type = kItemIO_ItemConfirmSelf;
    ZLogInfo(@"Request Service confirmItemIOTradeSelf type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)addInventoryDTO:(ZItemCGTradeDTO*)orders1 type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItem_Inventory;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItem_Inventory;
    hp.requestObj = orders1;
    hp.isArray = YES;
    ZLogInfo(@"Request Service addInventoryDTO type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)addItemDTO:(ZItemCGOrderDTO*)orders1 type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItem_Create;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItem_Inventory_Add;
    hp.requestObj = orders1;
    hp.respClassType=@"ZItemDTO";
    ZLogInfo(@"Request Service addItemDTO type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
/*
 url: http://{server.ip}:{server.port}/{server.name}/rs/item_cg?queryParam=queryValue
 可用的查询参数：kuan_hao，item_company，category，begin_time，end_time，pageNo（默认为1），pageSize（默认为20），
 ，timeType(默认为today， 可选的参数有today, history)
 */
-(void)queryPurchaseToday:(id)delegate{

    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlPurchase_Qry, @"timeType=today"];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemCGDataPage";
    hp.delegate = delegate;  
    hp.type = kItemPurchase_Qry;
    ZLogInfo(@"Request Service queryPurchaseToday type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
/*
 可用的查询参数：kuan_hao，item_company，category，begin_time，end_time，pageNo（默认为1），pageSize（默认为20），
 ，timeType(默认为today， 可选的参数有today, history)
 */
-(void)queryPurchaseHistory:(ZQueryItemConditionDTO*)param type:(id)delegate{

//    NSString *paramStr = [ZUtility parametersWithDic:param];
    //    NSString * params = [NSString stringWithFormat:@"pageNo=1%@", paramStr ];
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlPurchase_Qry;
    hp.strMethod = @"POST";
    hp.requestObj = param;
    hp.respClassType =@"ZItemCGDataPage";
    hp.delegate = delegate;  
    hp.type = kItemPurchase_Qry;
    ZLogInfo(@"Request Service queryPurchaseHistory type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryPurchaseTrades:(ZQueryItemConditionDTO*)param type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlPurchaseTrade_Qry;
    hp.strMethod = @"POST";
    hp.requestObj = param;
    hp.respClassType =@"ZItemCGTradePage";
    hp.delegate = delegate;
    hp.type = kItemPurchaseTrade_Qry;
    ZLogInfo(@"Request Service queryPurchaseTrades type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}


-(void)queryPurchaseDetail:(NSNumber*)orderId type:(id)delegate{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlPurchase_Detail, orderId];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemCGOrderDTO";
    hp.delegate = delegate;
    hp.type = kItemPurchase_Detail;
    ZLogInfo(@"Request Service queryPurchaseDetail type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)queryPurchaseTradeDetail:(NSNumber*)tradeId type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlPurchaseTrade_Detail, tradeId];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemCGTradeDTO";
    hp.delegate = delegate;
    hp.type = kItemPurchaseTrade_Detail;
    ZLogInfo(@"Request Service queryPurchaseTradeDetail type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)updatePurchaseItem:(ZItemCGOrderDTO*)order type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlPurchase_Update;
    hp.strMethod = @"GET";
    hp.delegate = delegate;
    hp.requestObj = order;
    hp.type = kItemPurchase_Update;
    ZLogInfo(@"Request Service updatePurchaseItem type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
