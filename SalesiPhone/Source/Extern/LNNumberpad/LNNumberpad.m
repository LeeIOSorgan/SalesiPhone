/******************************************************************************
 * v. 0.9.5  09 MAY 2013
 * Filename  LNNumberpad.m
 * Project:  LNNumberpad
 * Purpose:  Class to display a custom LNNumberpad on an iPad and properly handle
 *           the text input.
 * Author:   Louis Nafziger
 *
 * Copyright 2012 - 2013 Louis Nafziger
 ******************************************************************************
 *
 * This file is part of LNNumberpad.
 *
 * COPYRIGHT 2012 - 2013 Louis Nafziger
 *
 * LNNumberpad is free software: you can redistribute it and/or modify
 * it under the terms of the The MIT License (MIT).
 *
 * LNNumberpad is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * The MIT License for more details.
 *
 * You should have received a copy of the The MIT License (MIT)
 * along with LNNumberpad.  If not, see <http://opensource.org/licenses/MIT>.
 *
 *****************************************************************************/

#import "LNNumberpad.h"

#pragma mark - Private methods

@interface LNNumberpad (){
    //@property (nonatomic, weak) UIResponder <UITextInput> *targetTextInput;
    //neil here  temp
    UIResponder <UITextInput>* targetTextInput;
}
@end


#pragma mark - LNNumberpad Implementation

@implementation LNNumberpad

//@synthesize targetTextInput;

#pragma mark - Shared LNNumberpad method

+ (LNNumberpad *)defaultLNNumberpad {
    static LNNumberpad *defaultLNNumberpad = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        defaultLNNumberpad = [[[NSBundle mainBundle] loadNibNamed:@"LNNumberpad" owner:self options:nil] objectAtIndex:0];
    });
    
    return defaultLNNumberpad;
}

#pragma mark - view lifecycle

- (id)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"LNNumberpad" owner:self options:nil] objectAtIndex:0];
    self.frame = frame;
    self.backgroundColor = ZColor(217, 219, 223);
    targetTextInput = nil;
    if (self) {
        [self addObservers];
    }
    
    return self;
}

//- (id)initWithCharFrame:(CGRect)frame {
//    //    self = [super initWithFrame:frame];
//    self = [[[NSBundle mainBundle] loadNibNamed:@"LNCharacterpad" owner:self options:nil] objectAtIndex:0];
//    self.frame = frame;
//    self.backgroundColor = ZColor(217, 219, 223);
//    targetTextInput = nil;
//    if (self) {
//        [self addObservers];
//    }
//    
//    return self;
//}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObservers];
    }
    return self;
}

- (void)addObservers {
    // Keep track of the textView/Field that we are editing
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingDidBegin:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingDidBegin:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingDidEnd:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingDidEnd:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:nil];
}

- (void)dealloc {
    ZLogInfo(@"---Into----LNNumberpad--dealloc---");
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidBeginEditingNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidEndEditingNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:nil];
    if (targetTextInput) {
        targetTextInput = nil;
        
    }
}

#pragma mark - editingDidBegin/End

// Editing just began, store a reference to the object that just became the firstResponder
- (void)editingDidBegin:(NSNotification *)notification {
//    if(!self.hidden)
    {
        if ([notification.object isKindOfClass:[UIResponder class]])
        {
            if ([notification.object conformsToProtocol:@protocol(UITextInput)]) {
                targetTextInput = notification.object;
                return;
            }
        }
    // Not a valid target for us to worry about.
//    self.targetTextInput = nil;
    }
}

// Editing just ended.
- (void)editingDidEnd:(NSNotification *)notification {
//    if ([notification.object isKindOfClass:[UITextField class]])
//    {
//        UITextField* input = (UITextField*)notification.object;
//        [input resignFirstResponder];
//    }
//    self.targetTextInput = nil;
}

#pragma mark - Keypad IBAction's

// A number (0-9) was just pressed on the number pad
// Note that this would work just as well with letters or any other character and is not limited to numbers.
- (IBAction)numberpadNumberPressed:(UIButton *)sender {
    if (targetTextInput) {
        NSString *numberPressed  = sender.titleLabel.text;
        if ([numberPressed length] > 0) {
            UITextRange *selectedTextRange = targetTextInput.selectedTextRange;
            if (selectedTextRange) {
                [self textInput:targetTextInput replaceTextAtTextRange:selectedTextRange withString:numberPressed];
            }
        }
    }
}

// The delete button was just pressed on the number pad
- (IBAction)numberpadDeletePressed:(UIButton *)sender {
    if (targetTextInput) {
        UITextRange *selectedTextRange = targetTextInput.selectedTextRange;
        if (selectedTextRange) {
            // Calculate the selected text to delete
            UITextPosition  *startPosition  = [targetTextInput positionFromPosition:selectedTextRange.start offset:-1];
            if (!startPosition) {
                return;
            }
            UITextPosition  *endPosition    = selectedTextRange.end;
            if (!endPosition) {
                return;
            }
            UITextRange     *rangeToDelete  = [targetTextInput textRangeFromPosition:startPosition
                                                                               toPosition:endPosition];
            
            [self textInput:targetTextInput replaceTextAtTextRange:rangeToDelete withString:@""];
        }
    }
}

// The clear button was just pressed on the number pad
- (IBAction)numberpadClearPressed:(UIButton *)sender {
    if (targetTextInput) {
        UITextRange *allTextRange = [targetTextInput textRangeFromPosition:targetTextInput.beginningOfDocument
                                                                     toPosition:targetTextInput.endOfDocument];
        
        [self textInput:targetTextInput replaceTextAtTextRange:allTextRange withString:@""];
    }
}
// The done button was just pressed on the number pad
- (IBAction)numberpadNextPressed:(UIButton *)sender{
    [[UIDevice currentDevice] playInputClick];
    if ([targetTextInput isKindOfClass:[UITextField class]])
    {
        UITextField * textView = (UITextField*)targetTextInput;
//        NSInteger nextTag = textView.tag + 1;
//        // Try to find next responder
//        UIResponder* nextResponder = [textView.superview viewWithTag:nextTag];
//        if (nextResponder) {
//            // Found next responder, so set it.
//            [nextResponder becomeFirstResponder];
//        } else {
//            // Not found, so remove keyboard.
//            [self.targetTextInput resignFirstResponder];
//        }
        if ([textView.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
            if ([textView.delegate textFieldShouldReturn:textView]) {
                
            }
        }
    }
}

// The done button was just pressed on the number pad
- (IBAction)numberpadDonePressed:(UIButton *)sender {
        if (targetTextInput) {
            [targetTextInput resignFirstResponder];
        }
    self.hidden = YES;
    self.userInteractionEnabled = NO;
}

#pragma mark - text replacement routines

// Check delegate methods to see if we should change the characters in range
- (BOOL)textInput:(id <UITextInput>)textInput shouldChangeCharactersInRange:(NSRange)range withString:(NSString *)string {
    if (textInput) {
        if ([textInput isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)textInput;
            if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                if ([textField.delegate textField:textField
                    shouldChangeCharactersInRange:range
                                replacementString:string]) {
                    return YES;
                }
            } else {
                // Delegate does not respond, so default to YES
                return YES;
            }
        } else if ([textInput isKindOfClass:[UITextView class]]) {
            UITextView *textView = (UITextView *)textInput;
            if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
                if ([textView.delegate textView:textView
                        shouldChangeTextInRange:range
                                replacementText:string]) {
                    return YES;
                }
            } else {
                // Delegate does not respond, so default to YES
                return YES;
            }
        }
    }
    return NO;
}

// Replace the text of the textInput in textRange with string if the delegate approves
- (void)textInput:(id <UITextInput>)textInput replaceTextAtTextRange:(UITextRange *)textRange withString:(NSString *)string {
    if (textInput) {
        if (textRange) {
            // Calculate the NSRange for the textInput text in the UITextRange textRange:
            int startPos                    = [textInput offsetFromPosition:textInput.beginningOfDocument
                                                                 toPosition:textRange.start];
            int length                      = [textInput offsetFromPosition:textRange.start
                                                                 toPosition:textRange.end];
            NSRange selectedRange           = NSMakeRange(startPos, length);
            
            if ([self textInput:textInput shouldChangeCharactersInRange:selectedRange withString:string]) {
                // Make the replacement:
                [textInput replaceRange:textRange withText:string];
            }
        }
    }
}
// 确保当前view响应点击事件.
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    UIView *touchView = self;
    if (!self.hidden) {
        if ([self pointInside:point withEvent:event]) {
            for (UIView *subView in self.subviews) {
                //注意，这里有坐标转换，将point点转换到subview中，好好理解下
                CGPoint subPoint = CGPointMake(point.x - subView.frame.origin.x,
                                               point.y - subView.frame.origin.y);
                UIView *subTouchView = [subView hitTest:subPoint withEvent:event];
                if (subTouchView) {
                    //找到touch事件对应的view，停止遍历
                    return subTouchView;
                }
            }
        }
        
    }
    {
        return [super hitTest:point withEvent:event];
    }
//    if (!self.hidden) {
//        NSEnumerator *reverseE = [self.subviews reverseObjectEnumerator];
//        UIView *iSubView;
//        
//        while ((iSubView = [reverseE nextObject])) {
//            UIView *viewWasHit = [iSubView hitTest:[self convertPoint:point toView:iSubView] withEvent:event];
//            if(viewWasHit) {
//                return viewWasHit;
//            }
//        }
//        
//    }
//    return [super hitTest:point withEvent:event];
}

CGPoint originalLocation;   //全局变量 用于存储起始位置
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches   anyObject];
    originalLocation = [touch locationInView:self];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //计算位移=当前位置-起始位置
    CGPoint point = [[touches anyObject] locationInView:self];
    float dx = point.x - originalLocation.x;
    float dy = point.y - originalLocation.y;
    
    //计算移动后的view中心点
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    
    
    /* 限制用户不可将视图托出屏幕 */
    float halfx = CGRectGetMidX(self.bounds);
    //x坐标左边界
    newcenter.x = MAX(halfx, newcenter.x);
    //x坐标右边界
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    //y坐标同理
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    //移动view
    self.center = newcenter;
}

@end
