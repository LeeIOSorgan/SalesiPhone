//
//  Header.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-6.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#ifndef eSeller4iPad_Header_h
#define eSeller4iPad_Header_h

#define SUPPORT_NAME 0
//#define SUPPORT_MULTICOLORSIZE 1

#define PRINT_TEST 0
#define PRINT_TRADE 1
#define PRINT_DAILY_REPORT 2
#define PRINT_RETURNED_FEE 3
#define PRINT_CGTRADE 4
#define PRINT_ITEM_STOCK 10

#define SUPPORT_COLORSIZE @"SUPPORT_COLORSIZE"
#define SUPPORT_DISCOUNT @"SUPPORT_DISCOUNT"
#define Account_After_Print @"AccountAfter_Print"
#define Login_Success @"Login_Success"
#define Use_PY_Input @"Use_PY_Input"
#define Use_Color_Size @"Use_Color_Size"
#define Display_ItemName @"Display_ItemName"
#define Handle_Float @"Handle_Float"
#define Printer_Distance @"PRINTER_DISTANCE"
#define Templete_Selection @"Templete_Selection"
#define Display_Brand_Cat @"Display_Brand_Cat"
#define Print_ColorSize @"Print_ColorSize"

//#define Printer_Type_Net @"PRINTER_TYPE_Net"
#define Printer_Type @"PRINTER_TYPE"
#define Printer_Type_value 19
#define Printer_Type_PC @"PRINTER_TYPE_PC"
#define Printer_Type_PC_value 31
#define Printer_Type_BT @"PRINTER_TYPE_BT"
#define Printer_Type_BT_112 @"PRINTER_TYPE_BT_112"
#define Printer_Type_BT_112_value 32
////////////////////////////////////////
#import "ZResourceMgr.h"



////////////////////////////////////////////////////////
#define kIconName0  @"purchase.png"
#define kIconName1  @"itemMgr.png"
#define kIconName2  @"kaidan.png"
#define kIconName3  @"salehistorys.png"
#define kIconName4  @""

#define kIconName5  @"customerMgr.png"
#define kIconName6  @"account.png"
#define kIconName7  @"usermgr.png"
#define kIconName8  @"expense.png"
#define kIconName9  @""

#define kIconName10  @"purchase_up.png"
#define kIconName11  @"itemMgr_up.png"
#define kIconName12  @"kaidan_up.png"
#define kIconName13  @"salehistorys_up.png"
#define kIconName14  @""

#define kIconName15  @"customerMgr_up.png"
#define kIconName16  @"account_up.png"
#define kIconName17  @"usermgr_up.png"
#define kIconName18  @"expense_up.png"
#define kIconName19  @""

#define kMenuName0  @"货品采购"
#define kMenuName1  @"货品管理"
#define kMenuName2  @"开单"
#define kMenuName3  @"销售历史"
//#define kMenuName4  @"客户订货"

#define kMenuName5  @"客户管理"
#define kMenuName6  @"财务报表"
#define kMenuName7  @"用户管理"
#define kMenuName8  @"日常支出"
#define kMenuName9  @"注销"
#define kMenuName10  @"用户信息"

#define kMenuName11  @"系统设置"
////////////////////////////////////////////////////////
#define rightTopBgColor [ZUtility getTopColor];

#define cLoginBgColor ZColor(64, 54, 49);
//ZWhiteColor(255)
//ZColor(52, 160, 211);

#define separateLine  @"-------------------------------------------------\r\n"
#define separateStar  @"************************************************\r\n"

///////////////////////////////////////////////////////

#define BarcodeBrand 1001
#define BarcodeCategory 1002
#define BarcodeKuanHao 1003
#define BarcodeColor 1004
#define BarcodeSize 1005
#define BarcodePrice 1006
#define BarcodeSubCode 1007

////////////////////////////////////////////////////////
//#define kCurrentViewTag 1001

//#define tableContentHeight 28
#define tableHeaderHeight 44
#define tablePageSize 15
#define tableCellWidthUnit 20

#define tableX 0
#define tableY 88
//leftViewTableWidth
#define tableWidth 1024 -140
#define tableHeight 560

#define kHeaderHeight 52

#define txtDefaultHeight 30
#define kHeaderHeight 52
#define rightTableY 130

#define kRowNumber 6
#define kDistanceWithLeft 5

#define kHeaderHeight 52
#define tableContentHeight 32
#define tableContentHeightM 38
#define tableHeaderHeight 44
#define tablePageSize 15
#define tableCellWidthUnit 20
#define tableCellTopDis 2
#define txtInputHeight 30
#define txtLabelWidthUnit 20
#define leftViewTableWidth 140
#define leftViewTableHeight 748
#define leftViewCellHeight 84

#define innerViewWidth (1024 -170)
#define innerViewHeight 500
/////////////////////////////////////////////////

#define dMoneyFormat @"%.2f"
#define kGuadanCache @"kuadanarray"

#define kItemCGItemIO_Normal 0
//货品调入 调出
#define kItemCGItemIO 10
#define kItemCGItemIO_Return 2
#define kItemCGItemIO_Out 3
#define kItemCGItemIO_In 4
#define kItemCGItemIO_Lost 5
//查询新增货品的记录，记录保存在采购order中
#define kItemCGNewItem 100

#define kType_Create 1
#define kType_Update 2
#define kType_Remove 3

//调入，调出，遗失
#define kItemCGItemIO_ALL 10
#define kItemCGItemIO_Waiting_Accept 11
#define kItemCGItemIO_OutPut 12
//Trade查询当前的，或者是上级的
#define kTradeFromSelf 21
#define kTradeFromUpper 22  //显示在 采购页面
#define kTradeFromUpperForSaler 24 //显示在开单页面
#define kTradeOrderTemp 23  //临时订单


// 1 品牌 ，2 类别， 3， 款号，4颜色， 5 尺码， 6 价格， 7 防串码
#define ruleTypeBrand 1
#define ruleTypeCategory 2
#define ruleTypeKuanhao 3
#define ruleTypeColor 4
#define ruleTypeSize 5
#define ruleTypePrice 6
#define ruleTypeSubcode 7

#define kToken @"USR-TOKEN"
#define NUMBERS @"0123456789\n"
#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"


#endif
