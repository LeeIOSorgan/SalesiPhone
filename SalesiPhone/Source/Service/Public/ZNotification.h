

#import <Foundation/Foundation.h>

//for theme
#define kThemeUpdate                    @"ThemeUpdate"

//for menu
//menu notify
//#define kMenuSelected                   @"MenuSelected"
#define kShowGoodsManageView            @"ShowGoodsManageView"
#define kShowAddGoodsView               @"ShowAddGoodsView"

#define kShowOrderView                  @"ShowOrderView"

#define kShowClientManagerView          @"ShowClientManagerView"

#define    kShowUserManagerView     @"ShowUserManagerView"
//#define    kShowLoginView           @"ShowLoginView"
#define    kShowSystemSettingView   @"ShowSystemSettingView"
#define    kShowExpenseMgrView   @"ShowExpenseMgrView"

#define    kShowAccountView   @"ShowAccountView"
//#define    kShowGoodsSettingView    @"ShowGoodsSettingView"
#define    kShowGoodsPurchaseView   @"ShowGoodsPurchaseView"
#define    kShowLoginUserInfoView   @"ShowLoginUserInfoView"
#define    kShowSaleHistoryView     @"ShowSaleHistoryView"
#define    kShowLogoutView          @"ShowLogoutView"

#define    kShowPurchaseGoodsView          @"ShowPurchaseGoodsView"

//notify menu
#define kMenuBadgeNumber                @"MenuBadgeNumber"
#define kUnReadMessageNumberChanged     @"UnReadMessageNumberChanged"


#define kLoginSuccess           @"LoginSuccess"
#define kLogOut           @"LogOut"
#define kUserInfo               @"UserInfo"

#define kZoomLeftView           @"ZoomLeftView"

@interface ZNotification : NSObject

+ (ZNotification*)sharedInstance;

- (void)registerObserver:(id)observer selector:(SEL)sel message:(NSString*)msg;
- (void)removeObserver:(id)observer message:(NSString*)msg;
- (void)removeObserver:(id)observer;

- (void)notify:(NSString*)message;
- (void)notify:(NSString*)message sender:(id)sender;
- (void)notify:(NSString*)message userInfo:(NSDictionary*)info;
- (void)notify:(NSString*)message sender:(id)sender userInfo:(NSDictionary*)info;

@end
