//
//  ZRightView.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 7/15/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZNotification.h"
#import "ZView.h"
#import "ZListTextField.h"

@interface ZRightView : ZView

@property(nonatomic,assign)id<ZRightViewSelectDelegate> rightViewDelegate;

//- (void)showLoginView:(NSMutableDictionary*)params;
- (void)showGoodsManagerView:(NSMutableDictionary*)params;
- (void)showAccountInfoView:(NSMutableDictionary*)params;
- (void)showGoodsPurchaseView:(NSMutableDictionary*)params;
- (void)showAddGoodsView:(NSMutableDictionary*)params;
- (void)showOrderView:(NSMutableDictionary*)params;
- (void)showExpenseRecordView:(NSMutableDictionary*)params;
- (void)showAccountView:(NSMutableDictionary*)params;
- (void)showSaleHistoryView:(NSMutableDictionary*)params;
- (void)showClientManagerView:(NSMutableDictionary*)params;
- (void)showUserManagerView:(NSMutableDictionary*)params;
- (void)showSystemSettingView:(NSMutableDictionary*)params;
- (void)showGoodsSettingView:(NSMutableDictionary*)params;


@end
