//
//  ZArchive.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/21/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZArchive.h"
#import "FMDatabase.h"

#import "ZItemDTO.h"
#import "ZCustomerDTO.h"
#import "ZUserDTO.h"
#import "ZItemFZDTO.h"
#import "ZItemColorDTO.h"
#import "ZItemOrderMemo.h"
#import "ZItemCGOrderDTO.h"
#import "ZItemSizeDTO.h"
#import "ZItemBrandDTO.h"
#import "ZItemSeason.h"
#import "ZItemCategoryDTO.h"
#import "ZItemCompanyDTO.h"
#import "ZShopInfoDTO.h"
#import "ZShopDTO.h"
#import "ZPrintInfoDTO.h"
#import "ZOrderDTO.h"
#import "ZCustomerItemPriceDTO.h"

#import "ZNotification.h"
#import "ZSyncUpService.h"
#import "ZOthersService.h"
#import "ZLoginService.h"
#import "ZItemService.h"
#import "ZKuaiDiInfoService.h"
#import "ZServiceFactory.h"
#import "ZPopupUIItemDTO.h"
#import "ZDataCache.h"
#import "ZKuaiDiInfoDTO.h"
#import "ZItemDiscountDTO.h"
#import "ZItemExpenseDTO.h"
#import "ZSkuPropertyDTO.h"
#import "ZSyncBaseData.h"
#import "ZFHDPrintSwitchDTO.h"
#import "ZShopSalerDTO.h"
#import "ZKuaiDiSender.h"
#import "ZConditionDTO.h"

#import "ZResponse.h"
#import "ZBarcodeRuleDTO.h"
#import "ZType.h"

#define kSyncTimeDefault       (10 * 60)

@interface ZArchive ()

@property (nonatomic ) FMDatabase* fmdb;
//@property (nonatomic ) ZSyncUpService* service;
@property (nonatomic ) NSTimer* syncTimer;

@end

@implementation ZArchive

+ (ZArchive*)instance{
    static ZArchive* _instance = nil;
    
    if (_instance == nil)
    {
        _instance = [[ZArchive alloc] init];
    }
    
    return _instance;
}

-(void)dealloc
{
    ZLogInfo(@"---Into----ZArchive--dealloc-");
    _fmdb = nil;
}

- (void)handleResponse:(ZResponse*)response
{
    if (response.code.code == 200 || response.code.code == 204)
    {
        if(![response.respObj isKindOfClass: [NSArray class]])
        {
            if(response.businessType == kShopInfo_Qry) {
                ZShopInfoDTO *shopInfo = (ZShopInfoDTO*)response.respObj;
                ZLogInfo(@" Query shopinfo Succeed");
                if(shopInfo) {
                    [self updateShopInfo:shopInfo];
                }
                return;
            } else {
                ZLogError(@"handleResponse error, type invalid");
                return;                
            }
        }
    }
    else
    {
        ZLogError(@"handleResponse error, ZArchive");
        return;
    }
    
    NSArray *itemArray = (NSArray*)response.respObj;
//    [_fmdb beginTransaction];
    switch (response.businessType) {
            
        case kItem_Sync:
            {
                ZLogInfo(@" Query Item Succeed  totalCount = %lu", (unsigned long)[itemArray count]);
                BOOL synced = NO;
                synced = [self addItemDtoArray:itemArray];
                //按时间降序，最近的在第一位，返回结果。记录第一个记录时间。
                if(synced) {
                    if([itemArray count] > 0) {
                        ZItemDTO * item = [itemArray objectAtIndex:0];
                        [self updateSyncTime:1 tableName:@"goods"time:item.created];
                    }
                }
                [self deleteUnusedCustomerPrice];
                [self deleteUnusedData:@"goods"];
            }
            break;
        case kItemColor_Qry:
            [self addItemColorDtoArray:itemArray];
            [self deleteUnusedData:@"itemcolor"];
            break;
        case kItemSize_Qry:
            [self addItemSizeDtoArray:itemArray];
            [self deleteUnusedData:@"itemsize"];
            break;
        case kItemFZ_Qry:
            [self addItemFZDtoArray:itemArray];
            break;
        case kItemBrand_Qry:
            [self addItemBrandDtoArray:itemArray];
            [self deleteUnusedData:@"itembrand"];
            break;
        case kItemDiscount_Qry:
            [self addItemDiscountDtoArray:itemArray];
            [self deleteUnusedData:@"itemdiscount"];
            break;
        case kItemCategory_Qry:
            [self addItemCatDtoArray:itemArray];
            [self deleteUnusedData:@"itemcat"];
            break;
        case kItemExpense_Qry:
            [self addItemExpenseDtoArray:itemArray];
            [self deleteUnusedData:@"itemexpense"];
            break;
        case kSupplier_Sync:
        {
            ZLogInfo(@" Query FzItem Succeed  totalCount = %lu", [itemArray count]);
            BOOL synced1 = NO;
            ZItemCompanyDTO * lastItem;
            for (ZItemCompanyDTO * item in itemArray){
                synced1 = [self addSupplierDto:item];
                lastItem = item;
            }
            if(synced1) {
                if([itemArray count] > 0) {
//                    ZItemCompanyDTO * item = [itemArray objectAtIndex:0];
                    [self updateSyncTime:2 tableName:@"supplier"time:lastItem.created];
                }
            }
            [self deleteUnusedData:@"supplier"];
        }
            break;
        case kCustomerItems_Sync:
        {
            ZLogInfo(@" Query orderItems Succeed  totalCount = %lu", (unsigned long)[itemArray count]);
            if([itemArray count]>0) {
                ZCustomerItemPriceDTO* lastItem;
                NSDate* now = [[NSDate alloc]init];
                [self addCustomerItemPriceArray:itemArray now:now];
                lastItem = [itemArray objectAtIndex:[itemArray count] -1];
                if(YES) {
                    if([itemArray count] > 0) {
                        [self updateSyncTime:7 tableName:@"customerItemPrice"time:lastItem.created];
                    }
                    
                }
            }
         }
            break;
        case kItemFZ_Sync:
            ZLogInfo(@" Query FzItem Succeed  totalCount = %lu", (unsigned long)[itemArray count]);
            BOOL synced2 = NO;
            synced2 = [self addItemFZDtoArray:itemArray];
            if(synced2) {
                if([itemArray count] > 0) {
                    ZItemDTO * item = [itemArray objectAtIndex:0];
                    [self updateSyncTime:3 tableName:@"fzgoods"time:item.syncTime];
                }
            }
            [self deleteUnusedData:@"fzgoods"];
            break;
        case kSaler_Sync:
            {
                ZLogInfo(@" Query kSaler_Sync Succeed  totalCount = %lu", (unsigned long)[itemArray count]);
                BOOL synced5 = NO;
                ZShopSalerDTO* lastItem = nil;
                for (ZShopSalerDTO* item in itemArray){
                    synced5 = [self addSalerItem:item];
                    lastItem = item;
                }
                if(synced5) {
                    if([itemArray count] > 0) {
                        ZShopSalerDTO * item = [itemArray objectAtIndex:0];
                        [self updateSyncTime:6 tableName:@"shopsaler"time:item.syncTime];
                    }
                }
                [self deleteUnusedData:@"shopsaler"];
                break;
            }
        case kCustomer_Sync:
            {
                ZLogInfo(@" Query customer Succeed  totalCount = %lu", [itemArray count]);
                BOOL synced3 = NO;
                ZCustomerDTO* lastItem;
                for (ZCustomerDTO* item in itemArray){
                    synced3 = [self addCustomerItem:item];
                    lastItem = item;
                }
                if (synced3) {
                    if([itemArray count] > 0) {
    //                    ZCustomerDTO * item = [itemArray objectAtIndex:0];
                        [self updateSyncTime:4 tableName:@"customer"time:lastItem.created];
                    }
                }
                [self deleteUnusedData:@"customer"];
            }
            break;
            
        case kUser_Sync:
            ZLogInfo(@" Query user Succeed  totalCount = %lu", [itemArray count]);
            BOOL synced4 = NO;
            for (ZUserDTO * item in itemArray){
                synced4 = [self addUserItem:item];
            }
            if(synced4) {
                if([itemArray count] > 0) {
                    ZUserDTO * item = [itemArray objectAtIndex:0];
                    [self updateSyncTime:5 tableName:@"user"time:item.syncTime];
                }
                
            }
            [self deleteUnusedData:@"user"];
            break;
        case kKuaiDiInfo_GetMy:
            [self addMyKuaiDiDtos:itemArray];
//            [self deleteUnusedData:@"mykuaidi"];
            break;
        default:
            break;
    }
//    //[_fmdb commit];
}

-(void)handleShopBaseData:(ZSyncBaseData*)dto
{
    [ZDataCache sharedInstance].myShop = dto.myShop;
    [self addItemColorDtoArray:dto.itemColorDTOs];
    [self deleteUnusedData:@"itemcolor"];

    [self addItemOrderMemoDtoArray:dto.itemOrderMemoList];
    [self deleteUnusedData:@"itemordermemo"];

    [self addItemSeasonDtoArray:dto.itemSeason];
    [self addItemSizeDtoArray:dto.itemSizeDTOs];
    [self deleteUnusedData:@"itemsize"];

    [self addItemBrandDtoArray:dto.itemBrandDTOs];
    [self deleteUnusedData:@"itembrand"];

    [self addItemDiscountDtoArray:dto.itemDiscountDTOs];
    [self deleteUnusedData:@"itemdiscount"];

    [self addItemCatDtoArray:dto.itemCategoryList];
    [self deleteUnusedData:@"itemcat"];
    [self addItemExpenseDtoArray:dto.itemExpenseList];
    [self deleteUnusedData:@"itemexpense"];
    
    [self addOthershops:dto.shopDTOs];
    [self deleteUnusedData:@"othershops"];
}

- (void)syncData:(NSTimer*)timer
{
    [self syncup];
}
- (void)syncupWhenLogin
{
    ZLogInfo(@"---Into-syncupWhenLogin---");
    ZOthersService *service = [[ZServiceFactory sharedService]getOtherService];
    [service queryShopInfo:self];
    ZItemService* itemservice = [[ZServiceFactory sharedService]getItemService];
    [itemservice queryItemFZs:self showLoading:NO];
//    [itemservice queryExpense:self showLoading:NO];
    ZKuaiDiInfoService *kuaidiService = [[ZServiceFactory sharedService]getKuaiDiInfoService];
    [kuaidiService queryMyKuaiDiList:self];
}
-(void)pingServer
{
    //session 超时时间 30分钟
//    if([ZDataCache sharedInstance].userDto != nil)
//    {//登陆成功后，当程序从后台激活到前台时，发出ping请求。如果失败，则推出到login界面。
//        ZLoginService* itemservice = [[ZServiceFactory sharedService]getLoginService];
//        [itemservice pingServer:self];
//    }
}

- (void)syncupItem{
    ZSyncUpService* ss = [[ZServiceFactory sharedService]getSyncUpService];
    NSString* date = nil;
    if(date) {
        [ss syncUpItem:date type:self];
    } else {
        NSString* strtime = [self getLastSyncTime:@"goods"];
        [ss syncUpItem:strtime type:self];
    }
}
- (void)syncup
{
    ZSyncUpService* ss = [[ZServiceFactory sharedService]getSyncUpService];
    NSString* strtime = nil;
    
    strtime = [self getLastSyncTime:@"goods"];
    [ss syncUpItem:strtime type:self];
    
    strtime = [self getLastSyncTime:@"customer"];
    [ss syncUpCustomer:strtime type:self];
    strtime = [self getLastSyncTime:@"customerItemPrice"];
    [ss syncUpCustomerItems:strtime type:self];
    
    strtime = [self getLastSyncTime:@"user"];
    [ss syncUpUser:strtime type:self];
    
    strtime = [self getLastSyncTime:@"shopsaler"];
    [ss syncUpSaler:strtime type:self];
    
    strtime = [self getLastSyncTime:@"supplier"];
    [ss syncUpSupplier:strtime type:self];
}

- (void)loginSuccess:(NSNotification*)noti
{
    
    //按时间 周期性 获取同步数据，
    [self syncup];
    _syncTimer = [NSTimer scheduledTimerWithTimeInterval:_syncTime target:self
                                                selector:@selector(syncData:) userInfo:nil repeats:YES];
    
    //登录一次获取一次
    [self syncupWhenLogin];
}

- (id)init{
    if (self = [super init]){
        _syncTime = kSyncTimeDefault;
    }
    
    return self;
}

- (void)setSyncTime:(int)syncTime
{
    if (_syncTime != syncTime){
        [_syncTimer invalidate];
//        [_syncTimer release];
        _syncTimer = nil;
        
        _syncTime = syncTime;
        _syncTimer = [NSTimer scheduledTimerWithTimeInterval:_syncTime target:self
                                                    selector:@selector(syncData:) userInfo:nil repeats:YES];
    }
}

- (void)initDataBase
{
    NSString* dbName = @"eSeller4iPad0303.sqlite";
    NSString* dbPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), dbName];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    //BOOL bOK = NO;
    //NSError* error = nil;
    
    if ([fm fileExistsAtPath:dbPath] == NO)
    {
       // bOK = [fm createDirectoryAtPath:dbPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    _fmdb = [[FMDatabase alloc] initWithPath:dbPath];
    
    [_fmdb open];
    
    [_fmdb setShouldCacheStatements:YES];
    
//    [[ZNotification sharedInstance] registerObserver:self selector:@selector(loginSuccess:) message:kLoginSuccess];
    
    [self createTables];
}

-(void)invalidateTimer
{
    if(_syncTimer) {
        [_syncTimer invalidate];
        _syncTimer = nil;
    }
}

-(void)logoutDB
{
    if(_syncTimer) {
        [_syncTimer invalidate];
        _syncTimer = nil;
    }
//    [_fmdb clearCachedStatements];
//    [_fmdb close];
}

#pragma mark
#pragma mark add operation for Item dto offline data
- (BOOL)addItemDtoArray:(NSArray*)items
{
    if([items count]> 1){
        NSMutableString* values = [[NSMutableString alloc]init];
        NSMutableString* skuvalues = [[NSMutableString alloc]init];
        NSString* strSql = [NSString stringWithFormat:@"replace into goods (id, name_number, kuanHao, itemName, itemCompany, itemCategory, itemBrand, buyprice, saleprice,pointvalue, picurl,count, synctime, namepinyin, numberpinyin, discount, used) values "];
        NSString* strColorSql = [NSString stringWithFormat:@"replace into goodsColorSize (itemId, colorId, color,sizeId, size, count) values "];
        
        [values appendString:strSql];
        [skuvalues appendString:strColorSql];
        int skuCount = 0;
        for(int i=0;i<[items count];i++){
            ZItemDTO* item = [items objectAtIndex:i];
            NSString* namepy = [self pinyin:item.name];
            NSString* numberpy = [self pinyin:item.kuanHao];
            NSNumber * flag = [NSNumber numberWithBool:item.used];

            [values appendString:[NSString stringWithFormat:@"(%d, '%@-%@', '%@', '%@','%@', '%@', '%@', '%@', '%@','%@','%@','%d','%@', '%@', '%@', '%@','%@')", [item.itemId intValue], item.kuanHao, item.name, item.kuanHao,item.name, item.itemCompany, item.itemCategory,item.itemBrand, item.buyerPrice, item.salePrice, item.pointValue, item.pictureUrl,[item.remainCount intValue], item.syncTime, namepy, numberpy,item.disCount, flag]];
            [values appendString:@","];
            if([item.skuPropertyDTOs count]>0){
                if([item.skuPropertyDTOs count] == 1 ){
                    ZSkuPropertyDTO* sku = [item.skuPropertyDTOs objectAtIndex:0];
                    if([sku.itemColor isEqualToString:@"均色"]){
                        
                    } else{
                        [skuvalues appendString:[NSString stringWithFormat:@"('%d','%d','%@','%d','%@','%d')", [item.itemId intValue], [sku.itemColorId intValue], sku.itemColor,[sku.itemSizeId intValue], sku.itemSize, [sku.count intValue]]];
                        [skuvalues appendString:@","];
                    }
                } else {
                    for (ZSkuPropertyDTO* sku in item.skuPropertyDTOs) {
                        skuCount++;
                        [skuvalues appendString:[NSString stringWithFormat:@"('%d','%d','%@','%d','%@','%d')", [item.itemId intValue], [sku.itemColorId intValue], sku.itemColor,[sku.itemSizeId intValue], sku.itemSize,[sku.count intValue]]];
                        [skuvalues appendString:@","];
                    }
                }
            }
            if(i!=0 && (i%100 == 0 || skuCount>=400)) {
                skuCount = 0;
                NSRange range = NSMakeRange(values.length-1, 1);
                [values replaceCharactersInRange:range withString:@";"];
                NSRange skurange = NSMakeRange(skuvalues.length-1, 1);
                [skuvalues replaceCharactersInRange:skurange withString:@";"];
                [_fmdb executeUpdate:values];
                [_fmdb executeUpdate:skuvalues];
                values = [[NSMutableString alloc]initWithString:strSql];
                skuvalues = [[NSMutableString alloc]initWithString:strColorSql];
            }
        }
        if(![values isEqualToString:strSql]) {
            NSRange range = NSMakeRange(values.length-1, 1);
            [values replaceCharactersInRange:range withString:@";"];
            [_fmdb executeUpdate:values];
        }
        if (![skuvalues isEqualToString:strColorSql]) {
            NSRange skurange = NSMakeRange(skuvalues.length-1, 1);
            [skuvalues replaceCharactersInRange:skurange withString:@";"];
            [_fmdb executeUpdate:skuvalues];
        }
        
    } else if([items count] == 1) {
        [self addItemDto:[items objectAtIndex:0]];
    }
    return ![_fmdb hadError];
}
- (BOOL)addItemCGOrderDto:(ZItemCGOrderDTO*)item
{
    @autoreleasepool {
        NSString* namepy = [self pinyin:item.name];
        NSString* numberpy = [self pinyin:item.kuanHao];
        NSNumber * flag = [NSNumber numberWithBool:true];
        
        NSString* strSql = [NSString stringWithFormat:@"replace into goods (id, name_number, kuanHao, itemName, itemCompany, itemCategory, itemBrand, buyprice, saleprice,pointvalue, picurl, synctime, namepinyin, numberpinyin, discount, used) values ('%d', '%@-%@', '%@', '%@','%@', '%@', '%@', '%@','%@', '%@','%@','%d','%@','%@', '%@', '%@','%@')", [item.itemId intValue], item.kuanHao, item.name, item.kuanHao,item.name, item.itemCompany, item.itemCategory,item.itemBrand, item.buyerPrice, item.itemPrice,@"0", item.pictureUrl, [item.totalCount intValue], @"2013-01-01 00:00:00", namepy, numberpy,item.disCount, flag];
        
        [_fmdb executeUpdate:strSql];
        
        for (ZSkuPropertyDTO* sku in item.skuPropertyDTOs) {
            NSString* strColorSql = [NSString stringWithFormat:@"replace into goodsColorSize (itemId, colorId, color) values ('%d','%d','%@','%d','%@')", [item.itemId intValue], [sku.itemColorId intValue], sku.itemColor,[sku.itemSizeId intValue], sku.itemSize];
            [_fmdb executeUpdate:strColorSql];
        }
        return ![_fmdb hadError];
    }
}
- (BOOL)addItemDto:(ZItemDTO*)item
{
    @autoreleasepool {
        NSString* namepy = [self pinyin:item.name];
        NSString* numberpy = [self pinyin:item.kuanHao];
        NSNumber * flag = [NSNumber numberWithBool:item.used];
        
        NSString* strSql = [NSString stringWithFormat:@"replace into goods (id, name_number, kuanHao, itemName, itemCompany, itemCategory, itemBrand, buyprice, saleprice,pointvalue, picurl,count, synctime, namepinyin, numberpinyin, discount, used) values ('%d', '%@-%@', '%@', '%@','%@', '%@', '%@', '%@','%@', '%@','%@','%d','%@','%@', '%@', '%@','%@')", [item.itemId intValue], item.kuanHao, item.name, item.kuanHao,item.name, item.itemCompany, item.itemCategory,item.itemBrand, item.buyerPrice, item.salePrice,item.pointValue, item.pictureUrl,[item.remainCount intValue], item.syncTime, namepy, numberpy,item.disCount, flag];
        
        [_fmdb executeUpdate:strSql];
        
        for (ZSkuPropertyDTO* sku in item.skuPropertyDTOs) {
            NSString* strColorSql = [NSString stringWithFormat:@"replace into goodsColorSize (itemId, colorId, color,sizeId, size,count) values ('%d',  '%d', '%@','%d','%@','%d')", [item.itemId intValue], [sku.itemColorId intValue], sku.itemColor,[sku.itemSizeId intValue], sku.itemSize, [sku.count intValue]];
            [_fmdb executeUpdate:strColorSql];
        }
        
        
        return ![_fmdb hadError];
    }
}

-(BOOL)deleteUnusedCustomerPrice
{
    NSString* strSql = [NSString stringWithFormat:@"delete from customeritemorders where itemId in (select id from goods where used = 0)"];
    [_fmdb executeQuery:strSql];
    
    return ![_fmdb hadError];
}

-(BOOL)addCustomerItemPriceArray:(NSArray*)priceDTOs now:(NSDate*)now
{
    if([priceDTOs count]> 1) {
        
        NSString* strSql = @"insert into customeritemorders ( itemId, customerId, lastPrice, lastDiscount, used, updateon) values ";
        NSMutableString* values = [[NSMutableString alloc]init];
        [values appendString:strSql];
        
        for(int i=0;i<[priceDTOs count];i++){
            ZCustomerItemPriceDTO* priceDTO = [priceDTOs objectAtIndex:i];
            
            [values appendString:[NSString stringWithFormat:@"('%@', '%@', '%@','%@', '%d', '%@')", priceDTO.itemId, priceDTO.customerId, priceDTO.lastPrice, priceDTO.lastDiscount, 1, priceDTO.created]];
            [values appendString:@","];
            if(i!=0 && i%300 == 0) {
                NSRange range = NSMakeRange(values.length-1, 1);
                [values replaceCharactersInRange:range withString:@";"];
                [_fmdb executeUpdate:values];
                values = [[NSMutableString alloc]initWithString:strSql];
            }
        }
        if(![values isEqualToString:strSql]) {
            NSRange range = NSMakeRange(values.length-1, 1);
            [values replaceCharactersInRange:range withString:@";"];
            [_fmdb executeUpdate:values];
        }
    }
    else if([priceDTOs count] == 1) {
        [self addCustomerItemPrice:[priceDTOs objectAtIndex:0] now:nil];
    }
    priceDTOs = nil;
    return ![_fmdb hadError];
}

-(BOOL)addCustomerItemPrice:(ZCustomerItemPriceDTO*)priceDTO now:(NSDate*)now
{
//    customeritemorders (id int primary key, itemId text, customerId text,lastPrice text,lastDiscount text, used int, field1 text, field2 text, field3 text)
    NSString* strSql = [NSString stringWithFormat:@"insert into customeritemorders ( itemId, customerId, lastPrice, lastDiscount, used, updateon) values ('%@', '%@', '%@','%@', '%d', '%@')", priceDTO.itemId, priceDTO.customerId, priceDTO.lastPrice, priceDTO.lastDiscount, 1, priceDTO.created];
    
    [_fmdb executeUpdate:strSql];

     return ![_fmdb hadError];

}

-(ZCustomerItemPriceDTO*)queryByCustomerAndItem:(NSNumber*)customerId itemId:(NSNumber*)itemId
{
    NSString* strSql = [NSString stringWithFormat:@"select * from customeritemorders where customerId ='%@' and itemId = '%@' order by updateon desc limit 1",customerId, itemId];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    ZCustomerItemPriceDTO* rtnDto = nil;
    while ([rs next]) {
        rtnDto = [[ZCustomerItemPriceDTO alloc]init];
        rtnDto.itemId = [NSNumber numberWithLong:[rs longForColumn:@"itemId"]];
        rtnDto.customerId = [NSNumber numberWithLong:[rs longForColumn:@"customerId"]];
        rtnDto.lastPrice = [NSNumber numberWithFloat:[[rs stringForColumn:@"lastPrice"] floatValue]];
        rtnDto.lastDiscount =[NSNumber numberWithFloat:[[rs stringForColumn:@"lastDiscount"] intValue]];
    }
    [rs close];
    return rtnDto;
}

//如果是DEMO， shopID=1. 否则 shopID不等于1.
-(void)saveShopID:(NSNumber*)shopId
{
    NSNumber* localShopId = [self getShopID];
    
    if(localShopId) {
        //2 是演示账户的商店 ID。
        if([localShopId intValue] != [shopId intValue])
        {
            [self clearAllTables];
        }
    }
    [self updateShopId:shopId];
}
-(void)clearAllTables
{
    [self clearTable:@"goods"];
    [self clearTable:@"goodsColorSize"];
    [self clearTable:@"customer"];
    [self clearTable:@"user"];
    [self clearTable:@"supplier"];
    [self clearTable:@"fzgoods"];
    [self clearTable:@"itemdiscount"];
    [self clearTable:@"itemcolor"];
    [self clearTable:@"itemseason"];
    [self clearTable:@"itemsize"];
    [self clearTable:@"itembrand"];
    [self clearTable:@"itemcat"];
    [self clearTable:@"itemexpense"];
    [self clearTable:@"mykuaidi"];
    [self clearTable:@"shopsaler"];
    [self clearTable:@"othershops"];
    [self clearTable:@"uncommitTrade"];
    [self clearTable:@"customeritemorders"];
    
    [self clearSysSettingTable];
}

-(void)reCreateTables
{
    [self dropTable:@"goods"];
    [self dropTable:@"goodsColorSize"];
    [self dropTable:@"customer"];
    [self dropTable:@"user"];
    [self dropTable:@"supplier"];
    [self dropTable:@"fzgoods"];
    [self dropTable:@"itemdiscount"];
    [self dropTable:@"itemcolor"];
    [self dropTable:@"itemseason"];
    [self dropTable:@"itemordermemo"];
    [self dropTable:@"itemsize"];
    [self dropTable:@"itembrand"];
    [self dropTable:@"itemcat"];
    [self dropTable:@"itemexpense"];
    [self dropTable:@"mykuaidi"];
    [self dropTable:@"uncommitTrade"];
    [self dropTable:@"shopsaler"];
    [self dropTable:@"othershops"];
    [self dropTable:@"customeritemorders"];
    
    [self clearSysSettingTable];
    
    [self createTables];
}

-(BOOL)dropTable:(NSString*)str
{
    NSString* strFmt = @"drop table %@ ";
    
    NSString* strSql = [NSString stringWithFormat:strFmt, str];
    
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}
-(BOOL)clearTable:(NSString*)str
{
    
    NSString* strFmt = @"delete from %@ ";
    
    NSString* strSql = [NSString stringWithFormat:strFmt, str];
    
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}
-(BOOL)clearSysSettingTable
{
    NSString* strSql = @"delete from syssetting where id < 10";
    
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}


- (BOOL)deleteGoodsItem:(ZItemDTO*)item{

//    [_fmdb beginTransaction];
    
    NSString* strFmt = @"delete from goods where id = '%@'";
    
    NSString* strSql = [NSString stringWithFormat:strFmt, [item.itemId intValue]];
    
    [_fmdb executeUpdate:strSql];
    
    //[_fmdb commit];
    
    return ![_fmdb hadError];
}

#pragma mark
#pragma mark get item sync time
- (NSString*)getLastSyncTime:(NSString*)table
{
    @autoreleasepool {
        NSString * tempDate = @"2013-01-01 00:00:00";
        //    [_fmdb beginTransaction];
        
        NSString* strSql = [NSString stringWithFormat:@"select field1 from syssetting where type ='%@'",table];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSString* strTime = nil;
        while ([rs next]) {
            strTime = [NSString stringWithFormat:@"%@", [rs stringForColumn:@"field1"]];
        }
        [rs close];
        //[_fmdb commit];
        if(strTime == nil || [strTime length]<16) {
            strTime = tempDate;
        }
        return strTime;        
    }
}

- (NSArray*)getGoodsNameNumberUsed:(NSString*)text
{
    @autoreleasepool {
        
        NSString* strSql = [NSString stringWithFormat:@"select id, name_number from goods where used = 1 and (name_number like '%%%@%%' \
                            or namepinyin like '%%%@%%' or numberpinyin  like '%%%@%%') order by id limit 10", text, text, text];
        if(text.length > 1) {
            strSql = [NSString stringWithFormat:@"select id, name_number from goods where used = 1 and (name_number like '%%%@%%' \
                      or namepinyin like '%%%@%%' or numberpinyin  like '%%%@%%') order by id", text, text, text];
        }
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name_number"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
    }
}

- (NSArray*)getGoodsColorArray:(NSNumber*)itemId
{
    @autoreleasepool {
      
        NSString* strSql = [NSString stringWithFormat:@"select colorId, color from goodsColorSize where itemId = %d group by color", [itemId intValue] ];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"colorId"]];
            dto.displayString = [rs stringForColumn:@"color"];
            [array addObject:dto];
        }
        [rs close];
        
        if([array count]==0){
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [[ZDataCache sharedInstance] getAverageColorId];
            dto.displayString = @"均色";
            [array addObject:dto];
        }
        
        return array;
    }
}
- (NSArray*)getGoodsKuanHaoDTOArray:(NSString*)text
{
    @autoreleasepool {
        
        NSString* strSql = [NSString stringWithFormat:@"select id,itemBrand, itemCategory,kuanHao from goods where (kuanHao like '%%%@%%' or numberpinyin like '%%%@%%') and used = 1 order by id limit 10", text, text];
        if(text.length > 1) {
            strSql = [NSString stringWithFormat:@"select id,itemBrand, itemCategory,kuanHao from goods where (kuanHao like '%%%@%%' or numberpinyin like '%%%@%%') and used = 1 order by id", text, text];
        }
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
        BOOL displayBrand = [[ZDataCache sharedInstance] getIfDisplayItemBrandCat];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            NSString* disStr = @"";
            if(displayBrand) {
                NSString* brand = [rs stringForColumn:@"itemBrand"];
                NSString* cat =[rs stringForColumn:@"itemCategory"];
                disStr = [NSString stringWithFormat:@"%@%@-%@", brand, cat, [rs stringForColumn:@"kuanHao"]];
            } else {
                disStr = [NSString stringWithFormat:@"%@", [rs stringForColumn:@"kuanHao"]];
            }
            
            dto.displayString = disStr;//[rs stringForColumn:@"kuanHao"];
            [array addObject:dto];
        }
        [rs close];
        return array;
    }
}

- (NSNumber*)getGoodsIdByKuanHao:(NSString*)kuanhao
{
    @autoreleasepool {
        
        NSString* strSql = [NSString stringWithFormat:@"select id from goods where kuanHao = '%@'", kuanhao];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSNumber* rowid = nil;
        while ([rs next]) {
            rowid = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
        }
        [rs close];
        return rowid;
    }
}

- (NSArray*)getGoodsNameDTOArray:(NSString*)text
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,itemName from goods where (itemName like '%%%@%%' or namepinyin like '%%%@%%') and used = 1 group by itemName order by itemName limit 10", text, text];
        if(text.length > 1) {
            strSql = [NSString stringWithFormat:@"select id,itemName from goods where (itemName like '%%%@%%' or namepinyin like '%%%@%%') and used = 1 group by itemName order by itemName", text, text];
        }
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"itemName"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
        
    }
}
- (NSArray*)getGoodsDTO:(NSString*)text
{
    //id, name_number, color, size, buyprice, saleprice, picurl, synctime, namepinyin, numberpinyin
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id, name_number from goods where (name_number like '%%%@%%' \
                            or namepinyin like '%%%@%%' or numberpinyin  like '%%%@%%') and used = 1 order by name_number limit 10", text, text, text];
        if(text.length > 1) {
            strSql = [NSString stringWithFormat:@"select id, name_number from goods where (name_number like '%%%@%%' \
                      or namepinyin like '%%%@%%' or numberpinyin  like '%%%@%%') and used = 1 order by name_number", text, text, text];
        }
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:20];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name_number"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
    }
}

- (NSArray*)getGoodsLocalDTOByPage:(ZConditionDTO*) dto
{
    //id, name_number, color, size, buyprice, saleprice, picurl, synctime, namepinyin, numberpinyin
    
    int offset = [dto.pageNo intValue] * [dto.pageSize intValue];
    
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id, kuanHao, itemName, count,saleprice from goods where used = 1 order by name_number limit %@ offset %d", dto.pageSize,offset];
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:20];
        while ([rs next]) {
            ZOrderDTO *dto = [[ZOrderDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.kuanHao = [rs stringForColumn:@"kuanHao"];
            dto.name = [rs stringForColumn:@"itemName"];
            dto.itemPrice =[NSNumber numberWithInt:[rs intForColumn:@"saleprice"]];
            dto.total = [NSNumber numberWithInt:[rs intForColumn:@"count"]];
            [array addObject:dto];
        }
        [rs close];
        return array;
    }
}
-(NSArray*)getGoodsLocalSKUDTOByPage:(ZConditionDTO*) condDto {
    NSArray* items = [self getGoodsLocalDTOByPage:condDto];
    @autoreleasepool {
        for(ZItemDTO* dto in items) {
            NSString* strSql = [NSString stringWithFormat:@"select itemId,colorId, color, sizeId,size,count from goodsColorSize where itemId=%@ ", dto.itemId];
            
            FMResultSet *rs = [_fmdb executeQuery:strSql];
            NSMutableArray* skuDtos = [[NSMutableArray alloc]init];
            ZSkuPropertyDTO* skuDto = nil;
            while ([rs next]) {
                skuDto = [[ZSkuPropertyDTO alloc]init];
                //            skuDto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"itemId"]];
                skuDto.itemColorId = [NSNumber numberWithInt:[rs intForColumn:@"colorId"]];
                skuDto.itemSizeId = [NSNumber numberWithInt:[rs intForColumn:@"sizeId"]];
                skuDto.itemColor = [rs stringForColumn:@"color"];
                skuDto.itemSize = [rs stringForColumn:@"size"];
                skuDto.count = [NSNumber numberWithInt:[rs intForColumn:@"count"]];
                [skuDtos addObject:skuDto];
            }
            [rs close];
            dto.skuPropertyDTOs = skuDtos;
        }
        return items;
    }
}


- (NSArray*)getGoodsDTOWithItemFZ:(NSString*)text
{
    //id, name_number, color, size, buyprice, saleprice, picurl, synctime, namepinyin, numberpinyin
    @autoreleasepool {
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:20];
        NSString* strSql = [NSString stringWithFormat:@"select id, itemBrand, itemCategory, name_number from goods where used = 1 and (name_number like '%%%@%%' \
                            or namepinyin like '%%%@%%' or numberpinyin  like '%%%@%%') order by name_number limit 10", text, text, text];
        if(text.length > 1) {
            strSql = [NSString stringWithFormat:@"select id, itemBrand, itemCategory, name_number from goods where used = 1 and (name_number like '%%%@%%' \
                      or namepinyin like '%%%@%%' or numberpinyin  like '%%%@%%') order by name_number", text, text, text];
        }
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        BOOL displayBrand = [[ZDataCache sharedInstance] getIfDisplayItemBrandCat];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            NSString* disStr = @"";
            if(displayBrand) {
                NSString* brand = [rs stringForColumn:@"itemBrand"];
                if ([brand isEqual:@"(null)"]) {
                    brand = @"";
                }
                NSString* cat =[rs stringForColumn:@"itemCategory"];
                disStr = [NSString stringWithFormat:@"%@%@-%@", brand,cat, [rs stringForColumn:@"name_number"]];
            } else {
                disStr = [NSString stringWithFormat:@"%@", [rs stringForColumn:@"name_number"]];
            }
            dto.displayString = disStr;
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        NSArray* fzgoods = [self getFZGoodsNameNumberArray:text];
//
//        if([array count] > 0) {
//            NSUInteger index1 = [array count] -1;
//            [array insertObjects:fzgoods atIndexes:[NSIndexSet indexSetWithIndex:index1]];
//        } else
        {
            [array addObjectsFromArray:fzgoods];
        }

        return array;
    }
}

//根据客户Id和货品ID，后去这个客户历史记录中的这个货品的价格。
//在交易的order表中，记录了货品最后的创建时间，这个时间，作为同步的时间。
- (ZItemDTO*)getGoodsDTOByCustomerAndId:(NSNumber*)customer itemId:(NSNumber*)itemId
{
    return nil;
}

- (ZItemDTO*)getGoodsDTOById:(NSNumber*)itemId
{
    @autoreleasepool {
        
        //id, name_number, kuanHao, itemName, color, size, buyprice, saleprice, picurl, synctime, namepinyin, numberpinyin
        NSString* strSql = [NSString stringWithFormat:@"select id,kuanHao, itemName, itemCompany,itemCategory,itemBrand, saleprice, buyprice, pointvalue, picurl,discount from goods where id=%@ ", itemId];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        ZItemDTO *dto = [[ZItemDTO alloc]init];
        while ([rs next]) {
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.itemCompany =[rs stringForColumn:@"itemCompany"];
            dto.itemCategory = [rs stringForColumn:@"itemCategory"];
            dto.itemBrand =[rs stringForColumn:@"itemBrand"];
            dto.kuanHao = [rs stringForColumn:@"kuanHao"];
            dto.name = [rs stringForColumn:@"itemName"];
            dto.salePrice = [NSNumber numberWithFloat:[[rs stringForColumn:@"saleprice"] floatValue]];
            dto.buyerPrice = [NSNumber numberWithFloat:[[rs stringForColumn:@"buyprice"] floatValue]];
            dto.disCount = [NSNumber numberWithInt:[rs intForColumn:@"discount"]];
            dto.pointValue =[NSNumber numberWithInt:[rs intForColumn:@"pointvalue"]];
        }
        [rs close];
        return dto;
    }
}
- (NSMutableArray*)getGoodsSkuByItemId:(NSNumber*)itemId colorId:(NSNumber*)colorId
{
    @autoreleasepool {
        
        //id, name_number, kuanHao, itemName, color, size, buyprice, saleprice, picurl, synctime, namepinyin, numberpinyin
        NSString* strSql = [NSString stringWithFormat:@"select itemId,colorId, color, sizeId,size,count from goodsColorSize where itemId=%@ and colorId = %@", itemId, colorId];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* skuDtos = [[NSMutableArray alloc]init];
        ZSkuPropertyDTO* skuDto = nil;
        while ([rs next]) {
            skuDto = [[ZSkuPropertyDTO alloc]init];
            //            skuDto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"itemId"]];
            skuDto.itemColorId = [NSNumber numberWithInt:[rs intForColumn:@"colorId"]];
            skuDto.itemSizeId = [NSNumber numberWithInt:[rs intForColumn:@"sizeId"]];
            skuDto.itemColor = [rs stringForColumn:@"color"];
            skuDto.itemSize = [rs stringForColumn:@"size"];
            skuDto.count = [NSNumber numberWithInt:[rs intForColumn:@"count"]];
            [skuDtos addObject:skuDto];
        }
        [rs close];
        return skuDtos;
    }
}
- (ZItemDTO*)getGoodsDTOWithSkuById:(NSNumber*)itemId
{
    ZItemDTO *dto = [self getGoodsDTOById:itemId];
    //itemId int,colorId int, color text, sizeId int, size text,
    @autoreleasepool {
        
        //id, name_number, kuanHao, itemName, color, size, buyprice, saleprice, picurl, synctime, namepinyin, numberpinyin
        NSString* strSql = [NSString stringWithFormat:@"select itemId,colorId, color, sizeId,size,count from goodsColorSize where itemId=%@ ", itemId];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* skuDtos = [[NSMutableArray alloc]init];
        ZSkuPropertyDTO* skuDto = nil;
        while ([rs next]) {
            skuDto = [[ZSkuPropertyDTO alloc]init];
//            skuDto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"itemId"]];
            skuDto.itemColorId = [NSNumber numberWithInt:[rs intForColumn:@"colorId"]];
            skuDto.itemSizeId = [NSNumber numberWithInt:[rs intForColumn:@"sizeId"]];
            skuDto.itemColor = [rs stringForColumn:@"color"];
            skuDto.itemSize = [rs stringForColumn:@"size"];
            skuDto.count = [NSNumber numberWithInt:[rs intForColumn:@"count"]];
            [skuDtos addObject:skuDto];
        }
        [rs close];
        dto.skuPropertyDTOs = skuDtos;
        return dto;
    }
}

-(BOOL)deleteUnusedData:(NSString*)table
{
    NSString* sql = [NSString stringWithFormat:@"delete from %@ where used =0 ", table];
    [_fmdb executeUpdate:sql];
    return ![_fmdb hadError];
}


#pragma mark
#pragma mark Item with pointValue dto  data
- (NSArray*)getPointGoodsNameNumberUsed:(NSString*)text
{
    @autoreleasepool {
        
        NSString* strSql = [NSString stringWithFormat:@"select id, name_number from goods where used = 1 and (name_number like '%%%@%%' \
                            or namepinyin like '%%%@%%' or numberpinyin  like '%%%@%%') and pointvalue not null order by id limit 10", text, text, text];
        if(text.length > 2) {
            strSql = [NSString stringWithFormat:@"select id, name_number from goods where used = 1 and (name_number like '%%%@%%' \
                      or namepinyin like '%%%@%%' or numberpinyin  like '%%%@%%') and pointvalue not null order by id", text, text, text];
        }
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name_number"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
    }
}
#pragma mark
-(BOOL)updateUpdateTime:(NSString*)table rowId:(NSNumber*)rowId{
    
    NSDate *now = [[NSDate alloc]init];
    NSString* strSql = [NSString stringWithFormat:@"replace into %@ (id, updateon) values ('%d', '%@')", table, [rowId intValue], now];
    [_fmdb executeUpdate:strSql];

     return ![_fmdb hadError];
}

#pragma mark
#pragma mark add operation for ItemColor dto offline data

- (BOOL)addItemColorDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from itemcolor"];
    for (ZItemColorDTO* item in items)
    {
        NSNumber * flag = [NSNumber numberWithBool:item.used];
        NSString* strSql = [NSString stringWithFormat:@"replace into itemcolor (id, name, code, used) values ('%d', '%@', '%@', '%d')", [item.rowid intValue], item.color, item.colorCode, flag.intValue];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
}

-(NSNumber*)getAvargeColorID
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemcolor where name ='%@'",@"均色"];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSNumber* colorid = nil;
        
        while ([rs next]) {
            colorid = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
        }
        [rs close];
        return colorid;
    }
}

- (ZItemColorDTO*)getItemColorByCode:(NSString*)colorCode
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemcolor where code ='%@'",colorCode];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        ZItemColorDTO* color = nil;
        
        while ([rs next]) {
            color = [[ZItemColorDTO alloc]init];
            color.rowid = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            color.color =[rs stringForColumn:@"name"];
            color.colorCode = colorCode;
        }
        [rs close];
        return color;
    }
}

- (BOOL)addItemColorDto:(ZItemColorDTO*)item
{
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    
    NSString* strSql = [NSString stringWithFormat:@"replace into itemcolor (id, name, code, used) values (%d, '%@', '%@',%d)", [item.rowid intValue], item.color, item.colorCode, flag.intValue];
    
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}
- (NSMutableArray*)getItemColorEnabled
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemcolor where used = %d order by name",1];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
    }
}

- (BOOL)addItemOrderMemoDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from itemordermemo"];
    for (ZItemOrderMemo* item in items)
    {
        NSNumber * flag = [NSNumber numberWithBool:item.used];
        NSString* strSql = [NSString stringWithFormat:@"replace into itemordermemo (id, name, used) values ('%d', '%@', '%d')", [item.rowid intValue], item.content, flag.intValue];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
}
- (BOOL)addItemOrderMemoDto:(ZItemOrderMemo*)item
{
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    
    NSString* strSql = [NSString stringWithFormat:@"replace into itemordermemo (id, name, used) values (%d, '%@', %d)", [item.rowid intValue], item.content, flag.intValue];
    
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}
- (NSMutableArray*)getItemOrderMemoEnabled
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemordermemo where used = %d order by name",1];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
    }
}

#pragma mark
#pragma mark add operation for ItemDiscount dto offline data
- (BOOL)addItemDiscountDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from itemdiscount"];
    for (ZItemDiscountDTO* item in items)
    {
//        if([[item.discount intValue] == :@"均色"])
//        {
//            [ZDataCache sharedInstance].averageDiscount = [item.itemDiscountId intValue];
//        }
        NSNumber * flag = [NSNumber numberWithBool:item.used];
        NSString* strSql = [NSString stringWithFormat:@"replace into itemdiscount (id, name, used) values ('%d', '%@', '%d')", [item.rowid intValue], item.discount, flag.intValue];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
}

- (BOOL)addItemDiscountDto:(ZItemDiscountDTO*)item
{
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    
    NSString* strSql = [NSString stringWithFormat:@"replace into itemdiscount (id, name, used) values (%d, '%@', %d)", [item.rowid intValue], item.discount, flag.intValue];
    
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}


- (NSArray*)getItemDiscountEnabled
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemdiscount where used = %d order by name",1];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
    }
}

#pragma mark
#pragma mark add operation for Supplier offline data
- (BOOL)addSupplierDto:(ZItemCompanyDTO*)item
{
    NSString* namepy = [self pinyin:item.name];
    NSNumber * flag = [NSNumber numberWithBool:item.used];
        //id i, name  address ,telephone ,created ,pictureUrl ,synctime , namepinyin 
    NSString* strSql = [NSString stringWithFormat:@"replace into supplier (id, name, address,telephone,created,pictureUrl,synctime, namepinyin,used) values ('%d', '%@', '%@','%@','%@','%@','%@','%@','%d')", [item.itemCompanyId intValue], item.name, item.address,item.telephone,item.created,item.pictureUrl,item.syncTime, namepy, flag.intValue];
    
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}
- (NSArray*)getSupplierNameArray:(NSString*)text
{

    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from supplier where used =%d and (name like '%%%@%%' or namepinyin like '%%%@%%')  order by name", 1,text, text];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO* dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString =[rs stringForColumn:@"name"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
        
    }
}

-(void)addSupplierWithLocalSyncTime:(ZItemCompanyDTO*)item
{
    NSString *strtime = [self getLastSyncTime:@"supplier"];
    item.syncTime = strtime;
    [self addSupplierDto:item];
    
}
//-(void)addItemColor:(ZItemColorDTO*)item
//{
////    NSString *strtime = [self getLastSyncTime:@"itemcolor"];
////    item.syncTime = strtime;
//    [self addItemColorDto:item];
//    
//}
//-(void)addItemSizeWithLocalSyncTime:(ZItemSizeDTO*)item
//{
////    NSString *strtime = [self getLastSyncTime:@"itemsize"];
////    item.syncTime = strtime;
//    [self addItemSizeDto:item];
//    
//}
//-(void)addItemCatgoryWithLocalSyncTime:(ZItemCategoryDTO*)item
//{
////    NSString *strtime = [self getLastSyncTime:@"itemcat"];
////    item.syncTime = strtime;
//    [self addItemCatDto:item];
//}
#pragma mark
#pragma mark add operation for ItemCat dto offline data
- (BOOL)addItemCatDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from itemcat"];
    for (ZItemCategoryDTO* item in items)
    {
        
         NSNumber * flag = [NSNumber numberWithBool:item.used];
        NSString* namepy = [self pinyin:item.name];
        NSString* strSql = [NSString stringWithFormat:@"replace into itemcat (id, name,namepinyin, code, used) values ('%d', '%@','%@','%@', '%d')", [item.rowid intValue], item.name, namepy, item.catCode, flag.intValue];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
    
}

- (BOOL)addItemCatDto:(ZItemCategoryDTO*)item
{
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    NSString* namepy = [self pinyin:item.name];
    NSString* strSql = [NSString stringWithFormat:@"replace into itemcat (id, name, namepinyin, code, used) values ('%d', '%@','%@', '%@','%d')", [item.rowid intValue], item.name, namepy,item.catCode, flag.intValue];
    
    [_fmdb executeUpdate:strSql];
    
    //ZLogInfo(@"addFZItemDto : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}
- (ZItemCategoryDTO*)getItemCatByCode:(NSString*)catCode
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemcat where code = '%@ ",catCode];
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        ZItemCategoryDTO* itemCat = nil;
        while ([rs next]) {
            itemCat = [[ZItemCategoryDTO alloc]init];
            itemCat.rowid = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            itemCat.name = [rs stringForColumn:@"name"];
            itemCat.catCode = catCode;
            //[dto release]
        }
        [rs close];
        return itemCat;
        
    }

}

- (NSArray*)getItemCatEnabled:(NSString*)text
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemcat where (namepinyin like '%%%@%%' or name like '%%%@%%') and used =%d order by name",text, text, 1];
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
            //[dto release]
        }
        [rs close];
        return array;
        
    }
}
#pragma mark
#pragma mark add operation for ItemCat dto offline data
- (BOOL)addItemExpenseDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from itemexpense"];
    for (ZItemExpenseDTO* item in items)
    {
        NSString* namepy = [self pinyin:item.name];
        NSNumber * flag = [NSNumber numberWithBool:item.used];
        NSString* strSql = [NSString stringWithFormat:@"replace into itemexpense (id, name, price, used, namepinyin) values ('%d', '%@', '%@', '%d', '%@')", [item.rowid intValue], item.name, item.price, flag.intValue, namepy];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
}

- (BOOL)addItemExpenseDto:(ZItemExpenseDTO*)item
{
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    NSString* namepy = [self pinyin:item.name];
    NSString* strSql = [NSString stringWithFormat:@"replace into itemexpense (id, name, price, used, namepinyin) values ('%d', '%@', '%@', '%d', '%@')", [item.rowid intValue], item.name, item.price, flag.intValue, namepy];
    
    [_fmdb executeUpdate:strSql];
    return ![_fmdb hadError];
}

- (NSArray*)getItemExpenseEnabled:(NSString*)text
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemexpense where used =%d order by name", 1];
        if(text && ![text isEqualToString:@""]) {
            strSql = [NSString stringWithFormat:@"select id,name from itemexpense where namepinyin like '%%%@%%' or name like '%%%@%%' and used =%d order by name",text, text, 1];
        }
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:5];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
        }
        [rs close];
        return array;
        
    }
}
- (ZItemExpenseDTO*)getItemExpense:(NSNumber*)itemId
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name,price from itemexpense where id=%@", itemId];

        FMResultSet *rs = [_fmdb executeQuery:strSql];
        ZItemExpenseDTO* dto = [[ZItemExpenseDTO alloc] init];
        while ([rs next]) {
            dto.rowid = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.name = [rs stringForColumn:@"name"];
            NSString* price = [rs stringForColumn:@"price"];
            dto.price = [ NSNumber numberWithFloat:[price floatValue]];
        }
        [rs close];
        return dto;
        
    }
}


#pragma mark
#pragma mark add operation for KuaiDi dto offline data
- (BOOL)addMyKuaiDiDtos:(NSArray*)myKuaiDis
{

    [_fmdb executeUpdate:@"delete from mykuaidi"];
    
    for(ZKuaiDiInfoDTO *item in myKuaiDis) {
        NSString* strSql = [NSString stringWithFormat:@"insert into mykuaidi (id, name) values ('%d', '%@')", [item.kuaidiId intValue], item.kuaidiName];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
}
- (BOOL)addMyKuaiDiDto:(ZKuaiDiInfoDTO*)item
{
    
    NSString* strSql = [NSString stringWithFormat:@"replace into mykuaidi (id, name) values (%d, '%@')", [item.kuaidiId intValue], item.kuaidiName];
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}
- (BOOL)removeMyKuaiDiDto:(ZKuaiDiInfoDTO*)item
{

    NSString* strSql = [NSString stringWithFormat:@"delete from mykuaidi where id = %d ", [item.kuaidiId intValue]];
    [_fmdb executeUpdate:strSql];
    
    return ![_fmdb hadError];
}

- (NSArray*)getMyKuaiDi
{
    @autoreleasepool {
        FMResultSet *rs = [_fmdb executeQuery:@"select id,name from mykuaidi  order by name"];
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
        
    }
}
#pragma mark
#pragma mark add operation for ItemSize dto offline data
- (BOOL)addItemSizeDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from itemsize"];
    for (ZItemSizeDTO* item in items)
    {
        NSNumber * flag = [NSNumber numberWithBool:item.used];
        NSString* strSql = [NSString stringWithFormat:@"insert into itemsize (id, name, sequency, sizeCount, used, code) values ('%d', '%@', '%@','%@', '%d','%@')", [item.rowid intValue], item.size, item.sequency, item.sizeCount, flag.intValue, item.sizeCode];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
}
- (BOOL)addItemSizeDto:(ZItemSizeDTO*)item
{
    NSNumber * flag = [NSNumber numberWithBool:item.used];

    NSString* strSql = [NSString stringWithFormat:@"replace into itemsize (id, name, sequency,sizeCount, used,code ) values ('%d', '%@', '%@', '%@','%d','%@')", [item.rowid intValue], item.size, item.sequency, item.sizeCount, flag.intValue, item.sizeCode];
    
    [_fmdb executeUpdate:strSql];
    
    //ZLogInfo(@"addFZItemDto : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}
-(NSNumber*)getAvargeSizeID
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemsize where name ='%@'",@"均码"];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSNumber* colorid = nil;
        
        while ([rs next]) {
            colorid = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
        }
        [rs close];
        return colorid;
    }
}
-(ZItemSizeDTO*)getItemSizeByCode:(NSString*)sizecode
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemsize where code ='%@'",sizecode];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        ZItemSizeDTO* sizeDto= nil;
        
        while ([rs next]) {
            sizeDto = [[ZItemSizeDTO alloc]init];
            sizeDto.rowid = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            sizeDto.size = [rs stringForColumn:@"name"];
            sizeDto.sizeCode = sizecode;
        }
        [rs close];
        return sizeDto;
    }
}
-(ZItemSizeDTO*)getItemSizeCount:(NSNumber*)sizeid
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name,sizeCount from itemsize where id =%@",sizeid];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        ZItemSizeDTO* sizeDto = [[ZItemSizeDTO alloc]init];
        
        while ([rs next]) {
            sizeDto.size = [rs stringForColumn:@"name"];
            int sizecount =[rs intForColumn:@"sizeCount"];
            if(sizecount == 0) {
                sizeDto.sizeCount = [NSNumber numberWithInt:1];
            } else {
                sizeDto.sizeCount = [NSNumber numberWithInt:sizecount];
            }
        }
        [rs close];
        return sizeDto;
    }
}

- (NSMutableArray*)getItemSizeEnabled
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name,sequency from itemsize where used =%d order by sequency asc",1];
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* array = [[NSMutableArray alloc] init];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
        }
        [rs close];
        if([array count]>0) {
            return array;
        } else {
            return nil;
        }
    }
}
#pragma mark
#pragma mark Item Season
- (BOOL)addItemSeasonDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from itemseason"];
    for (ZItemSeason* item in items)
    {
        NSString* namepy = [self pinyin:item.season];
        NSString* strSql = [NSString stringWithFormat:@"insert into itemseason (id, name, namepinyin) values ('%d', '%@','%@')", [item.seasonId intValue], item.season, namepy];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
}

#pragma mark
#pragma mark add operation for itembrand
- (BOOL)addItemBrandDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from itembrand"];
    for (ZItemBrandDTO* item in items)
    {
        NSNumber * flag = [NSNumber numberWithBool:item.used];
        NSString* namepy = [self pinyin:item.name];
        NSString* strSql = [NSString stringWithFormat:@"insert into itembrand (id, name, namepinyin,used) values ('%d', '%@','%@', '%d')", [item.rowid intValue], item.name, namepy,flag.intValue];
        [_fmdb executeUpdate:strSql];
    }
    return ![_fmdb hadError];
}
- (BOOL)addItemBrandDto:(ZItemBrandDTO*)item
{
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    NSString* namepy = [self pinyin:item.name];
    NSString* strSql = [NSString stringWithFormat:@"replace into itembrand (id, name, namepinyin,used) values ('%d', '%@', '%@','%d')", [item.rowid intValue], item.name, namepy,flag.intValue];
    
    [_fmdb executeUpdate:strSql];
    
    //ZLogInfo(@"addFZItemDto : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (NSArray*)getItemBrandEnabled
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itembrand where used =%d order by name",1];
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
            //        [dto release];
        }
        [rs close];
        return array;
    }
}
- (NSArray*)getItemSeason
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from itemseason order by id"];
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
        }
        [rs close];
        return array;
    }
}

#pragma mark
#pragma mark add operation for ItemFZ dto offline data
////////////////////
- (BOOL)addItemFZDtoArray:(NSArray*)items
{
    [_fmdb executeUpdate:@"delete from fzgoods"];
    for(ZItemDTO* item in items)
    {
        NSString* namepy = [self pinyin:item.name];
        if ([namepy isEqualToString:@"(null)"]){
            namepy = @"";
        }
        NSString* kuanHaopy = [self pinyin:item.kuanHao];
        NSNumber * flag = [NSNumber numberWithBool:item.used];
        
        NSString* strSql = [NSString stringWithFormat:@"replace into fzgoods (id, kuanHao, name, name_number, saleprice, created, synctime, kuanhaopinyin, namepinyin,used) values ('%d', '%@', '%@','%@-%@', '%@', '%@', '%@', '%@', '%@','%@')", [item.itemId intValue], item.kuanHao,item.name, item.kuanHao,item.name,item.salePrice, item.created, item.syncTime,kuanHaopy, namepy, flag];
        
        [_fmdb executeUpdate:strSql];
    }
    
    return ![_fmdb hadError];
}
- (BOOL)addItemFZDto:(ZItemDTO*)item
{
    NSString* namepy = [self pinyin:item.name];
    NSString* kuanHaopy = [self pinyin:item.kuanHao];
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    
    NSString* strSql = [NSString stringWithFormat:@"replace into fzgoods (id, kuanHao, name, name_number, saleprice, created, synctime, kuanhaopinyin, namepinyin,used) values ('%d', '%@', '%@','%@-%@', '%@', '%@', '%@', '%@', '%@', '%@')", [item.itemId intValue], item.kuanHao,item.name, item.kuanHao,item.name,item.salePrice, item.created, item.syncTime,kuanHaopy, namepy,flag];
   
    [_fmdb executeUpdate:strSql];
    
    //ZLogInfo(@"addFZItemDto : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (BOOL)removeItemFZDto:(ZItemDTO*)item
{
    
//    [_fmdb beginTransaction];
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    NSString* strFmt = @"update fzgoods set used = %@ where id = '%@'";
    
    NSString* strSql = [NSString stringWithFormat:strFmt, flag, item.itemId ];
    
    [_fmdb executeUpdate:strSql];
    
    //[_fmdb commit];
    
    return ![_fmdb hadError];
}
//id int primary key, kuanhao text, name text,name_number text, price text, synctime text,created text,kuanhaopinyin text,  namepinyin text)
-(ZItemDTO*)getItemFZDTO:(NSNumber*)itemId
{
    NSString* strSql = [NSString stringWithFormat:@"select * from fzgoods where id = %@", itemId];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    ZItemDTO *dto = [[ZItemDTO alloc]init];
    while ([rs next]) {
        dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
        dto.name =[rs stringForColumn:@"name"];
        dto.kuanHao = [rs stringForColumn:@"kuanhao"];
        float saleprice =[[rs stringForColumn:@"saleprice"] floatValue];
        dto.salePrice = [NSNumber numberWithFloat:saleprice];
    }
    [rs close];
    return dto;
}

//- (NSArray*)getFZGoodsItemColumnArray:(NSString*)text column:(NSString*)strCol
//{
//    return [self getItemColumnArray:text column:strCol table:@"fzgoods"];
//}
//
//
//- (NSArray*)getFZGoodsIdArray:(NSString*)text
//{
//    return [self getFZGoodsItemColumnArray:text column:@"id"];
//}

- (NSArray*)getFZGoodsNameNumberArray:(NSString*)text
{
    //return [self getFZGoodsItemColumnArray:text column:@"name"];
    
    NSString* strSql = [NSString stringWithFormat:@"select id, name_number from fzgoods where used = 1 and (name_number like '%%%@%%' \
                        or namepinyin like '%%%@%%' or kuanhaopinyin  like '%%%@%%')  order by name_number limit 10", text, text, text];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
    
    while ([rs next]) {
        ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
        dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
        dto.displayString = [rs stringForColumn:@"name_number"];
        dto.isFZItem = YES;
        [array addObject:dto];
    }
    [rs close];
    return array;
}

////////////////////
#pragma mark
#pragma mark add operation for customers dto offline data
- (BOOL)addCustomerItem:(ZCustomerDTO*)item
{
    NSString* pinyin = [self pinyin:item.name];
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    
    NSString* strSql = [NSString stringWithFormat:@"replace into customer (id, name, phone, synctime, namepinyin, used,kuaiDiName, address, memo) values ('%d', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", [item.customerId intValue], item.name, item.telephone, item.syncTime, pinyin, flag, item.kuaiDiName, item.address, item.memo];
    
    [_fmdb executeUpdate:strSql];
    return ![_fmdb hadError];
}

- (BOOL)deleteCustomerItem:(ZCustomerDTO*)item{
//    [_fmdb beginTransaction];
    
    NSString* strFmt = @"delete from customer where id = '%@')";
    
    NSString* strSql = [NSString stringWithFormat:strFmt, [item.customerId intValue]];
    
    [_fmdb executeUpdate:strSql];
    
    //[_fmdb commit];
    return ![_fmdb hadError];
}


//- (NSArray*)getCustomerItemColumnArray:(NSString*)text column:(NSString*)strCol
//{
//    return [self getItemColumnArray:text column:strCol table:@"customer"];
//}
//
//
//- (NSArray*)getCustomerIdArray:(NSString*)text
//{
//    return [self getCustomerItemColumnArray:text column:@"id"];
//}

- (NSArray*)getCustomerNameArray:(NSString*)text
{
    //return [self getcustomerItemColumnArray:text column:@"name"];
    NSString* strSql = [NSString stringWithFormat:@"select id, name from customer where used = 1 and (name like '%%%@%%' \
                         or namepinyin like '%%%@%%') order by name limit 10", text, text];
    if(text.length > 1) {
        strSql = [NSString stringWithFormat:@"select id, name from customer where used = 1 and (name like '%%%@%%' \
                  or namepinyin like '%%%@%%') order by name", text, text];
    }
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
    
    while ([rs next]) {
        ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
        dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
        dto.displayString = [rs stringForColumn:@"name"];
        [array addObject:dto];
//        [dto release];
    }
[rs close];
    return array;
}

- (NSArray*)getCustomerPhoneNameArray:(NSString*)text
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name,phone from customer where (name like '%%%@%%' or namepinyin like '%%%@%%' or phone like '%%%@%%') and used=1 order by name limit 10", text, text, text];
        if(text.length > 1) {
            strSql = [NSString stringWithFormat:@"select id,name,phone from customer where (name like '%%%@%%' or namepinyin like '%%%@%%' or phone like '%%%@%%') and used=1 order by name", text, text, text];
        }
        
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            NSString* phone = [rs stringForColumn:@"phone"];
            if ([phone isEqualToString:@"(null)"]){
                phone = @"";
            }
            NSString *displaystr = [NSString stringWithFormat:@"%@,%@", [rs stringForColumn:@"name"], phone];
            dto.displayString = displaystr;
            [array addObject:dto];
        }
        [rs close];
        ////[_fmdb commit];
        
        return array;
    }
}

-(ZCustomerDTO*)getCustomerById:(NSNumber*)customerId
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name,phone, kuaiDiName,address,memo from customer where id = %@", customerId];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
//        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
        
        ZCustomerDTO *dto = [[ZCustomerDTO alloc]init];
        while ([rs next]) {
            dto.customerId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.name =[rs stringForColumn:@"name"];
            dto.telephone = [rs stringForColumn:@"phone"];
            dto.kuaiDiName = [rs stringForColumn:@"kuaiDiName"];
            dto.address =[rs stringForColumn:@"address"];
            dto.memo = [rs stringForColumn:@"memo"];
//            [array addObject:dto];
        }
        [rs close];
        
        return dto;
    }
}

-(void)updateCustomerAsTrade:(NSNumber*)customerId {
    
}

- (NSArray*)getCustomerPhoneArray:(NSString*)text
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,phone from customer where phone like '%%%@%%' order by phone ", text];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"phone"];
            [array addObject:dto];
        }
        [rs close];
        ////[_fmdb commit];
        
        return array;
    }
}

/////////////////////////////////////////////
#pragma mark
#pragma mark add operation for User dto offline data
- (BOOL)addSalerItem:(ZShopSalerDTO*)item
{
    NSString* pinyin = [self pinyin:item.name];
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    
    NSString* strSql = [NSString stringWithFormat:@"replace into shopsaler (id, name, synctime, namepinyin, used) values ('%d', '%@', '%@','%@', '%@')", [item.salerId intValue], item.name, item.syncTime, pinyin, flag];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"addUserItem : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (BOOL)deleteSalerItem:(ZShopSalerDTO*)item{
    //    [_fmdb beginTransaction];
    
    NSString* strFmt = @"delete from shopsaler shopsaler id = '%@')";
    
    NSString* strSql = [NSString stringWithFormat:strFmt, [item.salerId intValue]];
    
    [_fmdb executeUpdate:strSql];
    
    //[_fmdb commit];
    
    return ![_fmdb hadError];
}
-(ZPopupUIItemDTO*)getShopSaler:(int)salerId{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id,name from shopsaler where id=%d ", salerId];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        ZPopupUIItemDTO* dto = [[ZPopupUIItemDTO alloc] init];
        while ([rs next]) {
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
        }
        [rs close];
        return dto;
    }
}
- (NSArray*)getSalerNameArray:(NSString*)text
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id, name from shopsaler where used = 1 and (name like '%%%@%%' \
                            or namepinyin like '%%%@%%') order by name", text, text];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:5];
        
        while ([rs next]) {
            ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
            dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            dto.displayString = [rs stringForColumn:@"name"];
            [array addObject:dto];
        }
        [rs close];
        return array;
    }
}


/////////////////////////////////////////////
#pragma mark
#pragma mark add operation for User dto offline data
- (BOOL)addUserItem:(ZUserDTO*)item
{
    NSString* pinyin = [self pinyin:item.nickName];
    NSNumber * flag = [NSNumber numberWithBool:item.used];
    
    NSString* strSql = [NSString stringWithFormat:@"replace into user (id, name, nickname,roles,synctime, namepinyin, used) values ('%d', '%@', '%@','%@','%@', '%@', '%@')", [item.userId intValue], item.username, item.nickName, item.roles, item.syncTime, pinyin, flag];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"addUserItem : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (BOOL)deleteUserItem:(ZUserDTO*)item{
//    [_fmdb beginTransaction];
    
    NSString* strFmt = @"delete from user where id = '%@')";
    
    NSString* strSql = [NSString stringWithFormat:strFmt, [item.userId intValue]];
    
    [_fmdb executeUpdate:strSql];
    
    //[_fmdb commit];
    
    return ![_fmdb hadError];
}

//- (NSArray*)getUserItemColumnArray:(NSString*)text column:(NSString*)strCol
//{
//    return [self getItemColumnArray:text column:strCol table:@"user"];
//}
//
//- (NSArray*)getUserIdArray:(NSString*)text
//{
//    return [self getUserItemColumnArray:text column:@"id"];
//}

- (NSArray*)getUserNameArray:(NSString*)text
{
    @autoreleasepool {
    NSString* strSql = [NSString stringWithFormat:@"select id, nickname,roles from user where used = 1 and (nickname like '%%%@%%' \
                        or namepinyin like '%%%@%%') order by nickname limit 10", text, text];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:5];
    
    while ([rs next]) {
        NSString* roles = [rs stringForColumn:@"roles"];
        if([roles rangeOfString:@"manager"].length > 0 || [roles rangeOfString:@"BOSS"].length > 0) {
            continue;
        }
        ZPopupUIItemDTO *dto = [[ZPopupUIItemDTO alloc]init];
        dto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
        dto.displayString = [rs stringForColumn:@"nickname"];
        [array addObject:dto];
    }
    [rs close];
    return array;
}
}

- (NSString*)pinyin:(NSString*)text
{
    NSMutableString* pinyin = [[NSMutableString alloc] init];
    
//    NSString* hanzi = nil;
    
    for (int i = 0; i < [text length]; i++){
        int k = [text characterAtIndex:i];
        if (k >= 0x4e00 && k < 0x9FFF){
//            NSRange range;
//            range.location = i;
//            range.length = 1;
//            hanzi = [text substringWithRange:range];
            char py = pinyinFirstLetter(k);
            [pinyin appendFormat:@"%c", py];
        } else {
            [pinyin appendFormat:@"%c", k];
        }
    }
    
    return pinyin;
}
#pragma mark
#pragma mark create table for synctime
- (BOOL)updateSyncTime:(int)id tableName:(NSString*)tableName time:(NSString*)synctime
{
    //Key is TableName
    if(synctime == nil) {
        synctime = @"2013-01-01 00:00:00";
    }
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1) values (%d, '%@','%@')",id, tableName,synctime];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updateSyncTime : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

#pragma mark
#pragma mark create table for SheopSetting
//  13， 是否显示多颜色，尺寸。 14，开单时，是否显示折扣 15,... 16, 保存当前appid，判断用户是否注册过。决定是否显示注册按钮。
//17 是否使用字母键盘， 18， 小数点处理方式 ， 19 发货单打印方式。 30
//20 是否显示单一颜色尺寸 28 是否在款号提示中显示品牌类型。 
//1,2,3,4 表的synctime， 10，打印机信息 12, 店铺信息， 13， 是否显示颜色，尺寸。 14，开单时，是否显示折扣 15  16 是否已经登录成功
// 17 是否拼音 显示款号。19 是否打开热敏打印 21 不显示item的名称 22 快递打印机设置 23 快递发送者 信息 24 款号列表中显示品牌 25 电脑发货单打印 26 减少打印边距 27 模板类型 0有折扣，1无折扣,2名字换行 31 是否打开了电脑打印 32 是否打开蓝牙打印
-(BOOL)updateShopSetting:(int)property key:(NSString*)key value:(BOOL)value
{
    //key SUPPORT_COLORSIZE, SUPPORT_DISCOUNT
    NSString* strValue = [NSString stringWithFormat:@"%d", value];
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1) values ('%d','%@','%@')", property,key,strValue];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updateShopSetting : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}
-(BOOL)updateShopSettingInt:(int)property key:(NSString*)key value:(int)type
{
    //key SUPPORT_COLORSIZE, SUPPORT_DISCOUNT
    NSString* strValue = [NSString stringWithFormat:@"%d", type];
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1) values ('%d','%@','%@')", property,key,strValue];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updateShopSettingInt : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}
-(BOOL)updateShopSettingString:(int)property key:(NSString*)key value:(NSString*)value
{
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1) values ('%d','%@','%@')", property,key,value];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updateShopSettingInt : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

-(int)getTempleteType
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 27"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    int rtn = 0;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = 1;
        } else if([value isEqualToString:@"2"]){
            rtn = 2;
        }
    }
    [rs close];
    return rtn;
}

-(BOOL)getPrintDistance
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 26"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        }
    }
    [rs close];
    return rtn;
}

-(NSMutableDictionary*)getShopSetting
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id in (13,14,15)"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    NSMutableDictionary* dtos = [[NSMutableDictionary alloc]init];
    while ([rs next]) {
        NSString* type = [rs stringForColumn:@"type"];
        NSString* value = [rs stringForColumn:@"field1"];
        [dtos setObject:value forKey:type];
    }
    [rs close];
    return dtos;
}
-(NSString*)getHTTPToken
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1,field2 from syssetting where id = 40"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    NSString* token = nil;
    while ([rs next]) {
//        NSString* type = [rs stringForColumn:@"type"];
        token = [rs stringForColumn:@"field1"];
//        NSString* expireTime = [rs stringForColumn:@"field2"];
//        [dtos setObject:token forKey:type];
    }
    [rs close];
    return token;
}

-(BOOL)isSupportColorSize
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 13"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        }
    }
    [rs close];
    return rtn;
}
-(BOOL)isSupportDiscount
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 14"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        }
    }
    [rs close];
    return rtn;
}
-(BOOL)isSupportSingleColorSize
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 20"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        }
    }
    [rs close];
    return rtn;
}
-(BOOL)isAccountAfterPrint
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 15"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        }
    }
    [rs close];
    return rtn;
}
-(BOOL)ifHasLogined
{
//    if(true) {
//        return true;
//    }
    NSString* strSql = [NSString stringWithFormat:@"select type, field1, field2 from syssetting where id = 16"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    NSString* value1;
    NSString* value2;
    while ([rs next]) {
        value1 = [rs stringForColumn:@"field1"];
        value2 = [rs stringForColumn:@"field2"];
    }
    [rs close];
    if([value1 isEqualToString:value2]){
        return YES;
    }
    return NO;
}
-(BOOL)isUsePinYinInputKuanHao
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 17"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        }
    }
    [rs close];
    return rtn;
}
-(BOOL)isNotDisplayItemName
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 21"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        }
    }
    [rs close];
    return rtn;
}
-(BOOL)ifDisplayItemBrandCat
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 28"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        } else {
            rtn = false;
        }
    }
    [rs close];
    return rtn;
}
-(BOOL)ifPrintColorSize
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 29"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    BOOL rtn = false;
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        if([value isEqualToString:@"1"]){
            rtn = true;
        } else {
            rtn = false;
        }
    }
    [rs close];
    return rtn;
}
-(int)getDataHandleType
{
    NSString* strSql = [NSString stringWithFormat:@"select type, field1 from syssetting where id = 18"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    int rtn = 2;//默认 向上取整
    while ([rs next]) {
        NSString* value = [rs stringForColumn:@"field1"];
        rtn = [value intValue];
    }
    [rs close];
    return rtn;
}
-(BOOL)updateCurrentIdenifierForVendor:(NSString*)vendorId
{
    //key SUPPORT_COLORSIZE, SUPPORT_DISCOUNT
    NSString* strSql = [NSString stringWithFormat:@"select type, field2 from syssetting where id = 16"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    NSString* field2;
    while ([rs next]) {
        field2 = [rs stringForColumn:@"field2"];
    }
    [rs close];
    strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1,field2) values ('%d','%@','%@','%@')", 16,Login_Success,vendorId, field2];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updateShopSetting : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
    
}

//-(BOOL)updatePrintTypeSetting:(int)type maxCount:(int)count type:(NSString*)type {
//    NSString* strType = [NSString stringWithFormat:@"%d", type];
//    NSString* strCount = [NSString stringWithFormat:@"%d", count];
//    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1,field2) values ('%d','%@','%@','%@')", 19, type, strType, strCount];
//    
//    [_fmdb executeUpdate:strSql];
//    
//    ZLogInfo(@"updateShopSetting : %d", [_fmdb hadError]);
//    
//    return ![_fmdb hadError];
//}

/**
 1. 热敏打印
 2.
 3. PC打印
 */
-(ZFHDPrintSwitchDTO*)getPrinterType
{
    NSString* strSql = [NSString stringWithFormat:@"select id, type, field1, field2 from syssetting where id in(19, 31, 32)"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    ZFHDPrintSwitchDTO* dto = nil;
    dto = [[ZFHDPrintSwitchDTO alloc]init];
    while ([rs next]) {
        int typeId = [rs intForColumn:@"id"];
        NSString* value = [rs stringForColumn:@"field1"];
        if(typeId == 19) {
            if([value isEqualToString:@"1"]){
                dto.netPrint = true;
                dto.maxNetCount= [[rs stringForColumn:@"field2"] intValue];
            }
        }
        if(typeId == 31) {
            if([value isEqualToString:@"1"]){
                dto.pcPrint = true;
                dto.maxPcCount= [[rs stringForColumn:@"field2"] intValue];
            }
        }
        if(typeId == 32) {
            if([value isEqualToString:@"1"]){
                dto.btPrint112 = true;
                dto.maxBtCount= [[rs stringForColumn:@"field2"] intValue];
            }
        }
    }
    [rs close];
    return dto;
}

-(BOOL)updateRegistedIdenifierForVendor:(NSString*)vendorId
{
    //确保 updateCurrentIdenifierForVendor 被执行过。
    //key SUPPORT_COLORSIZE, SUPPORT_DISCOUNT
    NSString* strSql = [NSString stringWithFormat:@"update syssetting set field2 = '%@' where id = '%d' ",vendorId, 16];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updateRegistedIdenifierForVendor : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
    
}

#pragma mark
#pragma mark create table for shopInfo
- (BOOL)updateShopInfo:(ZShopInfoDTO*)item
{
    //Key is SHOPINFO
    NSString* strSql = @"";
    if([item.fhdTitle length]==0)
    {
        strSql= [NSString stringWithFormat:@"insert into syssetting (id, type, field1, field2,field3,field4, field5,field6) values ('%d', '%@','%@','%@', '%@', '%@','%@','%@')", 11, @"SHOPINFO",@"",@"杭州", @"13934564320 15945694567", @"张涛：建行622345 6654 4556 3327", @"张涛：工行 5288 5600 2901 6541", @"钱款，数量请当面点清，出门概不负责。商品如有质量问题，凭单7天内调换。欢迎下次光临."];
    }
    else
    {
        
        strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1, field2,field3,field4, field5,field6) values ('%d','%@','%@','%@', '%@', '%@','%@','%@')", 11,@"SHOPINFO",item.fhdTitle,item.address, item.lxfs, item.receiveFeeType1, item.receiveFeeType2, item.memo];
    }
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updateShopInfo : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (NSNumber*)getShopID
{
    NSString* strSql = [NSString stringWithFormat:@"select * from syssetting where id = 12"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    NSNumber* dto = nil;
    while ([rs next]) {
        NSString* shopId = [rs stringForColumn:@"field1"];
        dto = [NSNumber numberWithInt:[shopId intValue]];
    }
    [rs close];
    return dto;
}
- (BOOL)updateShopId:(NSNumber*)shopId
{
    //Key is PRINTINFO
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1) values ('%d','%@','%@')", 12,@"SHOPID",shopId];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updateShopId : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}


- (ZShopInfoDTO*)getShopInfo
{
    NSString* strSql = [NSString stringWithFormat:@"select * from syssetting where id = 11"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    ZShopInfoDTO  *dto;
    while ([rs next]) {
        dto = [[ZShopInfoDTO alloc]init];
        dto.fhdTitle = [rs stringForColumn:@"field1"];
        dto.address = [rs stringForColumn:@"field2"];
        dto.lxfs = [rs stringForColumn:@"field3"];
        dto.receiveFeeType1 = [rs stringForColumn:@"field4"];
        dto.receiveFeeType2 = [rs stringForColumn:@"field5"];
        dto.memo = [rs stringForColumn:@"field6"];
    }
    [rs close];
//    if(dto.fhdTitle == nil) {
//        return nil;
//    }
    return dto;
}
#pragma mark
#pragma mark create table for ZPrintInfoDTO
- (BOOL)updatePrintInfo:(ZPrintInfoDTO*)item
{
    //Key is PRINTINFO
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1, field2,field3, field4,field5) values ('%d','%@','%@','%@', '%@', '%@', '%@')", 10,@"PRINTINFO",item.ipaddr,item.port, [item.number stringValue],item.wifiName,item.wifiPwd];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updatePrintInfo : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}
- (BOOL)updatePrintInfoInner:(ZPrintInfoDTO*)item
{
    //Key is PRINTINFO
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1, field2,field3) values ('%d','%@','%@','%@','%@')", 10, @"PRINTINFO",item.ipaddr, item.port, [item.number stringValue]];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updatePrintInfo : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (ZPrintInfoDTO*)getPrintInfo
{
    NSString* strSql = [NSString stringWithFormat:@"select * from syssetting where id =10"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    ZPrintInfoDTO  *dto = [[ZPrintInfoDTO alloc]init];
    while ([rs next]) {
        dto.ipaddr = [rs stringForColumn:@"field1"];
        dto.port = [rs stringForColumn:@"field2"];
        dto.number =[NSNumber numberWithInt:[[rs stringForColumn:@"field3"] intValue]];
    }
    [rs close];
    if(dto.ipaddr == nil) {
        return nil;
    }
    return dto;
}
#pragma mark
#pragma mark 快递相关设置
- (ZKuaiDiSender*)getKuaiDiSenderInfo
{
    NSString* strSql = [NSString stringWithFormat:@"select * from syssetting where id =23"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    ZKuaiDiSender  *dto = [[ZKuaiDiSender alloc]init];
    while ([rs next]) {
        dto.senderName = [rs stringForColumn:@"field1"];
        dto.telephone = [rs stringForColumn:@"field2"];
        dto.address =[rs stringForColumn:@"field3"];
        dto.companyInfo = [rs stringForColumn:@"field4"];
    }
    [rs close];
    return dto;
}

- (BOOL)updateKuaidiSenderInfo:(ZKuaiDiSender*)item
{
    //Key is PRINTINFO
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1, field2, field3, field4) values ('%d','%@','%@','%@','%@','%@')", 23, @"KD_SENDERPRINTINFO",item.senderName, item.telephone, item.address,item.companyInfo];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updatePrintInfo : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (BOOL)updateKuaidiPCPrintInfoInner:(ZPrintInfoDTO*)item
{
    //Key is PRINTINFO
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1, field2) values ('%d','%@','%@','%@')", 22, @"KD_PRINTINFO",item.ipaddr, item.port];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updatePrintInfo : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (ZPrintInfoDTO*)getKuaiDiPCPrintInfo
{
    NSString* strSql = [NSString stringWithFormat:@"select * from syssetting where id =22"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    ZPrintInfoDTO  *dto = [[ZPrintInfoDTO alloc]init];
    while ([rs next]) {
        dto.ipaddr = [rs stringForColumn:@"field1"];
        dto.port = [rs stringForColumn:@"field2"];
    }
    [rs close];
    if(dto.ipaddr == nil) {
        return nil;
    }
    return dto;
}
#pragma mark
#pragma mark 发货单设置
- (BOOL)updateFHDPCPrintInfoInner:(ZPrintInfoDTO*)item
{
    //Key is PRINTINFO
    NSString* strSql = [NSString stringWithFormat:@"replace into syssetting (id, type, field1, field2, field3) values ('%d','%@','%@','%@', '%@')", 25, @"FHD_PRINTINFO",item.ipaddr, item.port, item.number];
    
    [_fmdb executeUpdate:strSql];
    
    ZLogInfo(@"updatePrintInfo : %d", [_fmdb hadError]);
    
    return ![_fmdb hadError];
}

- (ZPrintInfoDTO*)getFHDPCPrintInfo
{
    NSString* strSql = [NSString stringWithFormat:@"select * from syssetting where id =25"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    
    ZPrintInfoDTO  *dto = [[ZPrintInfoDTO alloc]init];
    while ([rs next]) {
        dto.ipaddr = [rs stringForColumn:@"field1"];
        dto.port = [rs stringForColumn:@"field2"];
        dto.number = [NSNumber numberWithInt:[[rs stringForColumn:@"field3"] intValue]];
    }
    [rs close];
    if(dto.ipaddr == nil) {
        return nil;
    }
    return dto;
}

#pragma mark
#pragma mark 挂单
-(BOOL)saveSuppendTrade:(NSString*)trade localId:(NSNumber*)locaTradeId
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"insert into uncommitTrade (id, tradestr, creaettime) values ((select max(id) from uncommitTrade) + 1, '%@','%@')",trade, @""];
        if(locaTradeId&& [locaTradeId intValue]!=1) {
            strSql = [NSString stringWithFormat:@"replace into uncommitTrade (id, tradestr, creaettime) values ('%d','%@','%@')", [locaTradeId intValue],trade, @""];
        }
        
        [_fmdb executeUpdate:strSql];
        
        ZLogInfo(@"saveSuppendTrade : %d", [_fmdb hadError]);
        trade = nil;
        return ![_fmdb hadError];
    }
    
}
-(BOOL)saveUnCommitTrade:(NSString*)trade
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"replace into uncommitTrade (id, tradestr, creaettime) values ('%d','%@','%@')", 1,trade, @""];
        
        [_fmdb executeUpdate:strSql];
        
        ZLogInfo(@"saveUnCommitTrade : %d", [_fmdb hadError]);
        trade = nil;
        return ![_fmdb hadError];
    }
}

- (NSArray*)getUnCommitTrade
{
    @autoreleasepool {
    NSString* strSql = [NSString stringWithFormat:@"select id, tradestr from uncommitTrade order by id"];
    
    FMResultSet *rs = [_fmdb executeQuery:strSql];
    NSMutableArray* trades = [[NSMutableArray alloc]init];
    while ([rs next]) {
        ZPopupUIItemDTO* uiDto = [[ZPopupUIItemDTO alloc]init];
        uiDto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
        NSString* tradeStr = [rs stringForColumn:@"tradestr"];
        uiDto.displayString = tradeStr;
        [trades addObject:uiDto];
    }
    [rs close];
    return trades;
    }
}

-(BOOL)deleteUnCommitTrade:(NSNumber*)itemId
{
    NSString* strFmt = @"delete from uncommitTrade where id = %@";
    
    NSString* strSql = [NSString stringWithFormat:strFmt, itemId];
    
    [_fmdb executeUpdate:strSql];

    return ![_fmdb hadError];
}

////////////////////
#pragma mark
#pragma mark add operation for customers dto offline data
- (BOOL)addOthershops:(NSArray*)otherShops
{
    @autoreleasepool {
        for(ZShopDTO* shop in otherShops) {
            NSString* pinyin = [self pinyin:shop.shopName];
            NSNumber * flag = [NSNumber numberWithBool:shop.used];
            
            NSString* strSql = [NSString stringWithFormat:@"replace into othershops (id, name, namepinyin, used) values ('%d', '%@', '%@', '%@')", [shop.shopId intValue], shop.shopName, pinyin, flag];
            
            [_fmdb executeUpdate:strSql];
            
        }
        return ![_fmdb hadError];
    }
}

- (NSArray*)getOthershops
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select id, name from othershops where used = 1 order by name"];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* shops = [[NSMutableArray alloc]init];
        while ([rs next]) {
            ZPopupUIItemDTO* uiDto = [[ZPopupUIItemDTO alloc]init];
            uiDto.itemId = [NSNumber numberWithInt:[rs intForColumn:@"id"]];
            NSString* tradeStr = [rs stringForColumn:@"name"];
            uiDto.displayString = tradeStr;
            [shops addObject:uiDto];
        }
        [rs close];
        return shops;
    }
}
#pragma mark
#pragma mark barcode
- (BOOL)saveBarcodeRuls:(NSArray*)barcodeRule
{
    @autoreleasepool {
        for(ZBarcodeRuleDTO* rule in barcodeRule) {
            
            NSString* strSql = [NSString stringWithFormat:@"replace into barcoderule (type, name, frompos, endpos) values ('%d', '%@', '%@', '%@')", [rule.typeValue intValue], rule.name, rule.fromPos, rule.endPos];
            
            [_fmdb executeUpdate:strSql];
            
        }
        return ![_fmdb hadError];
    }
}

- (NSMutableArray*)getBarcodeRules
{
    @autoreleasepool {
        NSString* strSql = [NSString stringWithFormat:@"select type, name, frompos, endpos from barcoderule order by type"];
        
        FMResultSet *rs = [_fmdb executeQuery:strSql];
        NSMutableArray* rules = [[NSMutableArray alloc]init];
        while ([rs next]) {
            ZBarcodeRuleDTO* ruleDto = [[ZBarcodeRuleDTO alloc]init];
            ruleDto.typeValue = [NSNumber numberWithInt:[rs intForColumn:@"type"]];
            ruleDto.name =[rs stringForColumn:@"name"];
            ruleDto.fromPos = [NSNumber numberWithInt:[[rs stringForColumn:@"frompos"] intValue]];
            ruleDto.endPos = [NSNumber numberWithInt:[[rs stringForColumn:@"endpos"] intValue]];
            [rules addObject:ruleDto];
        }
        [rs close];
        return rules;
    }
}
#pragma mark
#pragma mark create table for offline data
- (void)createTables
{
    //goods
    @autoreleasepool {
        
        [_fmdb executeUpdate:@"create table if not exists goods (id int primary key, used int, discount int, name_number text, \
         kuanHao text unique, itemName text, itemCompany text, itemCategory text,itemBrand text, buyprice text, saleprice text, pointvalue text, synctime text, picurl text, count int, namepinyin text, numberpinyin text, updateon timestamp)"];

        [_fmdb executeUpdate:@"create table if not exists goodsColorSize (itemId int,colorId int, color text, sizeId int, size text, count int, updateon timestamp, constraint pk_goodsColor primary key (itemId, colorId,sizeId) ) "];
        //customer
        [_fmdb executeUpdate:@"create table if not exists customer (id int primary key, used int,name text, phone text, synctime text, namepinyin text, kuaiDiName text, address text, memo text, updateon timestamp)"];
        
        //user
        [_fmdb executeUpdate:@"create table if not exists user (id int primary key, used int,name text, nickname text,roles text,synctime text, namepinyin text, updateon timestamp)"];
        //ShopSaler
         [_fmdb executeUpdate:@"create table if not exists shopsaler (id int primary key, used int,name text,synctime text, namepinyin text, updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create table if not exists supplier (id int primary key, used int, name text, address text,telephone text,created text,pictureUrl text,synctime text, namepinyin text, updateon timestamp)"];
        
        //helper goods
        [_fmdb executeUpdate:@"create table if not exists fzgoods (id int primary key, kuanhao text, name text,name_number text, saleprice text, synctime text,created text,kuanhaopinyin text,  namepinyin text,used int, updateon timestamp)"];
        //
        [_fmdb executeUpdate:@"create table if not exists itemdiscount (id int primary key, name text, used int,  namepinyin text, updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create table if not exists itemcolor (id int primary key, name text, code text, used int,  namepinyin text, updateon timestamp)"];
        [_fmdb executeUpdate:@"create table if not exists itemordermemo (id int primary key, name text, used int,  namepinyin text, updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create table if not exists itemsize (id int primary key, name text, sequency int, sizeCount int, used int, code text,   namepinyin text, updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create table if not exists itembrand (id int primary key, name text, code text, used int,  namepinyin text, updateon timestamp)"];
        [_fmdb executeUpdate:@"create table if not exists itemseason (id int primary key, name text, code text, used int,  namepinyin text, updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create table if not exists itemcat (id int primary key, name text,code text,  used int,  namepinyin text, updateon timestamp)"];
        [_fmdb executeUpdate:@"create table if not exists itemexpense (id int primary key, name text, price text, used int, namepinyin text, updateon timestamp)"];
        [_fmdb executeUpdate:@"create table if not exists othershops (id int primary key, name text, used int, namepinyin text, updateon timestamp)"];
        [_fmdb executeUpdate:@"create table if not exists uncommitTrade (id int primary key, tradestr text, creaettime text, updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create table if not exists mykuaidi (id int primary key, name text, namepinyin text, updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create table if not exists barcoderule (type int primary key, name text, frompos text, endpos text, updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create table if not exists customeritemorders (id int primary key, itemId text, customerId text,lastPrice text,lastDiscount text, used int, field1 text, field2 text, field3 text,updateon timestamp)"];
        
        [_fmdb executeUpdate:@"create index index_name on customeritemorders(customerId,itemId )"];
        
        //1,2,3,4 表的synctime， 10，打印机信息 12, 店铺信息， 13， 是否显示颜色，尺寸。 14，开单时，是否显示折扣 15  16 是否已经登录成功
        // 17 是否拼音 显示款号。19 热敏打印还是电脑打印 21 不显示item的名称 22 快递打印机设置 23 快递发送者 信息 24 款号列表中显示品牌 25 电脑发货单打印 26 减少打印边距 27 模板类型有折扣，无折扣 28 baocode的设置 29, 打印颜色尺码
        //31 是否打开了电脑打印 32 是否打开蓝牙打印
        //40 token保存，fild1,token,fild2，expireTime
        [_fmdb executeUpdate:@"create table if not exists syssetting (id int primary key, type text, field1 text, field2 text,field3 text,field4 text,field5 text,field6 text,field7 text,field8 text,field9 text, updateon timestamp)"];
        
        if ([_fmdb hadError])
        {
            ZLogInfo(@"create table failed.");
        }
    }

    //[_fmdb commit];
}

-(void)initTableData
{
}

- (void)createTable
{
    //check if there is the table
    
    //create
}

@end
