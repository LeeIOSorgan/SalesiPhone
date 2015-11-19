//
//  ZView.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/11/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZView.h"
#import "ZTableModel.h"
#import "ZTableCell.h"
#import "ZDataCache.h"
#import "ZResponse.h"
#import "ZUtility.h"

@interface ZView()<ZViewDelegate>

@end

@implementation ZView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ZWhiteColor(255);
    }
    return self;
}

- (void)setupView
{
    
}

- (void)clearData
{

}
- (void)clearView
{

}
- (void)removeView
{
    for (UIView* vv in self.subviews){
        [vv removeFromSuperview];
    }
}

-(void)hideKeyBoard:(NSMutableDictionary *)views
{
    NSEnumerator* keys = [views keyEnumerator];
    for(NSString* key in keys) {
        UIView* tf =[views objectForKey:key];
        if(tf.isFirstResponder) {
            [tf resignFirstResponder];
        }
    }
}
//-(void)initData:(NSMutableDictionary*)params
//{
//    
//}
- (void)postRequest:(BOOL)nextPage
{
    
}

- (void)save:(UIButton*)button
{
    
}
- (void)back:(UIButton*)button
{
    
}

-(void)showNumPad
{
    UIView *numbPad = [[ZDataCache sharedInstance] psView];
    if (numbPad.hidden) {
        numbPad.hidden = NO;
        numbPad.userInteractionEnabled = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [self viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)showErrorResponse:(ZResponse *)errorResp
{
    if (errorResp.code.code == 406) {
        [ZUtility showAlert:errorResp.text];
    }

}

@end
