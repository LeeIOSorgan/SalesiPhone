//
//  ZListTextField.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-27.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCell.h"

typedef enum{
//    eListTypeKuanhao = 1,
    tempVar,
    eListTypeKuanhaoUsed,
    eListTypeItemName,
    eListTypeItemKuanHao,
    eListTypeItemBrandKuanHao,
    eListTypeItemKuanHaoAndItemFZ,
    eListTypePointItem,
    eListTypeCustomerPhoneName,
    eListTypeCustomerPhone,
    eListTypeCategory,
    eListTypeExpense,
    eListTypeBrand,
    eListTypeSeason,
    eListTypeSize,
    eListTypeColor,
    eListTypeColorCreate,
    eListTypeDiscount,
    eListTypeOrderMemo,
    eListTypeKuaiDi,
    eListTypeJobTitle,
    eListTypeCompany,
    eListTypeSeller,
    eListTypeCustomer,
    eListTypeItemCGType,
    eListTypeItemIOShops,
    eListTypeShop,
    eListTypeMyShops,
    eListTypeManufacture
}eListType;

@class ZPopupUIItemDTO;
@class ZPopUpSpecialItemView;

@protocol ZListTextFieldDelegate <NSObject>

-(void)setIdDTO:(UITextField*)tfList;

@end

@interface ZListTextField : UITextField

//@property (nonatomic )ZCell *cellView;
//@property (nonatomic )ZPopUpSpecialItemView* popoverContent;
@property (nonatomic,assign ) id<ZListTextFieldDelegate> listDelegate;
@property (nonatomic ) BOOL hideTable;
@property (nonatomic ) eListType listType;
@property (nonatomic ) BOOL didBegin;
@property (nonatomic ) BOOL numPad;
@property (nonatomic ) BOOL focusAfterSelected;
//YES 会在只剩一个的时候自动选择。在开单等界面使用。
@property (nonatomic ) BOOL autoSelectLast;

@property (nonatomic) NSNumber* filterId;

-(void)setPlaceHolder:(NSString*)placeHolder;
//-(void)setInputView:(UIView*)inputView;
- (void)setupView;
- (void)setTxTag:(NSInteger)tag;

-(ZPopupUIItemDTO*)getSelectedDTO;
-(void)setSelectedDTO:(ZPopupUIItemDTO*)dto;

-(void)updateDTO:(ZPopupUIItemDTO*) dto;
//-(void)setZCellView:(ZCell*)cell;
-(void)clearData;

@end
