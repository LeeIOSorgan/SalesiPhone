//
//  ZCell.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-5.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZCell.h"
#import "ZImageView.h"
#import "ZDefine.h"
#import "ZTableModel.h"
#import "ZListTextField.h"
//#import "ZSkuPropertyTextView.h"
#import "ZDataCache.h"

@interface ZCell()<UITextFieldDelegate, ZListTextFieldDelegate>
{
    NSMutableDictionary* _cellViews;
    NSMutableArray* _models;
    NSMutableDictionary *inputs;
}
@end

@implementation ZCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ZColor(0, 162, 232);
        _cellViews = [[NSMutableDictionary alloc]init];
    }
    [self removeFromSuperview];
    return self;
}
-(void)dealloc
{
//     ZLogInfo(@"---Into----ZCell--dealloc-");
    for(UIView *vv in self.subviews)
    {
        [vv removeFromSuperview];
    }
    [self removeFromSuperview];
    _cellViews = nil;
    inputs = nil;
    _cellDelegate = nil;
    _models = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    BOOL support = [[ZDataCache sharedInstance]getIfUsePinYinInput];
    //使用系统键盘
    if(support) {
        if (_cellDelegate)
        {
            [_cellDelegate keyboardShow:textField isShow:YES];
        }
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    BOOL support = [[ZDataCache sharedInstance]getIfUsePinYinInput];
    //使用系统键盘
    if(support) {
        if (_cellDelegate)
        {
            [_cellDelegate keyboardShow:textField isShow:NO];
        }
    }
//
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    //price 或者是count
//    NSString *newString = nil;
//    if (range.length == 0) {
//        newString = [textField.text stringByAppendingString:string];
//    } else {
//        NSString *headPart = [textField.text substringToIndex:range.location];
//        NSString *tailPart = [textField.text substringFromIndex:range.location+range.length];
//        newString = [NSString stringWithFormat:@"%@%@",headPart,tailPart];
//    }
//    return YES;
//}

-(void)bindDTO:(NSObject*)dto count:(int)sequence
{
    
}
-(void)initData
{
    
}
-(NSMutableArray*)getTableModels {
    return nil;
}

- (void)setupContentView
{
    if(_models != nil) {
        [self setupContentViewWithModel:_models];
    } else {
        [self setupContentViewWithModel:[self getTableModels]];
    }
}

- (void)setupTitleView
{
    if(_models != nil) {
        [self setupTitleViewWithModel:_models];
    } else {
        [self setupTitleViewWithModel:[self getTableModels]];
    }
}
-(void)setIdDTO:(ZListTextField*)textField
{
    
}
-(NSMutableDictionary*)getLabelViews {
    return _cellViews;
}

-(NSMutableDictionary*)getInputStrings {
    inputs = [[NSMutableDictionary alloc]init];
    NSEnumerator * enumKey = [_cellViews keyEnumerator];
    for(NSString* key in enumKey) {
        UIView* view = [_cellViews objectForKey:key];
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField* textView = (UITextField*)view;
//            ZLogInfo(@"---Key %@ ----value %@", key, textView.text);
            if([textView.text length] > 0) {
                [inputs setValue:textView.text forKey:key];
            } else {
                [inputs setValue:@"" forKey:key];
            }
        } else if ([view isKindOfClass:[ZListTextField class]]) {
            ZListTextField* textView = (ZListTextField*)view;
//            ZLogInfo(@"---Key %@ ----value %@", key, textView.text);
            if([textView.text length] >0) {
                [inputs setValue:textView.text forKey:key];
            } else {
                [inputs setValue:@"" forKey:key];
            }
        } else if ([view isKindOfClass:[UILabel class]]) {
            //主要是位隐藏的item属性准备
            UILabel* textView = (UILabel*)view;
//            ZLogInfo(@"---Key %@ ----value %@", key, textView.text);
            if([textView.text length] > 0) {
                [inputs setValue:textView.text forKey:key];
            } else {
                [inputs setValue:@"" forKey:key];
            }
        }
    }
    return inputs;
}

- (void)setupTitleViewWithModel:(NSArray*)items
{
    for (ZTableModel* model in items) {
        if (model.isHide) {
            continue;
        }
        CGRect frame = model.frame;
        if(model.isSortAble) {
            UIButton *labelId = [[UIButton alloc] initWithFrame:frame];
            [labelId setTitle:model.title forState:UIControlStateNormal];
            [labelId setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [labelId setBackgroundColor:self.backgroundColor];
            [labelId addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:labelId];

        } else {
            
            UILabel *labelId = [[UILabel alloc] initWithFrame:frame];
            labelId.text = model.title;
            labelId.backgroundColor = self.backgroundColor;
            labelId.textAlignment = NSTextAlignmentCenter;
            [self addSubview:labelId];
        }
//
    }
}
-(void)sort:(UIButton*)btn
{
    if(_sortFieldDelegate) {
        [_sortFieldDelegate sortItem:btn.titleLabel.text];
    }
}

-(void)setupContentViewWithModel:(NSArray*)items {
//    UIColor* bgColor = self.backgroundColor;
    for (ZTableModel* model in items) {
        if (model.inputable) {
            UITextField *labelId = [[UITextField alloc] initWithFrame:model.frame];
            labelId.borderStyle = UITextBorderStyleRoundedRect;
            labelId.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            labelId.autocorrectionType = UITextAutocorrectionTypeNo;
            //再次编辑就清空
//            labelId.clearsOnBeginEditing = YES;
//            labelId.backgroundColor = bgColor;
            if(model.isNumber) {
//                labelId.inputView = [LNNumberpad defaultLNNumberpad];
                labelId.inputView = [[UIView alloc]initWithFrame:CGRectZero];
                labelId.clearButtonMode = UITextFieldViewModeNever;
            }
            if(model.isReadOnly) {
                labelId.enabled = NO;
            }
            labelId.delegate = self;
            if (model.key) {
                [_cellViews setValue:labelId forKey:model.key];
            }
            if(model.listenTag > 0) {
                labelId.delegate = self;
                labelId.tag = model.listenTag;
                _caluteTag = model.listenTag;
            }
            if(model.clearOnClick) {
                labelId.clearsOnBeginEditing = YES;
            }
            if (model.isHide) {
                labelId.hidden = YES;
            }
            [self addSubview:labelId];
//             
        } else if(model.isButton){
            UIButton* buttonOpration = [[UIButton alloc] initWithFrame:model.frame];
            [buttonOpration setTitle:model.actionName forState:UIControlStateNormal];
            [buttonOpration setTitleColor:ZColor(255, 0, 0) forState:UIControlStateNormal];
            buttonOpration.backgroundColor = [UIColor clearColor];
            [buttonOpration addTarget:self action:model.action forControlEvents:UIControlEventTouchUpInside];
            if(model.key) {
                [_cellViews setValue:buttonOpration forKey:model.key];
            }
            [self addSubview:buttonOpration];
//            [buttonOpration release];
        } else if(model.isListView) {
            
            ZListTextField* listView = [[ZListTextField alloc] initWithFrame:model.frame];
            listView.listType = model.listType;
            if(model.isAutoSelect) {
                listView.autoSelectLast = YES;
            }
            listView.didBegin = model.didBegin;
            if(model.isNumber) {
//                [listView setInputView:[LNNumberpad defaultLNNumberpad]];
                listView.numPad = YES;
                listView.inputView = [[UIView alloc]initWithFrame:CGRectZero];
                listView.clearButtonMode = UITextFieldViewModeNever;
            }
            if(model.didBegin && !model.supportKeyboard){
                listView.inputView = [[UIView alloc]initWithFrame:CGRectZero];
            }
            if (model.key) {
                [_cellViews setValue:listView forKey:model.key];
            }
            if(model.isReadOnly) {
                listView.enabled = NO;
            }
            listView.listDelegate  = self;
            if(model.listenTag >0) {
                listView.tag = model.listenTag;
                _caluteTag = model.listenTag;
            }
            if (model.isHide) {
                listView.hidden = YES;
            }
            listView.delegate = self;
            [self addSubview:listView];
//            [listView release];
            
        } else if (model.isSkuView){
            //TODO:
//            ZSkuPropertyTextView* view = [[ZSkuPropertyTextView alloc]initWithFrame:model.frame];
//            if (model.key) {
//                [_cellViews setValue:view forKey:model.key];
//            }
//            if(model.isReadOnly) {
//                view.enabled = NO;
//            }
//            view.listDelegate = self;
//            [self addSubview:view];
        } else if(model.isImage) {
            ZImageView* image = [[ZImageView alloc] initWithFrame:model.frame];
            [image setUrl:@"http://wenwen.sogou.com/p/20100811/20100811104042-721935416.jpg"];
            image.contentMode = UIViewContentModeScaleAspectFit;
            
            if (model.key) {
                [_cellViews setValue:image forKey:model.key];
            }
            [self addSubview:image];
        } else {
            UILabel* labelId = [[UILabel alloc] initWithFrame:model.frame];
            if(model.isHide) {
                labelId.hidden = YES;
            }
            if(model.isReadOnly) {
                labelId.enabled = NO;
            }
            labelId.text = @"";
            labelId.backgroundColor = [UIColor clearColor];
            labelId.textAlignment = NSTextAlignmentCenter;
            if (model.isLeft) {
                labelId.textAlignment = NSTextAlignmentLeft;
            } else if(model.isRight) {
                labelId.textAlignment = NSTextAlignmentRight;
            }
            if(model.key) {
                [_cellViews setValue:labelId forKey:model.key];
            }
            [self addSubview:labelId];
//             
        }
    }
    [self initData];
}
@end
