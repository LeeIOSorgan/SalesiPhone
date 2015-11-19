//
//  ZDateSelectView.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/11/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZDateSelectView.h"
#import "ZDateSelector.h"


@interface ZDateSelectView ()<UITextFieldDelegate,ZDateSelectorDelegate>
{
    ZDateSelector* _selector;
}

@end


/////////////////////////////////////////
@implementation ZDateSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        CGRect frame = self.frame;
//        frame.origin.x = 0;
//        frame.origin.y = 0;
//        
//        frame.size.height = 30;
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.clearsOnBeginEditing = YES;
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.inputView = [[UIView alloc]initWithFrame:CGRectZero];
        //在SDK 5.1上，不能使用下面这句来监听。
//        self.delegate = self;
        [self addTarget:self
                 action:@selector(textFieldDidBeginEditing:)
       forControlEvents:UIControlEventEditingDidBegin];

//        [self addTarget:self
//                 action:@selector(textFieldDidChange:)
//       forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self
                 action:@selector(textFieldDidEndEditing:)
       forControlEvents:UIControlEventEditingDidEnd];
    }
    return self;
}


- (void)setupView
{

}



- (void)dateValueChanged:(NSString*)text
{
    self.text = text;
    if(_alertNotToday) {
        self.textColor = ZColor(255, 0, 0);
    }
}
-(void)dateValueChangeEnd
{
    [self resignFirstResponder];
}
- (void)showDateView
{
    CGRect backFrame = CGRectMake(0,0,1024, 768);
    if(_selector == nil) {
        _selector = [[ZDateSelector alloc]initWithFrame:backFrame];
//        _selector.tag = self.tag + 100;
        [_selector setupView];
        _selector.selectDelegate = self;
        [_selector showViewFrom:self];
        UIView* _pview = self.superview;
        [_pview addSubview:_selector];
        
    }
    
//    UIView* dateView = [_pview viewWithTag:2022];
//    if(dateView == nil) {
//    } else {
//    }
    _selector.hidden = NO;

}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self showDateView];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    ZLogInfo(@"textFieldDidEnd tag = %d, text = %@", textField.tag, textField.text);
    [textField resignFirstResponder];
    
//    [_selector removeFromSuperview];
//    _selector = nil;
    
}

- (void)textFieldDidBegin :(UITextField*)textField
{
}
- (void)textFieldDidEnd :(UITextField*)textField
{
}

- (void)textFieldDidChange :(UITextField*)textField
{
    ZLogInfo(@"textField.tag = %d, text = %@", textField.tag, textField.text);
    
    [self showDateView];
    
    if ([textField.text length] == 0){
        //[_tableView removeFromSuperview];
    }
    //[_delegate textFieldChanged:self text:textField.text];
}

- (void)dealloc{
    
//    [_textField removeFromSuperview];
//    [_textField release];
    
    [_selector removeFromSuperview];
//    [_datePicker release];

//    [super dealloc];
}

@end

