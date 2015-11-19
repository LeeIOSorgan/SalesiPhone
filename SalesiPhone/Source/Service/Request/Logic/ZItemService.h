//
//  ZItemService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-16.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZItemDTO;
@class ZItemDataPage;
@class ZItemCategoryDTO;
@class ZItemColorDTO;
@class ZItemCompanyDTO;
@class ZItemSizeDTO;
@class ZItemBrandDTO;
@class ZQueryItemConditionDTO;
@class ZItemDiscountDTO;
@class ZItemExpenseDTO;
@class ZItemOrderMemo;

@interface ZItemService : NSObject
-(void)queryBaseData:(id)delegate showLoading:(BOOL)showLoading;

-(void)queryItems:(ZQueryItemConditionDTO*)params type:(id)delegate;
-(void)updateItemsSalePrice:(NSArray*)params type:(id)delegate;
-(void)updateItem:(ZItemDTO*)item1 type:(id)delegate;

-(void)queryItemDetail:(NSNumber*)itemId type:(id)delegate;
-(void)addItem:(ZItemDTO*)item1 type:(id)delegate;
-(void)listItem:(NSNumber*)itemID type:(id)delegate;
-(void)delistItem:(NSNumber*)itemID type:(id)delegate;
-(void)delistItems:(NSMutableArray*)itemIDs type:(id)delegate;
-(void)listItemBatch:(id)delegate;
-(void)delistItemBatch:(id)delegate;

-(void)queryItemFZs:(id)delegate showLoading:(BOOL)showLoading;;
-(void)addItemFZ:(ZItemDTO*)itemFz type:(id)delegate;
-(void)deleteItemFZ:(NSString*) itemFZId type:(id)delegate;
-(void)enableItemFZ:(NSString*) itemFZId type:(id)delegate;
-(void)updateItemFZ:(ZItemDTO*) itemFZ type:(id)delegate;

-(void)queryCategory:(id)delegate showLoading:(BOOL)showLoading;
-(void)addItemCategory:(ZItemCategoryDTO*)category1 type:(id)delegate;
-(void)updateItemCategory:(ZItemCategoryDTO*)category1 type:(id)delegate;

-(void)queryExpense:(id)delegate showLoading:(BOOL)showLoading;;
-(void)addItemExpense:(ZItemExpenseDTO*)category1 type:(id)delegate;
-(void)updateItemExpense:(ZItemExpenseDTO*)category1 type:(id)delegate;

-(void)queryColor:(id)delegate showLoading:(BOOL)showLoading;
-(void)addItemColor:(ZItemColorDTO*)category1 type:(id)delegate;
-(void)updateItemColor:(ZItemColorDTO*)color1 type:(id)delegate;

-(void)queryOrderMemo:(id)delegate showLoading:(BOOL)showLoading;
-(void)addItemOrderMemo:(ZItemOrderMemo*)category1 type:(id)delegate;
-(void)updateItemOrderMemo:(ZItemOrderMemo*)color1 type:(id)delegate;
-(void)changeItemOrderMemo:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;

-(void)queryDiscount:(id)delegate showLoading:(BOOL)showLoading;;
-(void)addItemDiscount:(ZItemDiscountDTO*)category1 type:(id)delegate;
-(void)updateItemDiscount:(ZItemDiscountDTO*)color1 type:(id)delegate;

-(void)queryCompany:(id)delegate showLoading:(BOOL)showLoading;;
-(void)addItemCompany:(ZItemCompanyDTO*)category1 type:(id)delegate;
-(void)updateItemCompany:(ZItemCompanyDTO*)category1 type:(id)delegate;

-(void)queryCompanyFee:(NSNumber*)comId type:(id)delegate;

-(void)queryItemSize:(id)delegate showLoading:(BOOL)showLoading;
-(void)addItemSize:(ZItemSizeDTO*)size1 type:(id)delegate;
-(void)updateItemSize:(ZItemSizeDTO*)size1 type:(id)delegate;

-(void)queryItemBrand:(id)delegate showLoading:(BOOL)showLoading;;
-(void)addItemBrand:(ZItemBrandDTO*)size1 type:(id)delegate;
-(void)updateItemBrand:(ZItemBrandDTO*)size1 type:(id)delegate;

-(void)changeItemExpense:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;
-(void)changeItemCategory:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;
-(void)changeItemColor:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;
-(void)changeItemDiscount:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;
-(void)changeItemSize:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;
-(void)changeItemBrand:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;
-(void)changeItemCompany:(NSArray*)ids ifenable:(Boolean)enable type:(id)delegate;

@end
