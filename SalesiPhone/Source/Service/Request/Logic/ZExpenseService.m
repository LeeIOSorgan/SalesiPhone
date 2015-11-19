//
//  ZExpenseService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZExpenseService.h"
#import "HttpManager.h"
#import "ZRequestInc.h"
#import "ZTradeDTO.h"
#import "ZQueryExpenseConditionDTO.h"
#import "ZTradeDataPage.h"
#import "ZUtility.h"
#import "ZQueryItemConditionDTO.h"


@implementation ZExpenseService


-(void)addExpenseRecord:(ZExpenseRecord *)dto1 type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlExpenseCreate;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    hp.respClassType =@"ZTradeDTO";
    hp.type = kExpense_Add;
    hp.requestObj = dto1;
    ZLogInfo(@"Request Service addExpenseRecord type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryExpenseRecordList:(ZConditionDTO *)dto type:(id)delegate
{

    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"timeType=%@", @"today"];
    hp.strUrl = urlExpenseQry;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZExpenseRecordDataPage";
    hp.requestObj = dto;
    hp.delegate = delegate;
    
    hp.type = kExpense_Qry;
    ZLogInfo(@"Request Service queryExpenseRecordList type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryExpenseRecordSubsList:(ZQueryExpenseConditionDTO *)dto type:(id)delegate
{
    
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"timeType=%@", @"today"];
    hp.strUrl = urlExpenseSubExpQry;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZExpenseRecordSubExpDataPage";
    hp.requestObj = dto;
    hp.delegate = delegate;
    
    hp.type = kExpenseSubs_Qry;
    ZLogInfo(@"Request Service queryExpenseRecordList type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryRecordDetail:(NSNumber *)recordId type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlExpenseDetail, recordId] ;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZExpenseRecord";
    hp.delegate = delegate;
    
    hp.type = kExpense_Detail;
    ZLogInfo(@"Request Service queryRecordDetail type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)deleteRecord:(NSNumber *)recordId type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlExpenseDelete, recordId];
    hp.strMethod = @"DELETE";
    hp.delegate = delegate;
    hp.type = kExpense_Delete;
    ZLogInfo(@"Request Service deleteRecord type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)deleteRecordSubs:(NSNumber *)recordId type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlExpenseDelete, recordId];
    hp.strMethod = @"DELETE";
    hp.delegate = delegate;
    hp.type = kExpenseSubs_Delete;
    ZLogInfo(@"Request Service deleteRecord type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)deleteExpenseSub:(NSNumber *)recordId type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlExpenseSubExpDelete, recordId];
    hp.strMethod = @"DELETE";
    hp.delegate = delegate;
    hp.type = kExpenseSubExp_Delete;
    ZLogInfo(@"Request Service deleteExpenseSub type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
