//
//  ZTestTradeService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-25.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTestTradeService.h"
#import "ZServiceFactory.h"
#import "ZRequestInc.h"
#import "ZTradeService.h"
#import "ZOrderDTO.h"
#import "ZTradeDTO.h"
#import "ZSkuPropertyDTO.h"
#import "ZQueryItemConditionDTO.h"

@implementation ZTestTradeService

-(void)testTradeService{
    ZTradeService *zusers = [[ZServiceFactory sharedService]getTradeService];
    ZTradeDTO * trade = [[ZTradeDTO alloc]init];
    NSMutableArray * orders = [[NSMutableArray alloc]init];
    ZOrderDTO *order1 = [[ZOrderDTO alloc]init];
    order1.itemId=[NSNumber numberWithInt:25];
    order1.name = @"新款短袖t恤";
    order1.itemPrice=[NSNumber numberWithInt:50];
    ZSkuPropertyDTO* sku = [[ZSkuPropertyDTO alloc]init];
    sku.itemSize=@"XL";
    sku.count=[NSNumber numberWithInt:6];
    sku.itemColor=@"红色";
    order1.skuPropertyDTOs = [[NSMutableArray alloc]initWithObjects:sku, nil];
    order1.totalCount=[NSNumber numberWithInt:6];
    
    ZOrderDTO *order2 = [[ZOrderDTO alloc]init];
    order2.itemId=[NSNumber numberWithInt:26];
    order2.name = @"新款短袖t恤";
    order2.itemPrice=[NSNumber numberWithInt:60];
    sku = [[ZSkuPropertyDTO alloc]init];
    sku.itemSize=@"XL";
    sku.count=[NSNumber numberWithInt:6];
    sku.itemColor=@"红色";
    order2.skuPropertyDTOs = [[NSMutableArray alloc]initWithObjects:sku, nil];
    order2.totalCount=[NSNumber numberWithInt:6];
    
    [orders addObject:order1];
    [orders addObject:order2];
//    [order1 release];
//    [order2  release];
    trade.orderDTOs = orders;
    [zusers createTrade:trade type:self];
//    [orders release];
//    [trade release];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [zusers queryTrade:params type:self];
//
    [zusers queryTradeDetail:[NSNumber numberWithInt:4] type:self];
    ZQueryItemConditionDTO *params1 = [[ZQueryItemConditionDTO alloc]init];
    [zusers queryOrders:params1 type:self];
//    [params1 release];
}
@end
