//
//  ZColorTextView.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/6/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZColorTextView.h"

@implementation ZColorTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();

//    UIFont* font = [UIFont systemFontOfSize:14];
    
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
//    [@"ssss" drawInRect:CGRectMake(0, 0, 120, 20)
//              withFont:font
//          lineBreakMode:NSLineBreakByCharWrapping
//              alignment:NSTextAlignmentCenter];
//    [@"ssss" drawInRect:CGRectMake(0, 0, 120, 20) withAttributes:<#(NSDictionary *)#>
//    
//    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
//    [@"ssss" drawInRect:CGRectMake(120, 0, 120, 20)
//               withFont:font
//          lineBreakMode:NSLineBreakByCharWrapping
//              alignment:NSTextAlignmentCenter];

}


@end
