//
//  ZItemService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-16.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

//1, 商品类别查询接口
//2，添加商品类别接口
//货品类别停用接口
//货品类别启用接口
//3，颜色查询接口
//4，添加颜色接口
//5，供应商查询接口
//6，供应商添加接口
//7, 商品尺码查询接口
//8，商品尺码添加接口

//2，获取商品接口
//可用的查询参数：kuan_hao，item_company，category，begin_time，end_time，pageNo（默认为1），pageSize（默认为20），
//3，添加商品接口
//4，商品上架接口（单个商品）
//5，商品下架接口（单个商品）
//6，批量商品上架接口
//7，批量商品下架接口

#import "ZItemService.h"
#import "HttpManager.h"
#import "ZRequestInc.h"
#import "ZItemDTO.h"
#import "ZItemDataPage.h"
#import "ZItemCategoryDTO.h"
#import "ZItemColorDTO.h"
#import "ZItemCompanyDTO.h"
#import "ZItemSizeDTO.h"
#import "ZItemBrandDTO.h"
#import "ZType.h"
#import "ZUtility.h"
#import "ZItemDiscountDTO.h"
#import "ZItemExpenseDTO.h"
#import "ZItemOrderMemo.h"

@implementation ZItemService

/*
 商品查询接口
 url: http://{server.ip}:{server.port}/{server.name}/rs/item?queryParam=queryValue
 可用的查询参数：kuan_hao，item_company，category，begin_time，end_time，pageNo（默认为1），pageSize（默认为20），
 sortField（默认为创建时间）， sortDirection（默认为Desc），saleType（默认为onsale, 可选的参数有onsale, newest, kucun）
 */
-(void)queryItems:(ZQueryItemConditionDTO*)params type:(id)delegate {
//    NSString *tmps = [ZUtility parametersWithDic:params];
    
    HttpParam* hp = [[HttpParam alloc] init];
//    NSString* param = [NSString stringWithFormat:@"sortDirection=desc&%@", tmps];
    hp.strUrl = urlItemQuery;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemDataPage";
    hp.delegate = delegate;
    hp.requestObj= params;
    hp.type = kItem_Query;
     
    ZLogInfo(@"Request Service queryItems type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)updateItemsSalePrice:(NSArray*)items type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"saleType=%@", @"onsale"];
    hp.strUrl = urlItemUpdatePrice;
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
     
    hp.type = kItem_UpdatPrice;
    hp.isArray =YES;
    hp.requestObj = items;
    
    ZLogInfo(@"Request Service updateItemsSalePrice type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)queryItemFZs:(id)delegate showLoading:(BOOL)showLoading;{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemFZ;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemDTO";
    hp.delegate = delegate;
     hp.isArray =YES;
    hp.type = kItemFZ_Qry;
    ZLogInfo(@"Request Service queryItemFZs type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)addItemFZ:(ZItemDTO*)itemFZ type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemFZ;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemDTO";
    hp.delegate = delegate;
     
    hp.requestObj = itemFZ;
    hp.type = kItemFZ_Add;
    ZLogInfo(@"Request Service addItemFZ type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)updateItemFZ:(ZItemDTO*) itemFZ type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemFZUpdate, itemFZ.itemId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.requestObj = itemFZ;
    hp.type = kItemFZ_Update;
    ZLogInfo(@"Request Service addItemFZ type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)deleteItemFZ:(NSString*) itemFZId type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemFZDel, itemFZId];
    hp.strMethod = @"DELETE";
    hp.respClassType =@"ZItemDTO";
    hp.delegate = delegate;
     
    hp.type = kItemFZ_Del;
    ZLogInfo(@"Request Service deleteItemFZ type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)enableItemFZ:(NSString*) itemFZId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemFZEnable, itemFZId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.type = kItemFZ_Enable;
    ZLogInfo(@"Request Service enableItemFZ type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)queryItemDetail:(NSNumber*)itemId type:(id)delegate{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemDetail, [itemId stringValue]];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemDTO";
    hp.delegate = delegate;
    hp.type = kItem_QueryDetail;
    ZLogInfo(@"Request Service addItem type = %d", hp.type);

    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)addItem:(ZItemDTO*)item1 type:(id)delegate{
   
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItem;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemDTO";
    hp.delegate = delegate;
     
    hp.requestObj = item1;
    hp.type = kItem_Add;
    ZLogInfo(@"Request Service addItem type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)updateItem:(ZItemDTO*)item1 type:(id)delegate{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemUpdate, [item1.itemId stringValue]];
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemDTO";
    hp.delegate = delegate;
    
    hp.requestObj = item1;
    hp.type = kItem_Update;
    ZLogInfo(@"Request Service addItem type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}


-(void)listItem:(NSNumber*)itemID type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl =  [NSString stringWithFormat:urlItemEn, itemID];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
     
    hp.type = kItem_List;
    ZLogInfo(@"Request Service listItem type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)delistItem:(NSNumber*)itemID type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemDis, itemID];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
     
    hp.type = kItem_Delist;
    ZLogInfo(@"Request Service delistItem type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)delistItems:(NSMutableArray*)itemIDs type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemDelistBatch;
    hp.strMethod = @"POST";
    hp.requestObj = itemIDs;
    hp.delegate = delegate;
    
    hp.type = kItem_Delist_Batch;
    ZLogInfo(@"Request Service delistItems type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)listItemBatch:(id)delegate {
    NSArray * listItems =  [NSArray arrayWithObjects:[NSNumber numberWithInt:25],[NSNumber numberWithInt:26],[NSNumber numberWithInt:27], nil];
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemBatchEn;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
     
    hp.type = kItem_BatList;
    hp.requestObj = listItems;
    ZLogInfo(@"Request Service listItemBatch type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
//商品批量下架接口
-(void)delistItemBatch:(id)delegate {
    NSArray * listItems =  [NSArray arrayWithObjects:[NSNumber numberWithInt:25],[NSNumber numberWithInt:26],[NSNumber numberWithInt:27], nil];
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlItemBatchDis;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
     
    hp.type = kItem_BatDelist;
    hp.requestObj = listItems;
    ZLogInfo(@"Request Service delistItemBatch type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}


-(void)queryCategory:(id)delegate showLoading:(BOOL)showLoading{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlCategory;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemCategoryDTO";
    hp.delegate = delegate;
    
    hp.showLoading = showLoading;
    hp.isArray = YES;
    hp.type = kItemCategory_Qry;
    ZLogInfo(@"Request Service queryCategory type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)addItemCategory:(ZItemCategoryDTO*)category1 type:(id)delegate{
    category1.used=YES;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlCategory;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemCategoryDTO";
    hp.delegate = delegate;
     
    hp.type = kItemCategory_Add;
    hp.requestObj = category1;
    ZLogInfo(@"Request Service addItemCategory type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)updateItemCategory:(ZItemCategoryDTO*)category1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlCategoryUpdate;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    
    hp.type = kItemCategory_Update;
    hp.requestObj = category1;
    ZLogInfo(@"Request Service updateItemCategory type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)changeItemCategory:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlCategoryEn;
        hp.type = kItemCategory_En;
    } else {
        hp.strUrl = urlCategoryDis;
        hp.type = kItemCategory_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
     
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeItemCategory type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)queryExpense:(id)delegate showLoading:(BOOL)showLoading{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlExpense;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemExpenseDTO";
    hp.delegate = delegate;
    
    hp.showLoading = showLoading;
    hp.isArray = YES;
    hp.type = kItemExpense_Qry;
    ZLogInfo(@"Request Service queryExpense type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

-(void)addItemExpense:(ZItemExpenseDTO*)category1 type:(id)delegate{
    category1.used=YES;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlExpense;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemExpenseDTO";
    hp.delegate = delegate;
    
    hp.type = kItemExpense_Add;
    hp.requestObj = category1;
    ZLogInfo(@"Request Service addItemExpense type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)updateItemExpense:(ZItemExpenseDTO*)category1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlExpenseUpdate;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    
    hp.type = kItemExpense_Update;
    hp.requestObj = category1;
    ZLogInfo(@"Request Service updateItemExpense type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)changeItemExpense:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlExpenseEn;
        hp.type = kItemExpense_En;
    } else {
        hp.strUrl = urlExpenseDis;
        hp.type = kItemExpense_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeItemExpense type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)queryBaseData:(id)delegate showLoading:(BOOL)showLoading{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlShopBaseData;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZSyncBaseData";
    hp.delegate = delegate;
    
    hp.showLoading = showLoading;
    hp.type = kItemSyncBaseData;
    ZLogInfo(@"Request Service queryBaseData type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryColor:(id)delegate showLoading:(BOOL)showLoading{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlColor;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemColorDTO";
    hp.delegate = delegate;
    
    hp.showLoading = showLoading;
    hp.isArray = YES;
    hp.type = kItemColor_Qry;
    ZLogInfo(@"Request Service queryColor type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)addItemColor:(ZItemColorDTO*)color1 type:(id)delegate{
    color1.used = YES;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlColor;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemColorDTO";
    hp.delegate = delegate;
     
    hp.requestObj = color1;
    hp.type = kItemColor_Add;
    ZLogInfo(@"Request Service addItemColor type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)updateItemColor:(ZItemColorDTO*)color1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlColorUpdate;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    
    hp.requestObj = color1;
    hp.type = kItemColor_Update;
    ZLogInfo(@"Request Service updateItemColor type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)changeItemColor:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlColorEn;
        hp.type = kItemColor_En;
    } else {
        hp.strUrl = urlColorDis;
        hp.type = kItemColor_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeItemColor type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

-(void)queryOrderMemo:(id)delegate showLoading:(BOOL)showLoading{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlOrderMemo;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemOrderMemo";
    hp.delegate = delegate;
    
    hp.showLoading = showLoading;
    hp.isArray = YES;
    hp.type = kItemOrderMemo_Qry;
    ZLogInfo(@"Request Service queryOrderMemo type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)addItemOrderMemo:(ZItemOrderMemo*)color1 type:(id)delegate{
    color1.used = YES;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlOrderMemo;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemOrderMemo";
    hp.delegate = delegate;
    
    hp.requestObj = color1;
    hp.type = kItemOrderMemo_Add;
    ZLogInfo(@"Request Service addItemOrderMemo type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)updateItemOrderMemo:(ZItemOrderMemo*)color1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlOrderMemoUpdate;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    
    hp.requestObj = color1;
    hp.type = kItemOrderMemo_Update;
    ZLogInfo(@"Request Service updateItemOrderMemo type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)changeItemOrderMemo:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlOrderMemoEn;
        hp.type = kItemOrderMemo_En;
    } else {
        hp.strUrl = urlOrderMemoDis;
        hp.type = kItemOrderMemo_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeItemOrderMemo type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}


-(void)queryDiscount:(id)delegate showLoading:(BOOL)showLoading;{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlDiscount;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemDiscountDTO";
    hp.delegate = delegate;
    
    hp.showLoading = showLoading;
    hp.isArray = YES;
    hp.type = kItemDiscount_Qry;
    ZLogInfo(@"Request Service queryDiscount type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

-(void)addItemDiscount:(ZItemDiscountDTO*)color1 type:(id)delegate{
    color1.used = YES;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlDiscount;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemDiscountDTO";
    hp.delegate = delegate;
    
    hp.requestObj = color1;
    hp.type = kItemDiscount_Add;
    ZLogInfo(@"Request Service addItemDiscount type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)updateItemDiscount:(ZItemDiscountDTO*)color1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlDiscountUpdate;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    
    hp.requestObj = color1;
    hp.type = kItemDiscount_Update;
    ZLogInfo(@"Request Service updateItemDiscount type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

-(void)changeItemDiscount:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlDiscountEn;
        hp.type = kItemDiscount_En;
    } else {
        hp.strUrl = urlDiscountDis;
        hp.type = kItemDiscount_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeItemDiscount type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

-(void)queryCompany:(id)delegate showLoading:(BOOL)showLoading;{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlCompany;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemCompanyDTO";
    hp.delegate = delegate;
    
    hp.showLoading = showLoading;
    hp.isArray = YES;
    hp.type = kItemCompany_Qry;
    ZLogInfo(@"Request Service Request queryCompany type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)queryCompanyFee:(NSNumber*)comId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlCompanyQryFee, comId];
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemCompanyDTO";
    hp.delegate = delegate;
    hp.type = kItemCompany_QryFee;
    ZLogInfo(@"Request Service Request queryCompanyFee type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)addItemCompany:(ZItemCompanyDTO*)company1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlCompany;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemCompanyDTO";
    hp.delegate = delegate;  
     
    hp.requestObj = company1;
    hp.type = kItemCompany_Add;
    ZLogInfo(@"Request Service addItemCompany type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)changeItemCompany:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlCompanyEn;
        hp.type = kItemCompany_En;
    } else {
        hp.strUrl = urlCompanyDis;
        hp.type = kItemCompany_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeItemCompany type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)updateItemCompany:(ZItemCompanyDTO*)company1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlCompanyUpdate;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemCompanyDTO";
    hp.delegate = delegate;
    
    hp.requestObj = company1;
    hp.type = kItemCompany_Update;
    ZLogInfo(@"Request Service updateItemCompany type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)queryItemSize:(id)delegate showLoading:(BOOL)showLoading{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlSize;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemSizeDTO";
    hp.delegate = delegate;
    
    hp.showLoading = showLoading;
    hp.isArray = YES;
    hp.type = kItemSize_Qry;
    ZLogInfo(@"Request Service queryItemSize type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}
-(void)addItemSize:(ZItemSizeDTO*)size1 type:(id)delegate{
    size1.used = YES;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlSize;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemSizeDTO";
    hp.delegate = delegate;
     
    hp.requestObj = size1;
    hp.type = kItemSize_Add;
    ZLogInfo(@"Request Service addItemSize type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)updateItemSize:(ZItemSizeDTO*)size1 type:(id)delegate{
    size1.used = YES;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlSizeUpdate;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemSizeDTO";
    hp.delegate = delegate;
    
    hp.requestObj = size1;
    hp.type = kItemSize_Update;
    ZLogInfo(@"Request Service updateItemSize type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

-(void)changeItemSize:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlSizeEn;
        hp.type = kItemSize_En;
    } else {
        hp.strUrl = urlSizeDis;
        hp.type = kItemSize_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
     
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeItemSize type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
     
}

-(void)queryItemBrand:(id)delegate showLoading:(BOOL)showLoading;{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlBrand;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZItemBrandDTO";
    hp.delegate = delegate;
    
    hp.showLoading =showLoading;
    hp.isArray = YES;
    hp.type = kItemBrand_Qry;
    ZLogInfo(@"Request Service queryItemBrand type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)addItemBrand:(ZItemBrandDTO*)size1 type:(id)delegate{
    size1.used = YES;
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlBrand;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZItemBrandDTO";
    hp.delegate = delegate;
    
    hp.requestObj = size1;
    hp.type = kItemBrand_Add;
    ZLogInfo(@"Request Service addItemBrand type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)updateItemBrand:(ZItemBrandDTO*)size1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlBrandUpdate;
    hp.strMethod = @"POST";
    hp.delegate = delegate;
    
    hp.requestObj = size1;
    hp.type = kItemBrand_Update;
    ZLogInfo(@"Request Service addItemBrand type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)changeItemBrand:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    if(enable) {
        hp.strUrl = urlBrandEn;
        hp.type = kItemBrand_En;
    } else {
        hp.strUrl = urlBrandDis;
        hp.type = kItemBrand_Dis;
    }
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    
    hp.requestObj = ids;
    ZLogInfo(@"Request Service changeItemBrand type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

@end
