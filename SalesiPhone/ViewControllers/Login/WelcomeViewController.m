//
//  WelcomeViewController.m
//  SalesiPhone
//
//  Created by Leejun on 15/11/18.
//  Copyright © 2015年 Leejun. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"

#import "ZLoginService.h"
#import "ZUtility.h"
#import "ZArchive.h"
#import "ZUserDTO.h"
#import "MBProgressHUD.h"
#import "ZItemService.h"
#import "ZDataCache.h"
#import "ZMacAddress.h"
#import "ZRegisterDeviceDTO.h"
#import "ZOthersService.h"

@interface WelcomeViewController ()

@property (nonatomic, strong) IBOutlet UITextField *accountTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) MBProgressHUD* HUD;

- (IBAction)skimAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)registDeviceAction:(id)sender;

@end

@implementation WelcomeViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.titleNavBar setHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *gestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    [self.view addGestureRecognizer:gestureRecongnizer];
    
//    [self registDevice:nil];
    _accountTextField.text = @"000";
    _passwordTextField.text = @"123456";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    [self textFieldResignFirstResponder];
}
- (void)textFieldResignFirstResponder{
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)skimAction:(id)sender{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate signIn];
}
- (IBAction)loginAction:(id)sender{
//    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appDelegate signIn];
    
    [self sendLogin];
    
}

- (IBAction)registDeviceAction:(id)sender{
    [self registDevice:sender];
}

#pragma mark - KeyboardNotification
-(void) keyboardWillShow:(NSNotification *)note{
    
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect supViewFrame = self.contentView.frame;
    
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    supViewFrame.origin.y = SCREEN_HEIGHT - keyboardBounds.size.height - supViewFrame.size.height+100;
    self.contentView.frame = supViewFrame;
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    
    CGRect supViewFrame = self.contentView.frame;
    supViewFrame.origin.y = SCREEN_HEIGHT - supViewFrame.size.height;
    self.contentView.frame = supViewFrame;
    
    // commit animations
    [UIView commitAnimations];
}

-(void)sendLogin{
    
    ZLoginService *zs = [[ZServiceFactory sharedService]getLoginService];
    [zs logout];
    NSString* name = _accountTextField.text;
    NSString* pwd = _passwordTextField.text;
    if([name length]==0|| [pwd length]<6)
    {
        [ZUtility showAlert:@"请检查用户名和密码输入是否正确！"];
        return;
    }
    [zs login:name pwd:pwd ifDemo:NO type:self];
}

-(void)registDevice:(UIButton*)btn
{
    NSString *appId = [ZMacAddress getDeviceId];
    ZRegisterDeviceDTO* dto = [[ZRegisterDeviceDTO alloc]init];
    dto.appid = appId;
    dto.verifyCode = @"172398";
    dto.shopType = [NSNumber numberWithInt:100];//服装批发商
    
    ZOthersService* service = [[ZServiceFactory sharedService]getOtherService];
    [service registerDeviceWithCode:dto type:self];
}

- (void)handleResponse:(ZResponse*)response
{
    switch (response.businessType) {
            
        case kLogin:
            if (response.code.code == 200 || response.code.code == 204) {
                if ([response.respObj isKindOfClass:[ZUserDTO class]]){
                    ZUserDTO* dto = (ZUserDTO*)response.respObj;
                    [ZDataCache sharedInstance].userDto = dto;
                    [ZResourceMgr shopType:[dto.shopType intValue]];
                    [[ZArchive instance] saveShopID:dto.shopId];
                    [[ZArchive instance] updateShopSettingString:40 key:kToken value:dto.token];
                    
                    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appDelegate signIn];
                    
//                    [self sendImportRequestBeforAll];
//                    NSString* name = [((UITextField*)[self viewWithTag:kTagUsername]) text];
//                    NSString* pwd = [((UITextField*)[self viewWithTag:kTagPassword]) text];
//                    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//                    [accountDefaults setObject:name forKey:kUserName];
//                    [accountDefaults setObject:pwd forKey:kPassword];
//                    [accountDefaults synchronize];
                }
            } else if(response.code.code) {
                
                [self showErrorResponse:response];
                
            } else {
                
                NSString* text = [NSString stringWithFormat:@"登录失败, 请稍后重试。"];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:text
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                
                [alert show];
                
                
            }
            break;
        case kRegisterDevice:
            if (response.code.code == 200 || response.code.code == 204) {
                [ZUtility showAlert:@"感谢您注册使用商得乐(SDL)IPad销售软件。请查看 微信 上您获得的账号！    掌淘科技"];
                [ZUtility endEdit:self.view];
                NSString* venderId = [ZMacAddress getDeviceId];
                [[ZArchive instance]updateRegistedIdenifierForVendor:venderId];
            } else if(response.code.code) {
                [self showErrorResponse:response];
            }
            break;
    }
    
}

-(void)sendImportRequestBeforAll
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.labelText = @"Loading";
    _HUD.removeFromSuperViewOnHide = YES;
    [_HUD show:YES];
    ZItemService* itemservice = [[ZServiceFactory sharedService]getItemService];
    [itemservice queryBaseData:self showLoading:NO];
    
    
}

-(void)showErrorResponse:(ZResponse *)errorResp
{
    if (errorResp.code.code == 406) {
        [ZUtility showAlert:errorResp.text];
    }
    
}

@end
