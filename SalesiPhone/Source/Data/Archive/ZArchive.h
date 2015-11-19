//
//  ZArchive.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/21/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZItemDTO;
@class ZUserDTO;
@class ZItemCompanyDTO;
@class ZShopInfoDTO;
@class ZPrintInfoDTO;
@class ZItemCategoryDTO;
@class ZItemSizeDTO;
@class ZItemColorDTO;
@class ZItemCGOrderDTO;
@class ZCustomerDTO;
@class ZKuaiDiInfoDTO;
@class ZItemBrandDTO;
@class ZItemDiscountDTO;
@class ZItemExpenseDTO;
@class ZSyncBaseData;
@class ZPopupUIItemDTO;
@class ZShopSalerDTO;
@class ZItemOrderMemo;
@class ZKuaiDiSender;
@class ZFHDPrintSwitchDTO;
@class ZCustomerItemPriceDTO;
@class ZConditionDTO;

@interface ZArchive : NSObject

@property (nonatomic ) int syncTime;

+ (ZArchive*)instance;
- (void)initDataBase;
-(void)logoutDB;

-(void)invalidateTimer;
- (void)syncupItem;
- (void)loginSuccess:(NSNotification*)noti;

-(void)pingServer;
-(void)clearAllTables;
-(void)reCreateTables;
//goods
//- (NSArray*)getGoodsIdArray:(NSString*)text;
- (NSArray*)getGoodsDTO:(NSString*)text;
- (NSArray*)getGoodsDTOWithItemFZ:(NSString*)text;

- (NSArray*)getGoodsLocalDTOByPage:(ZConditionDTO*) dto;
-(NSArray*)getGoodsLocalSKUDTOByPage:(ZConditionDTO*) condDto;

- (NSArray*)getGoodsNameNumberUsed:(NSString*)text;
- (NSArray*)getGoodsColorArray:(NSNumber*)itemId;
- (ZItemDTO*)getGoodsDTOById:(NSNumber*)itemId;
- (ZItemDTO*)getGoodsDTOWithSkuById:(NSNumber*)itemId;
- (NSMutableArray*)getGoodsSkuByItemId:(NSNumber*)itemId colorId:(NSNumber*)colorId;


- (NSArray*)getGoodsNameDTOArray:(NSString*)text;
- (NSArray*)getGoodsKuanHaoDTOArray:(NSString*)text;

- (NSArray*)getPointGoodsNameNumberUsed:(NSString*)text;

//- (NSArray*)getGoodsColorArray:(NSString*)text;
//- (NSArray*)getGoodsSizeArray:(NSString*)text;
- (BOOL)addItemCGOrderDto:(ZItemCGOrderDTO*)item;
- (BOOL)addItemDto:(ZItemDTO*)item;
- (BOOL)addSupplierDto:(ZItemCompanyDTO*)item;
- (NSArray*)getSupplierNameArray:(NSString*)text;
-(void)addSupplierWithLocalSyncTime:(ZItemCompanyDTO*)item;

//client
- (BOOL)addCustomerItem:(ZCustomerDTO*)item;
//- (NSArray*)getCustomerIdArray:(NSString*)text;
- (NSArray*)getCustomerPhoneNameArray:(NSString*)text;
- (NSArray*)getCustomerNameArray:(NSString*)text;
- (NSArray*)getCustomerPhoneArray:(NSString*)text;
-(ZCustomerDTO*)getCustomerById:(NSNumber*)customerId;
-(void)updateCustomerAsTrade:(NSNumber*)customerId;

-(NSNumber*)getAvargeColorID;
-(NSNumber*)getAvargeSizeID;

-(void)handleShopBaseData:(ZSyncBaseData*)dto;
//user
- (NSArray*)getUserNameArray:(NSString*)text;
//- (NSArray*)getUserIdArray:(NSString*)text;
- (BOOL)addUserItem:(ZUserDTO*)item;
- (NSString*)getLastSyncTime:(NSString*)table;
-(ZPopupUIItemDTO*)getShopSaler:(int)salerId;
- (BOOL)addSalerItem:(ZShopSalerDTO*)item;
- (NSArray*)getSalerNameArray:(NSString*)text;
//category
- (BOOL)addItemCatDto:(ZItemCategoryDTO*)item;
- (NSArray*)getItemCatEnabled:(NSString*)text;
//
- (BOOL)addItemExpenseDto:(ZItemExpenseDTO*)item;
- (NSArray*)getItemExpenseEnabled:(NSString*)text;
- (ZItemExpenseDTO*)getItemExpense:(NSNumber*)itemId;

- (BOOL)addItemSizeDto:(ZItemSizeDTO*)item;
- (NSMutableArray*)getItemSizeEnabled;
-(ZItemSizeDTO*)getItemSizeCount:(NSNumber*)sizeid;

- (BOOL)addItemBrandDto:(ZItemBrandDTO*)item;
- (NSArray*)getItemBrandEnabled;
- (NSArray*)getItemSeason;
- (NSMutableArray*)getItemColorEnabled;
- (BOOL)addItemColorDto:(ZItemColorDTO*)item;
- (NSArray*)getOthershops;

- (NSArray*)getItemDiscountEnabled;
- (BOOL)addItemDiscountDto:(ZItemDiscountDTO*)item;

- (BOOL)addItemFZDto:(ZItemDTO*)item;
-(ZItemDTO*)getItemFZDTO:(NSNumber*)itemId;
- (BOOL)removeItemFZDto:(ZItemDTO*)item;

- (BOOL)updateShopInfo:(ZShopInfoDTO*)item;
- (ZShopInfoDTO*)getShopInfo;

- (BOOL)updatePrintInfo:(ZPrintInfoDTO*)item;
-(BOOL)updatePrintInfoInner:(ZPrintInfoDTO*)item;
-(BOOL)updateKuaidiPCPrintInfoInner:(ZPrintInfoDTO*)item;
- (ZPrintInfoDTO*)getPrintInfo;
- (ZPrintInfoDTO*)getKuaiDiPCPrintInfo;
- (ZKuaiDiSender*)getKuaiDiSenderInfo;
- (BOOL)updateKuaidiSenderInfo:(ZKuaiDiSender*)item;
- (ZPrintInfoDTO*)getFHDPCPrintInfo;
- (BOOL)updateFHDPCPrintInfoInner:(ZPrintInfoDTO*)item;
//KuaiDi
- (BOOL)removeMyKuaiDiDto:(ZKuaiDiInfoDTO*)item;
- (BOOL)addMyKuaiDiDto:(ZKuaiDiInfoDTO*)item;
- (BOOL)addMyKuaiDiDtos:(NSArray*)myKuaiDis;
- (NSArray*)getMyKuaiDi;
-(ZCustomerItemPriceDTO*)queryByCustomerAndItem:(NSNumber*)customerId itemId:(NSNumber*)itemId;

-(void)saveShopID:(NSNumber*)shopId;

-(NSMutableDictionary*)getShopSetting;
-(BOOL)updateShopSetting:(int)property key:(NSString*)key value:(BOOL)value;
-(BOOL)updateShopSettingString:(int)property key:(NSString*)key value:(NSString*)value;
-(BOOL)updateShopSettingInt:(int)property key:(NSString*)key value:(int)type;
-(BOOL)updateCurrentIdenifierForVendor:(NSString*)vendorId;
-(BOOL)updateRegistedIdenifierForVendor:(NSString*)vendorId;
-(NSString*)getHTTPToken;
-(int)getTempleteType;
-(BOOL)getPrintDistance;
-(BOOL)isSupportColorSize;
-(BOOL)isSupportDiscount;
-(BOOL)isSupportSingleColorSize;
-(BOOL)isAccountAfterPrint;
-(BOOL)ifHasLogined;
-(BOOL)isUsePinYinInputKuanHao;
-(BOOL)isNotDisplayItemName;
-(BOOL)ifDisplayItemBrandCat;
-(BOOL)ifPrintColorSize;
-(int)getDataHandleType;
-(ZFHDPrintSwitchDTO*)getPrinterType;


-(BOOL)saveUnCommitTrade:(NSString*)trade;
-(BOOL)saveSuppendTrade:(NSString*)trade localId:(NSNumber*)locaTradeId;
- (NSArray*)getUnCommitTrade;
-(BOOL)deleteUnCommitTrade:(NSNumber*)itemId;

- (BOOL)addItemOrderMemoDto:(ZItemOrderMemo*)item;
- (NSMutableArray*)getItemOrderMemoEnabled;
-(BOOL)addCustomerItemPrice:(ZCustomerItemPriceDTO*)priceDTO now:(NSDate*)now;


-(ZItemSizeDTO*)getItemSizeByCode:(NSString*)sizecode;
- (ZItemColorDTO*)getItemColorByCode:(NSString*)colorCode;
-(ZItemCategoryDTO*)getItemCatByCode:(NSString*)catCode;
- (NSNumber*)getGoodsIdByKuanHao:(NSString*)kuanhao;
- (NSMutableArray*)getBarcodeRules;

- (BOOL)saveBarcodeRuls:(NSArray*)barcodeRule;

@end
