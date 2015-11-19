//
//  ZCode.h
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/6/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//


#ifndef __ZTYPE___H_
#define __ZTYPE___H_

#define  START   1000
#define  ZONE    1000

#define  kLOGIN_START  (START + ZONE * 1)

//#define  kLOGIN_LOGIN  (kLOGIN_START + 9)
//#define  kLOGIN_LOGOUT (kLOGIN_START + 1)


#define kRequestBase 1000

#define kLogin kRequestBase + 1
#define kLogin_Ping kRequestBase + 2
#define kLogin_MyShops kRequestBase + 3
#define kLogin_UpdateShopId kRequestBase + 4
#define kShop_Create kRequestBase + 5
#define kLogin_OpenShop kRequestBase + 6
#define kLogin_distribt kRequestBase + 7

#define kUser kRequestBase + 500
#define kUser_Query kUser + 1
#define kUser_Add kUser + 2
#define kUser_Dis kUser + 3
#define kUser_En kUser + 4
#define kUser_PwdChange kUser + 5
#define kUser_PwdReset kUser + 6
#define kUser_LogInAccount kUser + 7
#define kUser_Update kUser + 8

#define kSaler kRequestBase + 520
#define kSaler_Query kSaler + 1
#define kSaler_Add kSaler + 2
#define kSalerRecord_Query kSaler + 3
#define kSaler_Update kSaler + 4
#define kSaler_Del kSaler + 5
#define kSalerMonthlyRecord_Query kSaler + 6
#define kSaler_Dis kSaler + 7
#define kSaler_Clean kSaler + 8

#define kItem 2000
#define kItem_Query kItem + 1
#define kItem_Add kItem + 2
#define kItem_List kItem + 3
#define kItem_Delist kItem + 4
#define kItem_BatList kItem + 5
#define kItem_BatDelist kItem + 6
#define kItem_UpdatPrice kItem + 7
#define kItem_QueryDetail kItem + 8
#define kItem_Update kItem + 9
#define kItem_Delist_Batch kItem + 10

#define kSyncUp 3000
#define kItem_Sync kSyncUp + 1
#define kCustomer_Sync kSyncUp + 2
#define kUser_Sync kSyncUp + 3
#define kItemFZ_Sync kSyncUp + 4
#define kSupplier_Sync kSyncUp + 5
#define kSaler_Sync kSyncUp + 6
#define kAllShops_Sync kSyncUp + 7
#define kCustomerItems_Sync kSyncUp + 9

#define kItemCategory kItem + 100
#define kItemCategory_Qry kItemCategory + 1
#define kItemCategory_Add kItemCategory +2
#define kItemCategory_En kItemCategory +3
#define kItemCategory_Dis kItemCategory +4
#define kItemCategory_Update kItemCategory +5

#define kItemExpense kItem + 120
#define kItemExpense_Qry kItemExpense + 1
#define kItemExpense_Add kItemExpense +2
#define kItemExpense_En kItemExpense +3
#define kItemExpense_Dis kItemExpense +4
#define kItemExpense_Update kItemExpense +5

#define kKuaiDiInfo kItem + 150
#define kKuaiDiInfo_QryAll kKuaiDiInfo + 1
#define kKuaiDiInfo_Set kKuaiDiInfo + 2
#define kKuaiDiInfo_GetMy kKuaiDiInfo + 3
#define kKuaiDiInfo_En kKuaiDiInfo + 4
#define kKuaiDiInfo_Dis kKuaiDiInfo + 5
#define kKuaiDiInfo_Print kKuaiDiInfo + 6

#define kItemSyncBaseData 199

#define kItemColor kItem +200
#define kItemColor_Qry kItemColor +1
#define kItemColor_Add kItemColor +2
#define kItemColor_En kItemColor +3
#define kItemColor_Dis kItemColor +4
#define kItemColor_Update kItemColor +5

#define kItemDiscount kItem +220
#define kItemDiscount_Qry kItemDiscount +1
#define kItemDiscount_Add kItemDiscount +2
#define kItemDiscount_En kItemDiscount +3
#define kItemDiscount_Dis kItemDiscount +4
#define kItemDiscount_Update kItemDiscount +5

#define kItemOrderMemo kItem +230
#define kItemOrderMemo_Qry kItemOrderMemo +1
#define kItemOrderMemo_Add kItemOrderMemo +2
#define kItemOrderMemo_En kItemOrderMemo +3
#define kItemOrderMemo_Dis kItemOrderMemo +4
#define kItemOrderMemo_Update kItemOrderMemo +5

#define kCoAccount kItem +250
#define kCoAccount_Cust_Qry kCoAccount +1
#define kCoAccount_Com_Qry kCoAccount +2
#define kCoAccount_Cust_Add kCoAccount +3
#define kCoAccount_Com_Add kCoAccount +4
#define kCoAccount_Cust_Del kCoAccount +5
#define kCoAccount_Com_Del kCoAccount +6

#define kItemCompany kItem + 300
#define kItemCompany_Qry kItemCompany + 1
#define kItemCompany_Add kItemCompany +2
#define kItemCompany_En kItemCompany +3
#define kItemCompany_Dis kItemCompany +4
#define kItemCompany_QryFee kItemCompany + 5
#define kItemCompany_Update kItemCompany + 6

#define kItemSize kItem+400
#define kItemSize_Qry kItemSize+1
#define kItemSize_Add kItemSize+2
#define kItemSize_En kItemSize+3
#define kItemSize_Dis kItemSize+4
#define kItemSize_Update kItemSize+5

#define kItemBrand kItem+450
#define kItemBrand_Qry kItemBrand+1
#define kItemBrand_Add kItemBrand+2
#define kItemBrand_En kItemBrand+3
#define kItemBrand_Dis kItemBrand+4
#define kItemBrand_Update kItemBrand+5

#define kItemPurchase_Qry kItem +500
#define kItemPurchase_Add kItemPurchase_Qry +1
#define kItemPurchase_AddBatch kItemPurchase_Qry +2
#define kItemPurchase_Inventory kItemPurchase_Qry +3
#define kItemPurchase_Detail kItemPurchase_Qry +4
#define kItemPurchase_Update kItemPurchase_Qry +5
#define kItemPurchaseTrade_Qry kItemPurchase_Qry +6
#define kItemPurchaseTrade_Detail kItemPurchase_Qry +7
#define kItemPurchase_Account kItemPurchase_Qry +8
#define kItemPurchase_Delete kItemPurchase_Qry +9
#define kItemPurchase_ItemIO kItemPurchase_Qry +10
#define kItemPurchase_Print kItemPurchase_Qry +11
#define kItemIO_ItemConfirm kItemPurchase_Qry +12
#define kItemIO_ItemConfirmSelf kItemPurchase_Qry +13

#define kItem_Inventory kItem +520
#define kItem_Inventory_Add kItem_Inventory+1
#define kItem_Inventory_Qry kItem_Inventory+2
#define kItem_Inventory_Start kItem_Inventory+3
#define kItem_Inventory_Handle kItem_Inventory+4
#define kItem_Inventory_Record_Qry kItem_Inventory+5
#define kItem_UnInventory_Qry kItem_Inventory+6

#define kReport_Daily kItem +550
#define kReport_Daily_checked kReport_Daily +1
#define kReport_Daily_sumQuery kItem +2

#define kItemFZ kItem + 600
#define kItemFZ_Add kItemFZ +1
#define kItemFZ_Qry kItemFZ +2
#define kItemFZ_Del kItemFZ +3
#define kItemFZ_Update kItemFZ +4
#define kItemFZ_Enable kItemFZ +5

#define kTrade kItem + 700
#define kTrade_Add kTrade +1
#define kTrade_Qry kTrade +2
#define kTrade_Del kTrade +3
#define kTrade_Detail kTrade +4
#define kTradeOrders kTrade +5
#define kTradeOrders_Detail kTrade +6
#define kTrade_Printed kTrade +7
#define kTrade_Delete kTrade +8
#define kTrade_Qry4Customer kTrade +9
#define kTrade_Confirm4Customer kTrade +10
#define kTrade_QryOrderTemp kTrade +11
#define kTrade_OrderTemp_Delete kTrade +12
#define kTrade_OrderTemp_Qry kTrade +13
#define kTrade_OrderTemp_Add kTrade +14
#define kTrade_OrderTemp_Detail kTrade +15
#define kTrade_QrySumItems kTrade +16

#define kStatistics kItem +720
#define kStatistics_Saled kStatistics +1

#define kExpense kItem + 740
#define kExpense_Add kExpense +1
#define kExpense_Qry kExpense +2
#define kExpense_Del kExpense +3
#define kExpense_Detail kExpense +4
#define kExpenseSubs kExpense +5
#define kExpenseSubs_Qry kExpense +6
#define kExpense_Printed kExpense +7
#define kExpense_Delete kExpense +8
#define kExpenseSubs_Delete kExpense +9
#define kExpenseSubExp_Delete kExpense +10

#define kCustReturned kItem + 760
#define kCustReturned_Add kCustReturned +1
#define kCustReturned_Qry kCustReturned +2
#define kCustReturned_Del kCustReturned +3
#define kCustReturned_Detail kCustReturned +4
#define kCustReturnedSubs kCustReturned +5
#define kCustReturnedSubs_Qry kCustReturned +6
#define kCustReturned_Printed kCustReturned +7
#define kCustReturned_Delete kCustReturned +8
#define kCustReturnedSubs_Delete kCustReturned +9

#define kCustomer kItem + 800
#define kCustomer_Create kCustomer + 1
#define kCustomer_Qry kCustomer + 2
#define kCustomer_QryById kCustomer + 3
#define kCustomer_Modify kCustomer + 4
#define kCustomer_En kCustomer + 5
#define kCustomer_Dis kCustomer + 6
#define kCustomer_Statistic_Qry kCustomer + 7
#define kCustomer_AddressDetail kCustomer + 8

#define kShopInfo kItem + 900
#define kShopInfo_Save kShopInfo + 1
#define kShopInfo_Qry kShopInfo + 2

#define kRegisterDevice kItem + 920
#define kFile_Upload 4000
#define kItemFile_Upload 4001
#define kItemFile_Remove 4002

//#define kRequestGoods kRequestBase + 2000



#define  kGOODS_START  (START + ZONE * 2)


#define  kUSER_START   （START + ZONE * 3）


////////////////////////////////////

//string

#define kUserName  @"UserName"
#define kPassword  @"Password"


#define kHttpPrefix	[NSString stringWithFormat:@"http://%@:%@/sjqprint2/rs/", kSeverIpAdrress, kServerPort]

#ifdef TESTLOCAL
#define kSeverIpAdrress  @"192.168.3.109"
#define kServerPort @"8080"
#else
#define kSeverIpAdrress  @"42.121.126.152"
#define kServerPort @"9080"
#endif

#define urlItem [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item"]
#define urlItemDetail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/%@/detail"]
#define urlItemQuery [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/query"]
#define urlItemUpdatePrice [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/salePrice"]
#define urlItemUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/update/%@"]
#define urlItemEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/enable/%@"]
#define urlItemDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/disable/%@"]
#define urlItemBatchEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/batch_enable"]
#define urlItemBatchDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/batch_disable"]
#define urlItemDelistBatch [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/delist/batch"]

#define urlItemInventoryAdd [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"inventory/create"]
#define urlItemInventoryQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"inventory/query"]
#define urlItemInventoryStart [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"inventory/start"]
#define urlItemInventoryHandle [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"inventory/%@/handle"]
#define urlItemInventoryRecordQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"inventory/query/handlerecord"]
#define urlItemUnInventoryQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"inventory/query/uninventoryitems"]

#define urlItemSyncUp [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/last_updated?last_updated=%@"]
#define urlItemFZSyncUp [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_fz/last_updated?last_updated=%@"]
#define urlCustomerSyncUp [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer/last_updated?last_updated=%@"]
#define urlUserSyncUp [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user/last_updated?last_updated=%@"]
#define urlSalerSyncUp [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"saler/last_updated?last_updated=%@"]
#define urlSupplierSyncUp [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"company/last_updated?last_updated=%@"]
#define urlCustomerItmsSyncUp [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/orders/last_updated?last_updated=%@"]

#define urlCategory [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"category"]
#define urlCategoryUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"category/update"]
#define urlCategoryEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"category/enable"]
#define urlCategoryDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"category/disable"]

#define urlExpense [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"expense"]
#define urlExpenseUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"expense/update"]
#define urlExpenseEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"expense/enable"]
#define urlExpenseDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"expense/disable"]

#define urlColor [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"color"]
#define urlColorUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"color/update"]
#define urlColorEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"color/enable"]
#define urlColorDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"color/disable"]
#define urlOrderMemo [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"ordermemo"]
#define urlOrderMemoUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"ordermemo/update"]
#define urlOrderMemoEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"ordermemo/enable"]
#define urlOrderMemoDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"ordermemo/disable"]

#define urlDiscount [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"discount"]
#define urlDiscountUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"discount/update"]
#define urlDiscountEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"discount/enable"]
#define urlDiscountDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"discount/disable"]
#define urlSize [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"size"]
#define urlSizeUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"size/update"]
#define urlSizeEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"size/enable"]
#define urlSizeDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"size/disable"]
#define urlBrand [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"brand"]
#define urlBrandUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"brand/update"]
#define urlBrandEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"brand/enable"]
#define urlBrandDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"brand/disable"]
#define urlCompany [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"company"]
#define urlCompanyUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"company/update"]
#define urlCompanyEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"company/enable"]
#define urlCompanyDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"company/disable"]
#define urlCompanyQryFee [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"company/queryFee/%@"]
#define urlShops [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"shop"]
#define urlAllShops [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"shop/allShops"]

#define urlShopBaseData [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/syncbasedata"]

#define urlItemFZ [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_fz"]
#define urlItemFZDel [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_fz/%@"]
#define urlItemFZEnable [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_fz/enable/%@"]
#define urlItemFZUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_fz/%@"]


#define urlTradeCreate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade"]
#define urlTradeCreateNew [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/new/add"]
#define urlTradeQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/query"]
#define urlTradeQry4Customer [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/query/forcustomer"]
#define urlTradeDetail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/%@/detail"]
#define urlTradeOrderDetail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/%@/order/detail"]
#define urlOrdersQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/orders/query"]
#define urlOrdersSumQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/orders/query/sumitems"]
//#define urlOrdersSumQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/orders/query/sumbycustomer"]
#define urlTradePrinted [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/%@/set_printed"]
#define urlTradeDelete [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/%@/delete"]
#define urlTradeConfirmByCustomer [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/confirm/forcustomer/%@"]

#define urlTrade_OrderTemp_Create [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"ordertemp"]
#define urlTrade_OrderTemp_Delete [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"ordertemp/%@/delete"]
#define urlTrade_OrderTemp_Qry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"ordertemp/query"]
#define urlTrade_OrderTemp_Detail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"ordertemp/%@/detail"]

#define urlExpenseCreate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"exrecord"]
#define urlExpenseQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"exrecord/query"]
#define urlExpenseDetail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"exrecord/%@/detail"]
#define urlExpenseOrderDetail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"exrecord/%@/order/detail"]
#define urlExpenseSubExpQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"exrecord/subexp/query"]
#define urlExpensePrinted [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"exrecord/%@/set_printed"]
#define urlExpenseDelete [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"exrecord/%@/delete"]
#define urlExpenseSubExpDelete [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"exrecord/%@/delete/subexp"]

#define urlCustReturnedCreate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customerrtn"]
#define urlCustReturnedQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customerrtn/query"]
#define urlCustReturnedDetail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customerrtn/%@/detail"]
#define urlCustReturnedOrderDetail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customerrtn/%@/order/detail"]
#define urlCustReturnedSubExpQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customerrtn/subexp/query"]
#define urlCustReturnedPrinted [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customerrtn/%@/set_printed"]
#define urlCustReturnedDelete [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customerrtn/%@/delete"]

#define urlStatistics_Trade [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"trade/statistics?staticType=%@"]
#define urlStatistics_Item [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item/statistics?staticType=%@"]
#define urlStatistics_ItemCG [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"item_cg/statistics?staticType=%@"]

#define urlKuaiDiQryAll [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"kuaidi"]
#define urlKuaiDiSet [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"kuaidi/visible/setting"]
#define urlKuaiDiGet [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"kuaidi/visible"]
#define urlKuaiDiEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"kuaidi/visible/enable"]
#define urlKuaiDiDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"kuaidi/visible/disable"]
#define urlKuaiDiPrint [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"print/records"]

#define urlReportDaily [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"report/daily/%@"]
#define urlReportDailySum [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"report/querydailysum"]
#define urlReportDaily_checked [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"report/%@/set_checked"]

#define urlCustCreate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer"]
#define urlCustQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer?%@"]
#define urlCustQryDetail [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer/detail/%@"]
#define urlCustQryById [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer/%@"]
#define urlCustUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer/update"]
#define urlCustEnable [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer/enable"]
#define urlCustDisable [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer/disable"]

#define urlCustStatisticQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"customer/saler/statistic"]

#define urlAccountCustomerQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"co_account/query/customer"]
#define urlAccountCompanyQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"co_account/query/item_company"]
#define urlAccountCustomerCreate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"co_account/customer"]
#define urlAccountCompanyCreate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"co_account/item_company"]
#define urlAccountCustomerRemove [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"co_account/customer/%@/%@/del"]
#define urlAccountCompanyRemove [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"co_account/item_company/%@/%@/del"]

#define urlShopInfo [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"shopinfo_setting"]

#define urlRegisterDevice [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"weixin/openShop"]

#define urlMyShops [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"boss/AllShops"]
#define urlOpenMyShop [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"weixin/ipad/open"]
#define urlUpdateCurrentShop [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"boss/shopIdUpdate/%@"]
#define urlShopCreate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"shop"]

#endif


