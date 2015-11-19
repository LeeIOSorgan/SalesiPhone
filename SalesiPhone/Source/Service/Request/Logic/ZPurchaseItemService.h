//
//  ZPurchaseItemService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-21.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  ZItemCGOrderDTO;
@class ZQueryItemConditionDTO;
@class ZItemCGTradeDTO;

@interface ZPurchaseItemService : NSObject

-(void)addPurchase:(ZItemCGOrderDTO*)order type:(id)delegate;
-(void)addBatchPurchase:(NSArray*)order type:(id)delegate;
-(void)queryPurchaseToday:(id)delegate;
-(void)queryPurchaseHistory:(ZQueryItemConditionDTO*)param type:(id)delegate;
-(void)queryPurchaseTrades:(ZQueryItemConditionDTO*)param type:(id)delegate;

-(void)addInventoryDTO:(ZItemCGTradeDTO*)orders1 type:(id)delegate;
-(void)addItemDTO:(ZItemCGOrderDTO*)orders1 type:(id)delegate;

-(void)addInventoryPurchaseDTO:(ZItemCGTradeDTO*)orders1 type:(id)delegate;
-(void)addItemIODTO:(ZItemCGTradeDTO*)orders1 type:(id)delegate ;

//-(void)addInventoryPurchase:(NSArray*)orders1 type:(id)delegate;
-(void)setItemCGTradePrinted:(NSNumber*)tradeId1 type:(id)delegate;
-(void)deleteTrade:(NSNumber*)tradeId type:(id)delegate;
-(void)confirmItemIOTrade:(NSNumber*)tradeId memo:(NSString*)memo type:(id)delegate;
-(void)confirmItemIOTradeSelf:(NSNumber*)tradeId memo:(NSString*)memo type:(id)delegate;

-(void)queryPurchaseTradeDetail:(NSNumber*)tradeId type:(id)delegate;
-(void)queryPurchaseDetail:(NSNumber*)orderId type:(id)delegate;
-(void)updatePurchaseItem:(ZItemCGOrderDTO*)order type:(id)delegate;

@end
