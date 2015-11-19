//
//  ZTestItemService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-25.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTestItemService.h"
#import "ZRequestInc.h"
#import "ZItemService.h"
#import "ZUserService.h"
#import "ZItemDataPage.h"
#import "ZItemDTO.h"
#import "ZItemCategoryDTO.h"
#import "ZItemColorDTO.h"
#import "ZItemCompanyDTO.h"
#import "ZPurchaseItemService.h"
#import "ZQueryItemConditionDTO.h"

@implementation ZTestItemService

-(void)testItem{
    ZItemService *item = [[ZServiceFactory sharedService]getItemService];

    ZQueryItemConditionDTO* dto = [[ZQueryItemConditionDTO alloc]init];
    dto.itemType = [NSNumber numberWithInt:3 ];
    [item queryItems:dto type:self];//list delist inside.
     
    [item addItem:nil type:self];
    [item queryColor:self showLoading:YES];
    [item queryCategory:self showLoading:YES];
    [item queryCompany:self showLoading:YES];
    [item addItemCategory:nil type:self];
    [item addItemColor:nil type:self];
    [item listItemBatch:self];
    [item delistItemBatch:self];
    
}

- (void)handleResponse:(ZResponse*)response
{
    switch (response.businessType) {
        case kItem_Query:
            if (response.code.code == 200 || response.code.code == 204) {
                if([response.respObj isKindOfClass: [ZItemDataPage class]]) {
                    ZItemDataPage *dataPage = (ZItemDataPage*)response.respObj;
                    ZLogInfo(@" Query Item Succeed datapage totalCount = %d", [dataPage.totalCount intValue]);
                    int i = 0;
                    for(ZItemDTO* obj in dataPage.itemDTOs) {
                        //                    ZLogInfo(@" Query Item Succeed = %@", obj.name);
                        if (i ==0 ) {
                            ZItemService *item = [[ZServiceFactory sharedService]getItemService];
                            [item delistItem:obj.itemId type:self];
                        }
                        if (i == 1) {
                            ZItemService *item = [[ZServiceFactory sharedService]getItemService];
                            [item listItem:obj.itemId type:self];
                        }
                        i++;
                        break;
                    }
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItem_Add:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                    if([response.respObj isKindOfClass:[ZItemDTO class]]) {
                        ZItemDTO *obj = (ZItemDTO*)response.respObj;
                        ZLogInfo(@"Add Item succeed = %@", obj.name);
                        ZItemService *item = [[ZServiceFactory sharedService]getItemService];
                        [item listItem:obj.itemId type:self];
                    }
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItem_BatDelist:
            if (response.code.code == 200 || response.code.code == 204) {
                ZLogInfo(@"Batch DeList Item succeed %d", kItem_BatDelist);
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItem_BatList:
            if (response.code.code == 200 || response.code.code == 204) {
                ZLogInfo(@"Batch List Item succeed %d", kItem_BatList);
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItem_Delist:
            if (response.code.code == 200 || response.code.code == 204) {
                ZLogInfo(@"DeList Item succeed  %d", kItem_Delist);
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItem_List:
            if (response.code.code == 200 || response.code.code == 204) {
                ZLogInfo(@"List Item succeed %d", kItem_List);
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItemCategory_Qry:
            if (response.code.code == 200 || response.code.code == 204) {
                if ([response.respObj isKindOfClass:[NSArray class]]){
                    NSArray *array = (NSArray*) response.respObj;
                    for(id tmpObj in array) {
                        if([tmpObj isKindOfClass:[ZItemCategoryDTO class]]) {
                            //                            ZItemCategoryDTO *obj = (ZItemCategoryDTO*)tmpObj;
                        }
                    }
                    ZLogInfo(@"Query item category succeed %lu", [array count]);
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            
            break;
        case kItemCategory_Add:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                    if([response.respObj isKindOfClass:[ZItemCategoryDTO class]]) {
                        ZItemCategoryDTO *obj = (ZItemCategoryDTO*)response.respObj;
                        ZLogInfo(@"Add ItemCategory succeed = %@", obj.name);
                    }
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItemCategory_En:
        case kItemCategory_Dis:
            if (response.code.code == 200 || response.code.code == 204) {
                ZLogInfo(@"kItemCategory succeed %d", response.businessType);
            }else {
                ZLogInfo(@" kItemCategory Error  = %d",response.businessType);
            }
            break;
        case kItemColor_Add:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                    if([response.respObj isKindOfClass:[ZItemColorDTO class]]) {
                        ZItemColorDTO *obj = (ZItemColorDTO*)response.respObj;
                        ZLogInfo(@"Add ItemColor succeed = %@", obj.color);
                    }
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItemColor_Qry:
            if (response.code.code == 200 || response.code.code == 204) {
                if ([response.respObj isKindOfClass:[NSArray class]]){
                    NSArray *array = (NSArray*) response.respObj;
                    for(id tmpObj in array) {
                        if([tmpObj isKindOfClass:[ZItemColorDTO class]]) {
                            // ZItemColorDTO *obj = (ZItemColorDTO*)tmpObj;
                        }
                    }
                    ZLogInfo(@"Query item color succeed = %lu",[array count]);
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kItem_Sync:
        case kItemFZ_Sync:
        case kUser_Sync:
        case kItemColor_En:
        case kItemColor_Dis:
        case kItemCompany_Add:
        case kItemCompany_Qry:
            default:
            break;
    }
}
@end
