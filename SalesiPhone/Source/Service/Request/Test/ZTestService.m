//
//  ZTestService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-17.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTestService.h"
#import "ZLoginService.h"
#import "ZRequestInc.h"
#import "ZUserService.h"
#import "ZPurchaseItemService.h"
#import "ZSyncUpService.h"
#import "ZItemCGOrderDTO.h"
#import "ZSkuPropertyDTO.h"
#import "ZItemCGDataPage.h"

@implementation ZTestService


-(void)testPurchase{
    ZPurchaseItemService *zusers = [[ZServiceFactory sharedService]getPurchaseItemService];
    
    ZItemCGOrderDTO * cgOrder = [[ZItemCGOrderDTO alloc]init];
    cgOrder.name = @"新款短袖t恤";
    cgOrder.kuanHao=@"8321";
    cgOrder.itemCategory=@"上衣";
    cgOrder.buyerPrice = [NSNumber numberWithInt:40];
    NSMutableArray *skus = [[NSMutableArray alloc]init];
    ZSkuPropertyDTO *sku1 = [[ZSkuPropertyDTO alloc]init];
    sku1.itemSize=@"XL";
    sku1.itemColor =@"红色";
    ZSkuPropertyDTO *sku2 = [[ZSkuPropertyDTO alloc]init];
    sku2.itemSize=@"XXL";
    sku2.itemColor =@"红色";
    ZSkuPropertyDTO *sku3 = [[ZSkuPropertyDTO alloc]init];
    sku3.itemSize=@"XXL";
    sku3.itemColor =@"红色";
    
    [skus addObject:sku1];
    [skus addObject:sku2];
    cgOrder.skuPropertyDTOs = skus;
    
//    [zusers addPurchase:cgOrder type:self];
//    [self addBatchOrders];
    [zusers queryPurchaseToday:self];
}

-(void)addBatchOrders {
    ZItemCGOrderDTO * cgOrder = [[ZItemCGOrderDTO alloc]init];
    cgOrder.name = @"新款短袖t恤";
    cgOrder.kuanHao=@"8321";
    cgOrder.itemCategory=@"上衣";
    cgOrder.buyerPrice = [NSNumber numberWithInt:40];
    
    NSMutableArray *orders = [[NSMutableArray alloc]init];
    [orders addObject:cgOrder];
    ZPurchaseItemService *zusers = [[ZServiceFactory sharedService]getPurchaseItemService];
    
    [zusers addBatchPurchase:orders type:self];
}

-(void)testSyncUpService{
    ZSyncUpService *zusers = [[ZServiceFactory sharedService]getSyncUpService];
    [zusers syncUpCustomer:@"" type:self];
    [zusers syncUpItem:@"" type:self];
    [zusers syncUpItemFZ:@"" type:self];
    [zusers syncUpUser:@"" type:self];
}

- (void)handleResponse:(ZResponse*)response
{
    switch (response.businessType) {
        
            
        case kCustomer_Sync:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;

        case kItemPurchase_Add:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                    if([response.respObj isKindOfClass:[ZItemCGOrderDTO class]]) {
                        ZItemCGOrderDTO *obj = (ZItemCGOrderDTO*)response.respObj;
                        ZLogInfo(@" kItemPurchase_Add succeed = %@ %@ skus = %d", obj.name,obj.totalCount, [obj.skuPropertyDTOs count]);
                        
                    }

                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItemPurchase_AddBatch:
        case kItemPurchase_Qry:
            if (response.code.code == 200 || response.code.code == 204) {
                if ([response.respObj isKindOfClass:[ZItemCGDataPage class]]){
                    ZItemCGDataPage *datapage = (ZItemCGDataPage*) response.respObj;
                    for(id tmpObj in datapage.itemCGOrderDTOs) {
                        if([tmpObj isKindOfClass:[ZItemCGOrderDTO class]]) {
                             ZItemCGOrderDTO *obj = (ZItemCGOrderDTO*)tmpObj;
                            ZLogInfo(@"kItemPurchase_Qry  succeed = %@ %@ skus = %d", obj.name,obj.totalCount, [obj.skuPropertyDTOs count]);
                        }
                    }
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        default:
            if (response.code.code == 200 || response.code.code == 204) {
                ZLogInfo(@"kItemPurchase_Add succeed = %d", response.businessType);
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
    
    }
}

@end
