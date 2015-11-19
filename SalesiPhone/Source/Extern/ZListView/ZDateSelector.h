//
//  ZDateSelector.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-31.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZView.h"
@protocol ZDateSelectorDelegate <NSObject>

@optional

- (void)dateValueChanged:(NSString*)changedValue;

-(void)dateValueChangeEnd;

@end
@interface ZDateSelector : ZView

-(void)showViewFrom:(UIView*)rootView;

@property (nonatomic, assign) id<ZDateSelectorDelegate> selectDelegate;

@end
