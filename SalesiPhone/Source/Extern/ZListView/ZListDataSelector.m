//
//  ZDateSelector.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-31.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZListDataSelector.h"
@interface ZListDataSelector ()<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView* _datePicker;
//    UIView* backView;
}

@end

@implementation ZListDataSelector

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
    _datePicker = [[UIPickerView alloc] init];
    _datePicker.delegate = self;
    [_datePicker setBackgroundColor:ZWhiteColor(255)];
    _datePicker.showsSelectionIndicator = YES;
}

-(void)showViewFrom:(UIView*)rootView frame:(CGRect)frame
{
//    float x = rootView.frame.origin.x +rootView.frame.size.width;
//    float y = rootView.frame.origin.y; //+ rootView.frame.size.height;
    //        CGRect backFrame = CGRectMake(0,0,1024, 768);
//    CGRect frame = CGRectMake(300   , 300, 300, 220);
    UIView* backView = [[UIView alloc]initWithFrame:frame];
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [_datePicker setFrame:frame];
//    backView.backgroundColor = [UIColor redColor];
    backView.tag = 3001;
    [backView addSubview:_datePicker];
    
    [self addSubview:backView];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view.tag !=3001)
    {
        self.hidden = YES;
        if (_selectDelegate)
        {
            [_selectDelegate dateValueChangeEnd];
        }
    }

}
#pragma mark -
#pragma mark Picker Date Source Methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_selectDelegate)
    {
        [_selectDelegate dateValueChanged:[_pickData objectAtIndex:row]];
    }
}
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickData count];
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_pickData objectAtIndex:row];
}
@end
