//
//  ZServiceFactory.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZLoginService;
@class ZGoodsService;
@class ZUserService;
@class ZItemService;
@class ZPurchaseItemService;
@class ZSyncUpService;
@class ZCustomerService;
@class ZTradeService;
@class ZFileService;
@class ZOthersService;
@class ZKuaiDiInfoService;
@class ZAccountService;
@class ZReportService;
@class ZExpenseService;
@class ZItemInventoryService;

@interface ZServiceFactory : NSObject
+ (ZServiceFactory*)sharedService;

- (ZLoginService*)getLoginService;
- (ZUserService*)getUserService;
- (ZItemService*)getItemService;
- (ZPurchaseItemService*)getPurchaseItemService;
-(ZItemInventoryService*)getInventoryService;

- (ZSyncUpService*)getSyncUpService;
-(ZCustomerService*)getCustomerService;
-(ZExpenseService*)getExpenseService;
-(ZTradeService*)getTradeService;
-(ZFileService*)getFileService;
-(ZKuaiDiInfoService*)getKuaiDiInfoService;
-(ZAccountService*)getAccountService;
-(ZOthersService*)getOtherService;

-(ZReportService*)getReportService;

@end
