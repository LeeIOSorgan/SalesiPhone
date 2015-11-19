//
//  ZTableCell.m
//  zg
//
//  Created by ZTaoTech ZG on 5/31/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZTableCell.h"
//#import "ZImageView.h"
#import "ZDefine.h"

@implementation ZTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //[self setupView];
    }
    return self;
}

-(void)dealloc
{
//    ZLogInfo(@"---Into----ZTableCell--dealloc-");
    for(UIView *vv in self.subviews)
    {
        [vv removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupView:(NSString*)text{
    
//    float x = 0;
//    float y = 0;
//    float w = 0;
//    float h = 0;
//    CGRect frame;
//    
//    w = h = 60;
//    x = 10;
//    y = 10;
//    frame = ZRect(x, y, w, h);
//    ZImageView* zv = [[ZImageView alloc] initWithFrame:frame];
//    [zv setUrl:@"http://ts4.mm.bing.net/th?id=H.4854804378944243&pid=1.7"];
//    [self addSubview:zv];
//    [zv release];
//    
//    x = x + w + 10;
//    w = 200;
//    h = 36;
//    frame = ZRect(x, y, w, h);
//    UILabel* title = [[UILabel alloc] initWithFrame:frame];
//    title.text = text;//@"iPhone 5 最新最好白色彩色七色光测试数据测试测试测试123232232223322232332";
//    title.backgroundColor = ZClearColor;
//    title.textColor = ZColor(200, 0, 0);
//    [self addSubview:title];
//    [title release];
    
    //价格
    
    //库存
    
    //本月售出量
    
    
}






@end
