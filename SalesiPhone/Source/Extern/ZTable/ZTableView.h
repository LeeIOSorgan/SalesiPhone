//
//  ZTableView.h
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/8/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "ZSlideTableView.h"


@interface ZTableView : UIView

@property (nonatomic,assign ) id<UITableViewDataSource,
                                UITableViewDelegate,
                                EGORefreshTableHeaderDelegate, ZSlideTableViewDelegate> delegate;

@property (nonatomic ) ZSlideTableView* tableView;
- (void)setViewTag:(NSInteger)tag;

- (void)setupView;

- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDragging;
-(void)scrollToBottom:(NSIndexPath*)index;

- (void)hideHeaderView;
- (void)refreshTableView;

@end
