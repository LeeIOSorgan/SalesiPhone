//
//  ZTradeService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-22.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZTradeDTO;
@class ZQueryItemCGConditionDTO;
@class ZQueryItemConditionDTO;
@class ZConditionDTO;

@interface ZTradeService : NSObject

-(void)createTrade:(ZTradeDTO*)trade1 type:(id)delegate;
-(void)createNewTrade:(ZTradeDTO*)trade1 type:(id)delegate;
-(void)queryTrade:(ZQueryItemCGConditionDTO*)params type:(id)delegate;
-(void)queryTrade4Customer:(ZQueryItemCGConditionDTO*)params type:(id)delegate;
-(void)queryTradeDetail:(NSNumber*)tradeId type:(id)delegate;
-(void)queryOrders:(ZQueryItemConditionDTO*)params type:(id)delegate;
-(void)queryTradeOrderDetail:(NSNumber*)orderId type:(id)delegate;
-(void)queryTradeOrderSum:(ZQueryItemConditionDTO*)params type:(id)delegate;
-(void)setTradePrinted:(NSNumber*)tradeId1 type:(id)delegate;
-(void)deleteTrade:(NSNumber*)tradeId type:(id)delegate;

-(void)queryTradeOrderTemp:(ZQueryItemCGConditionDTO*)params type:(id)delegate;
-(void)createOrderTempTrade:(ZTradeDTO*)trade1 type:(id)delegate;
-(void)deleteOrderTempTrade:(NSNumber*)tradeId type:(id)delegate;
-(void)queryTradeOrderTempDetail:(NSNumber*)tradeId type:(id)delegate;

-(void)confirmTrade4Customer:(NSNumber*)tradeId type:(id)delegate;

-(void)querySaledStatistics:(ZConditionDTO*)params staticType:(int)type type:(id)delegate;


@end
