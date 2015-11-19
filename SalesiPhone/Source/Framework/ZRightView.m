//
//  ZRightView.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 7/15/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZRightView.h"
//#import "ZGoodsManageView.h"
//#import "ZNotification.h"
//#import "ZAddGoodsView.h"
//
//#import "ZOrderView.h"
//
//#import "ZSystemSettingView.h"
//#import "ZCustomerManagerView.h"
//#import "ZLoginView.h"
//#import "ZUserManagerView.h"
//
//#import "ZGoodsPurchaseView.h"
//#import "ZGoodsSettingView.h"
//#import "ZSaleHistoryMgrView.h"
//#import "ZAccountMgrView.h"
//#import "ZAccoutInfoView.h"
//#import "ZDataCache.h"
//#import "ZExpenseMgrView.h"
//#import "ZSDLHelpView.h"
//#import "ZUtility.h"

@interface ZRightView ()
{
    int _currentIndex;
    ZView * gv;
    
    ZView * currentView;
    
//    ZGoodsManageView * goodsManagerView;
//    ZGoodsPurchaseView *goodsPurchaseView;
//    ZOrderView *orderView;
//    ZCustomerManagerView *customerMgrView;
//    ZSaleHistoryMgrView *saleHistoryView;
//    ZLoginView* lgv;
//    ZUserManagerView *userMgrView;
//    ZSystemSettingView * sysSettingView;
//    ZGoodsSettingView *goodSettingView;
//    ZAccountMgrView *accountMgrView;
//    ZAccoutInfoView* accountView;
//    ZExpenseMgrView* expenseMgrView;
    
}
@end

@implementation ZRightView

- (void)clearData
{
//    [gv removeFromSuperview];
    for (UIView* vv in self.subviews)
    {
        [vv removeFromSuperview];
//        [vv release];
    }
}

//-(void)dealloc
//{
//     ZLogInfo(@"---Into----ZRightView--dealloc-");
//    for(UIView *vv in self.subviews)
//    {
//        [vv removeFromSuperview];
//    }
//     goodsManagerView = nil;
//    goodsPurchaseView = nil;
//    orderView = nil;
//    customerMgrView = nil;
//    saleHistoryView = nil;
//    userMgrView = nil;
//    sysSettingView = nil;
//    goodSettingView = nil;
//    accountMgrView = nil;
//    accountView = nil;
////    [super dealloc];
//}
//
//-(void)hiddenCurrentView
//{
//    if(currentView) {
//        currentView.hidden = YES;
//    }
//}
//
//-(void)showCurrentView
//{
//    if(currentView) {
//        currentView.hidden = NO;
//    }
//}
//-(void)hideKeyBoard
//{
//    //数字键盘 暂时使用这种方式获取。
//    UIView *numbPad = [[ZDataCache sharedInstance] psView];
//    if (numbPad) {
//        numbPad.hidden = YES;
//    }
//    
//}
//- (void)showAccountInfoView:(NSMutableDictionary*)params
//{
//    ZLogInfo(@"----Into----showGoodsPurchaseView--");
//    if(_currentIndex ==1) {
//        return;
//    }
//    _currentIndex = 1;
//    [self hiddenCurrentView];
//    
//    if (accountView == nil)
//    {
//        accountView = [[ZAccoutInfoView alloc] initWithFrame:ZRect(100, 100, 600, 400)];
//        [accountView setupView];
//        [self addSubview:accountView];
//    }
//    [accountView initData:nil];
//    currentView  = accountView;
//    [self showCurrentView];
//    [self hideKeyBoard];
//    ZLogInfo(@"----Out----showGoodsPurchaseView--");
//}
//
//- (void)showGoodsPurchaseView:(NSMutableDictionary*)params
//{
//    ZLogInfo(@"----Into----showGoodsPurchaseView--");
//    
//    NSNumber* index = [params objectForKey:@"pageIndex"];
//    if(_currentIndex ==2 && !index) {
//        return;
//    }
//    _currentIndex = 2;
//    [self hiddenCurrentView];
//    
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    if(goodsPurchaseView == nil) {
//        goodsPurchaseView = [[ZGoodsPurchaseView alloc] initWithFrame:frame];
//        [goodsPurchaseView setupView];
//        [self addSubview:goodsPurchaseView];
//    }
//    {
//        [goodsPurchaseView initData:params];
//    }
//    currentView  = goodsPurchaseView;
//    [self showCurrentView];
//    ZLogInfo(@"----Out----showGoodsPurchaseView--");
//}
//
//- (void)showGoodsManagerView:(NSMutableDictionary*)params
//{
//    
//    if(_currentIndex ==3) {
//        return;
//    }
//     ZLogInfo(@"----into----showGoodsManagerView--");
//    _currentIndex = 3;
//   [self hiddenCurrentView];
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    
//    if(goodsManagerView == nil)
//    {
//        goodsManagerView = [[ZGoodsManageView alloc] initWithFrame:frame];
//        [goodsManagerView setupView];
//        [self addSubview:goodsManagerView];
//    }
//    {
//        [goodsManagerView initData:nil];
//    }
//    currentView  = goodsManagerView;
//    [self showCurrentView];
//    [self hideKeyBoard];
//    ZLogInfo(@"----Out----showGoodsManagerView--");
//}
//
//- (void)showAddGoodsView:(NSMutableDictionary*)params
//{
////    CGRect frame = self.frame;
////    frame.origin.x = 0;
////    frame.origin.y = 0;
////    
////    ZAddGoodsView* gv = [[ZAddGoodsView alloc] initWithFrame:frame];
////    [gv setupView];
////    [self addSubview:gv];
////    [gv release];
//}
//
//- (void)showOrderView:(NSMutableDictionary*)params
//{
//    if(_currentIndex ==4) {
//        return;
//    }
//     ZLogInfo(@"----into----showOrderView--");
//    _currentIndex = 4;
//    [self hiddenCurrentView];
////    [self clearData];
//    
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    if (orderView == nil)
//    {
//        orderView = [[ZOrderView alloc] initWithFrame:frame];
//        [orderView setupView];
//        [self addSubview:orderView];
//    }
//    {
//        [orderView initData:nil];
//    }
//    currentView  = orderView;
//    [self showCurrentView];
//    ZLogInfo(@"----Out----showOrderView--");
//}
//
//- (void)showExpenseRecordView:(NSMutableDictionary*)params
//{
//    if(_currentIndex ==13) {
//        return;
//    }
//    ZLogInfo(@"----into----showExpenseRecordView--");
//    _currentIndex = 13;
//    [self hiddenCurrentView];
//    
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    if (expenseMgrView ==nil)
//    {
//        expenseMgrView = [[ZExpenseMgrView alloc] initWithFrame:frame];
//        [expenseMgrView setupView];
//        [self addSubview:expenseMgrView];
//    }
//    {
//        [expenseMgrView initData:nil];
//    }
//    currentView  = expenseMgrView;
//    [self showCurrentView];
//    [self hideKeyBoard];
//    ZLogInfo(@"----Out----showSaleHistoryView--");
//}
//- (void)showAccountView:(NSMutableDictionary*)params
//{
//    if(_currentIndex ==5) {
//        return;
//    }
//    ZLogInfo(@"----into----showAccountView--");
//    _currentIndex = 5;
//    [self hiddenCurrentView];
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    if (accountMgrView == nil)
//    {
//        accountMgrView = [[ZAccountMgrView alloc] initWithFrame:frame];
//        [accountMgrView setupView];
//        [self addSubview:accountMgrView];
//    }
//    
//        [accountMgrView initData:nil];
//    
//    currentView  = accountMgrView;
//    [self showCurrentView];
//    [self hideKeyBoard];
//    ZLogInfo(@"----Out----showAccountView--");
//}
//
//- (void)showSaleHistoryView:(NSMutableDictionary*)params
//{
//    if(_currentIndex ==6) {
//        return;
//    }
//    ZLogInfo(@"----into----showSaleHistoryView--");
//    _currentIndex = 6;
//    [self hiddenCurrentView];
//    
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    if (saleHistoryView ==nil)
//    {
//        saleHistoryView = [[ZSaleHistoryMgrView alloc] initWithFrame:frame];
//        [saleHistoryView setupView];
//        [self addSubview:saleHistoryView];
//    }
//    {
//        [saleHistoryView initData:nil];
//    }
//    currentView  = saleHistoryView;
//    [self showCurrentView];
//    [self hideKeyBoard];
//    ZLogInfo(@"----Out----showSaleHistoryView--");
//}
////-------
//- (void)showClientManagerView:(NSMutableDictionary*)params
//{
//    if(_currentIndex ==7) {
//        return;
//    }
//     ZLogInfo(@"----into----showClientManagerView--");
//    _currentIndex = 7;
//    [self hiddenCurrentView];
//    
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    NSNumber* page = [params objectForKey:@"pageIndex"];
//    if(!page){
//        [params setObject:[NSNumber numberWithInt:0] forKey:@"pageIndex"];
//        
//    }
//    if(customerMgrView == nil)
//    {
//        customerMgrView= [[ZCustomerManagerView alloc] initWithFrame:frame];
//        [customerMgrView setupView];
//        [self addSubview:customerMgrView];
//    }
//    [customerMgrView initData:params];
//    //需要将 delete的实现放在。h文件中，不能在。m文件中。
////    _rightViewDelegate = customerMgrView;
//    currentView  = customerMgrView;
//    [self showCurrentView];
//    [self hideKeyBoard];
//    ZLogInfo(@"----Out----showClientManagerView--");
//}
//
////- (void)showLoginView:(NSMutableDictionary*)params
////{
////    if(_currentIndex ==8) {
////        return;
////    }
////     ZLogInfo(@"----into----showLoginView--");
////    _currentIndex = 8;
////    [self hiddenCurrentView];
////    
////    CGRect frame = self.frame;
////    frame.origin.x = 0;
////    frame.origin.y = 0;
////    if(lgv == nil)
////    {
////        lgv = [[ZLoginView alloc] initWithFrame:frame];
////        [lgv setupView:YES];
////        [lgv initData];
////        [self addSubview:lgv];
////    } else {
////        [lgv initData];
////    }
////    currentView  = lgv;
////    [self showCurrentView];
////    ZLogInfo(@"----Out----showLoginView--");
////}
//
//- (void)showUserManagerView:(NSMutableDictionary*)params
//{
//    if(_currentIndex ==9) {
//        return;
//    }
//     ZLogInfo(@"----into----showUserManagerView--");
//    _currentIndex = 9;
//    [self hiddenCurrentView];
//    
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    if (userMgrView == nil)
//    {
//        userMgrView = [[ZUserManagerView alloc] initWithFrame:frame];
//        [userMgrView setupView];
//        [userMgrView initData:nil];
//        [self addSubview:userMgrView];
//    } else {
//        [userMgrView initData:nil];
//    }
//    currentView  = userMgrView;
//    [self showCurrentView];
//    [self hideKeyBoard];
//    ZLogInfo(@"----Out----showUserManagerView--");
//}
//
//- (void)showSystemSettingView:(NSMutableDictionary*)params
//{
//    if(_currentIndex ==10) {
//        return;
//    }
//     ZLogInfo(@"----into----showSystemSettingView--");
//    _currentIndex = 10;
//    [self hiddenCurrentView];
//    
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    if(sysSettingView == nil)
//    {
//        sysSettingView = [[ZSystemSettingView alloc] initWithFrame:frame];
//        [sysSettingView setupView];
//        [sysSettingView initData:nil];
//        [self addSubview:sysSettingView];
//    } else {
//        [sysSettingView initData:nil];
//    }
//    currentView  = sysSettingView;
//    [self showCurrentView];
//    [self hideKeyBoard];
//    ZLogInfo(@"----Out----showSystemSettingView--");
//}
//
////----------------
//- (void)showGoodsSettingView:(NSMutableDictionary*)params
//{
//    if(_currentIndex ==11) {
//        return;
//    }
//     ZLogInfo(@"----into----showGoodsSettingView--");
//    _currentIndex = 11;
//    [self hiddenCurrentView];
//    
//    CGRect frame = self.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    if (goodSettingView == nil)
//    {
//        goodSettingView = [[ZGoodsSettingView alloc] initWithFrame:frame];
//        [goodSettingView setupView];
//        [goodSettingView initData:nil];
//        [self addSubview:goodSettingView];
//    } else {
//        [goodSettingView initData:nil];
//    }
//    currentView  = goodSettingView;
//    [self showCurrentView];
//    [self hideKeyBoard];
////    [gv release];
//    ZLogInfo(@"----Out----showGoodsSettingView--");
//}
//
//- (void)setupView
//{
//    ZLogInfo(@"----Into----setupView registerAllMessage-");
////    [self registerAllMessage];
//    self.backgroundColor = [UIColor whiteColor];
//}

@end
