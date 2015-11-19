//
//  ZDateSelector.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-31.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDateSelector.h"
@interface ZDateSelector ()<UITextFieldDelegate>
{
    UIDatePicker* _datePicker;
//    UIView* backView;
}

@end

@implementation ZDateSelector

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        backView = [[UIView alloc]initWithFrame:frame];
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setupView
{
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setTimeZone:[NSTimeZone defaultTimeZone]];//timeZoneWithName:@"GMT"]];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        [_datePicker setBackgroundColor:ZWhiteColor(255)];
        
    }
    
    [_datePicker setDate:[NSDate date] animated:YES];
    NSTimeInterval oneDaySec = 24*60*60;
    NSDate *oneDay = [NSDate dateWithTimeInterval:oneDaySec sinceDate:[NSDate date]];
    
    [_datePicker setMaximumDate:oneDay];
    [_datePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)showViewFrom:(UIView*)rootView
{
    float x = rootView.frame.origin.x;
    float y = rootView.frame.origin.y + rootView.frame.size.height;
    //        CGRect backFrame = CGRectMake(0,0,1024, 768);
    CGRect frame = CGRectMake(x, y, 360, 220);
    UIView* backView = [[UIView alloc]initWithFrame:frame];
    frame = CGRectMake(0, 0, 360, 220);
    [_datePicker setFrame:frame];
//    backView.backgroundColor = [UIColor redColor];
    backView.tag = 2000;
    [backView addSubview:_datePicker];
    
    [self addSubview:backView];
}

- (void)dateValueChanged:(UIDatePicker*)start
{
    NSDate* date = [start date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString* text = [dateFormatter stringFromDate:date];
//    self.text = text;
    if (_selectDelegate)
    {
        [_selectDelegate dateValueChanged:text];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view.tag !=2000)
    {
        self.hidden = YES;
        if (_selectDelegate)
        {
            [_selectDelegate dateValueChangeEnd];
        }
    }

}

@end
