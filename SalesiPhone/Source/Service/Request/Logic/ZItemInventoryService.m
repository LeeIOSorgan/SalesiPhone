//
//  ZItemInventoryService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemInventoryService.h"
#import "ZItemInventoryDTO.h"
#import "HttpManager.h"
#import "ZRequestInc.h"
#import "ZType.h"
#import "ZQueryItemConditionDTO.h"
#import "ZInventoryHandleDTO.h"

@implementation ZItemInventoryService

-(void)addInventories:(NSArray*)orders1 type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemInventoryAdd;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItem_Inventory_Add;
    hp.requestObj = orders1;
    ZLogInfo(@"Request Service addInventories type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)queryInventories:(ZQueryItemConditionDTO*)dto1 type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemInventoryQry;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItem_Inventory_Qry;
    hp.requestObj = dto1;
    hp.respClassType=@"ZItemInventoryDataPage";
    ZLogInfo(@"Request Service queryInventories type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)queryUnInventoryItems:(ZQueryItemConditionDTO*)dto1 type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemUnInventoryQry;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItem_UnInventory_Qry;
    hp.requestObj = dto1;
    hp.respClassType=@"ZItemDataPage";
    ZLogInfo(@"Request Service queryInventories type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)inventoryStart:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemInventoryStart;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItem_Inventory_Start;
    ZLogInfo(@"Request Service inventoryStart type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)inventoryHandle:(ZItemInventoryDTO*)dto1 memo:(NSString*)memo type:(id)delegate
{
    ZInventoryHandleDTO* record = [[ZInventoryHandleDTO alloc]init];
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemInventoryHandle, dto1.orderId];
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    record.memo = memo;
    
    hp.requestObj = record;
    hp.type = kItem_Inventory_Handle;
    ZLogInfo(@"Request Service inventoryHandle type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)queryInventoryRecords:(ZQueryItemConditionDTO*)dto1 type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemInventoryRecordQry;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.type = kItem_Inventory_Record_Qry;
    hp.requestObj = dto1;
    hp.respClassType=@"ZItemInventoryRecordDataPage";
    ZLogInfo(@"Request Service queryInventoryRecords type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
@end
