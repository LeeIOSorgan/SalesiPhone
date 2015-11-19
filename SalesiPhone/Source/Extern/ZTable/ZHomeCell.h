//
//  ZHomeCell.h
//  zg
//
//  Created by ZTaoTech ZG on 6/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHomeCell;
@protocol ZHomeCellDelegate <NSObject>

- (void)cellClick:(ZHomeCell*)cell;

@end

@interface ZHomeCell : UIView

@property (nonatomic, copy) NSString* backImageName;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* iconName;
@property (nonatomic, copy) NSString* numberName;
@property (nonatomic ) int     number;
@property (nonatomic, copy) NSString* comment;

@property (nonatomic,assign) id<ZHomeCellDelegate> delegate;

- (void)setupView;
- (void)setSelected:(BOOL)bSelect;

@end
