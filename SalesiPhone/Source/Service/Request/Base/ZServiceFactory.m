//
//  ZServiceFactory.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZServiceFactory.h"
#import "ZLoginService.h"
#import "ZUserService.h"
#import "ZItemService.h"
#import "ZPurchaseItemService.h"
#import "ZSyncUpService.h"
#import "ZCustomerService.h"
#import "ZTradeService.h"
#import "ZFileService.h"
#import "ZOthersService.h"
#import "ZKuaiDiInfoService.h"
#import "ZAccountService.h"
#import "ZReportService.h"
#import "ZExpenseService.h"
#import "ZItemInventoryService.h"

@interface ZServiceFactory()
{
    ZSyncUpService* syncup;
    ZPurchaseItemService* purchaseItem ;
    ZItemService* item;
    ZUserService* user;
    ZLoginService* ls;
    ZTradeService* trade;
    ZCustomerService* customer;
    ZFileService* file;
    ZKuaiDiInfoService *kuaiDi;
    ZAccountService* account;
    ZOthersService* others;
    ZReportService* report;
    ZExpenseService* expense;
    ZItemInventoryService* inventory;
}

@end

@implementation ZServiceFactory

static ZServiceFactory* _instance = nil;

+ (ZServiceFactory*)sharedService{
    if (_instance == nil)
    {
        _instance = [[ZServiceFactory alloc] init];
    }
    
    return _instance;
}

-(void)dealloc
{
    syncup = nil;
    purchaseItem  = nil;
    item = nil;
    user = nil;
    ls = nil;
    trade = nil;
    customer = nil;
    file = nil;
    kuaiDi = nil;
    account = nil;
    others = nil;
}



-(ZLoginService*) getLoginService{
    if (ls == nil){
        ls = [[ZLoginService alloc] init];
    }
    return ls;
}

-(ZUserService*)getUserService {
    if (user == nil){
        user = [[ZUserService alloc] init];
    }
    return user;
}

-(ZItemService*)getItemService{
    if (item == nil){
        item = [[ZItemService alloc] init];
    }
    return item;
}
-(ZPurchaseItemService*)getPurchaseItemService{
    if (purchaseItem == nil){
        purchaseItem = [[ZPurchaseItemService alloc] init];
    }
    return purchaseItem;
}
-(ZItemInventoryService*)getInventoryService {
    if(inventory == nil) {
        inventory = [[ZItemInventoryService alloc]init];
    }
    return inventory;
}
-(ZSyncUpService*)getSyncUpService{
    if (syncup == nil){
        syncup = [[ZSyncUpService alloc] init];
    }
    return syncup;
}
-(ZTradeService*)getTradeService{
    if (trade == nil){
        trade = [[ZTradeService alloc] init];
    }
    return trade;
}

-(ZExpenseService*)getExpenseService
{
    if(expense == nil)
    {
        expense = [[ZExpenseService alloc]init];
    }
    return expense;
}

-(ZCustomerService*)getCustomerService{
    if (customer == nil){
        customer = [[ZCustomerService alloc] init];
    }
    return customer;
}

-(ZFileService*)getFileService{
    if (file == nil){
        file = [[ZFileService alloc] init];
    }
    return file;
}
-(ZKuaiDiInfoService*)getKuaiDiInfoService
{
    if(kuaiDi == nil) {
        kuaiDi = [[ZKuaiDiInfoService alloc]init];
    }
    return kuaiDi;
}
-(ZAccountService*)getAccountService
{
    if(account == nil) {
        account = [[ZAccountService alloc]init];
    }
    return account;
}
-(ZOthersService*)getOtherService {
    if (others == nil){
        others = [[ZOthersService alloc] init];
    }
    return others;
}

-(ZReportService*)getReportService{
    if(report == nil) {
        report = [[ZReportService alloc]init];
    }
    return report;
}
@end
