//
//  SPUIUtils.m
//  SalesiPhone
//
//  Created by Leejun on 15/11/12.
//  Copyright © 2015年 Leejun. All rights reserved.
//

#import "SPUIUtils.h"

@implementation SPUIUtils

#pragma mark -- adapter ios 7
+(BOOL)updateFrameWithView:(UIView *)view superView:(UIView *)superView isAddHeight:(BOOL)isAddHeight
{
    return [self updateFrameWithView:view superView:superView isAddHeight:isAddHeight delHeight:STAUTTAR_DEFAULT_HEIGHT];
}

+(BOOL)updateFrameWithView:(UIView *)view superView:(UIView *)superView isAddHeight:(BOOL)isAddHeight delHeight:(CGFloat)height
{
    CGRect viewFrame = view.frame;
    if (isAddHeight) {
        viewFrame.size.height += height;
    }else{
        //view是相对super和底部的就不改位置
        UIViewAutoresizing resizeMask = view.autoresizingMask;
        if (resizeMask & UIViewAutoresizingFlexibleTopMargin) {
            return YES;
        }
        
        //如果tableview的大小与parent大小是一样的话就不移
        if (view.frame.size.height >= superView.frame.size.height) {
            return NO;
        }
        
        //如果view是跟scrollview并从parent的顶开始的也不移
        if (view.frame.origin.y <= 0 && [view isKindOfClass:[UIScrollView class]]) {
            return NO;
        }
    }
    view.frame = viewFrame;
    
    return YES;
}

+ (UIFont*)customFontWithFontName:(NSString*)fontName size:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:fontName size:size];//HiraginoSansGB-W3
    return font;
}

@end
