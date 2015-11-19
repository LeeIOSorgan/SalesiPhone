//
//  ZHomeCell.m
//  zg
//
//  Created by ZTaoTech ZG on 6/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZHomeCell.h"
#import "ZDefine.h"

#define kTagBackView 1000

//还需要更新的逻辑，设置状态，这块需要和ZG确定交互细节

@interface ZHomeCell ()


@end

@implementation ZHomeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSString*)numberText{
    NSString* strText = nil;
    
    if (_numberName && _number >= 0){
        strText = [NSString stringWithFormat:_numberName, _number];
    }
    
    return strText;
}

- (void)buttonClick:(UIButton*)button{
    if (_delegate){
        [_delegate cellClick:self];
    }
}

- (void)setSelected:(BOOL)bSelect{
    UIImageView* backView = (UIImageView*)[self viewWithTag:kTagBackView];
    //backView.alpha = bSelect ? 1.0 : 0.0;
    
    _backImageName = @"SEL_home.png";
    backView.image = bSelect ? ZImage(_backImageName) : nil;
}

- (void)setupView{
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    UIImageView* backView = [[UIImageView alloc] initWithFrame:frame];
    
    [backView setImage:ZImage(_backImageName)];
    backView.tag = kTagBackView;
    [self addSubview:backView];
//    [backView release];
    
    float x = 0;
    float y = 0;
    float w = 0;
    float h = 0;
    
    w = 25;
    h = 20;
    x = 15;
    y = (self.frame.size.height - h) / 2;
    frame = ZRect(x, y, w, h);
    UIImageView* iconView = [[UIImageView alloc] initWithFrame:frame];
    [iconView setImage:ZImage(_iconName)];
    [self addSubview:iconView];
//    [iconView release];
    
    x = x + w + 15;
    y = 5 + 10;
    w = 60;
    h = 14;
    frame = ZRect(x, y, w, h);
    UILabel* labelTitle = [[UILabel alloc] initWithFrame:frame];
    labelTitle.text = _title;
    labelTitle.backgroundColor = ZClearColor;
    labelTitle.textColor = ZWhiteColor(69);
    labelTitle.font = ZFont(14);
    [self addSubview:labelTitle];
//    [labelTitle release];
    
    y = y + h + 6;
    w = 80;
    h = 12;
    frame = ZRect(x, y, w, h);
    UILabel* labelNumberName = [[UILabel alloc] initWithFrame:frame];
    
    NSString* strText = [self numberText];
    
    labelNumberName.text = strText;
    labelNumberName.backgroundColor = ZClearColor;
    labelNumberName.textColor = ZWhiteColor(69);
    labelNumberName.font = ZFont(12);
    [self addSubview:labelNumberName];
//    [labelNumberName release];
    
    y = y + h + 6;
    frame = ZRect(x, y, w, h);
    UILabel* labelComment = [[UILabel alloc] initWithFrame:frame];
    labelComment.text = _comment;
    labelComment.backgroundColor = ZClearColor;
    labelComment.textColor = ZWhiteColor(69);
    labelComment.font = ZFont(12);
    [self addSubview:labelComment];
//    [labelComment release];
    
    frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
     
}

@end
