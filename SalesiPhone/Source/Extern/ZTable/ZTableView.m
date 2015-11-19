//
//  ZTableView.m
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/8/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZTableView.h"
#import "EGORefreshTableHeaderView.h"
#import "ZSlideTableView.h"

@interface ZTableView ()
{
    BOOL                            _reloading;
}


@property (nonatomic ) EGORefreshTableHeaderView* headerView;

@end


//------------------------------

@implementation ZTableView

- (void)dealloc{
    if (_tableView){
        [_tableView removeFromSuperview];
//        [_tableView release];
        _tableView = nil;
    }
    
    if (_headerView){
        [_headerView removeFromSuperview];
//        [_headerView release];
        _headerView = nil;
    }
    
//    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setViewTag:(NSInteger)tag{
    self.tag = tag;
    
    self.tableView.tag = tag;
    //self.headerView.tag = tag;
}

- (void)scrollViewDidScroll{
     [_headerView egoRefreshScrollViewDidScroll:_tableView];
}
-(void)scrollToBottom:(NSIndexPath*)index{
    //[_tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [_tableView setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (void)scrollViewDidEndDragging{
    [_headerView egoRefreshScrollViewDidEndDragging:_tableView];
}

- (void)hideHeaderView{
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
}

- (void)refreshTableView{
    [_tableView reloadData];
}

- (UITableView*)tableView{
    if (_tableView == nil){
        
        CGRect frame = self.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        _tableView = [[ZSlideTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = _delegate;
        _tableView.dataSource = _delegate;
        
        _tableView.showsVerticalScrollIndicator = NO;
        //_tableView.scrollEnabled = NO;
        _tableView.slideDelegate = _delegate;
    }
    
    return _tableView;
}

- (EGORefreshTableHeaderView*)headerView{
    if (_headerView == nil) {

        float w = _tableView.frame.size.width;
        float h = _tableView.bounds.size.height;
        float x = 0;
        float y = 0.0f - h;
        //float y = 0;
        
        CGRect frame = ZRect(x, y, w, h);
        
        _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:frame];
        _headerView.delegate = _delegate;
		
        
        [_headerView refreshLastUpdatedDate];
	}
	
	//  update the last update date
	return _headerView;
}

- (void)setupView{
   // [self.tableView addSubview:self.headerView];
    [self addSubview:self.tableView];
}

@end
