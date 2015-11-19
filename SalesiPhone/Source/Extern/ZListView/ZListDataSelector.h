//
//  ZListDataSelectorDelegate.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-31.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZView.h"
@protocol ZListDataSelectorDelegate <NSObject>

@optional

- (void)dateValueChanged:(NSString*)changedValue;

-(void)dateValueChangeEnd;

@end
@interface ZListDataSelector : ZView

-(void)showViewFrom:(UIView*)rootView frame:(CGRect)frame;

@property (nonatomic, assign) id<ZListDataSelectorDelegate> selectDelegate;
@property(nonatomic)NSArray* pickData;

@end
