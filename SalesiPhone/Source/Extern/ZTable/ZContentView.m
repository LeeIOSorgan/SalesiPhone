//
//  ZContentView.m
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/8/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZContentView.h"
#import "ZTableView.h"


#import "ZTableCell.h"
#import "ZCell.h"

#import "ZSlideTableView.h"

#import "ZUtility.h"

#define kTagStart 1000

#define kTagTable1 4101
#define kTagTable2 4102
#define kTagTable3 4103

#define kTagScroll 4002

#define tableHeaderHeight 44

@interface ZContentView ()<UIScrollViewDelegate,
                            UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate, ZSlideTableViewDelegate>
{
    CGPoint _startPoint;
     ZTableView*       _currentTable;
    NSMutableArray*   _tableArray;
}

//@property (nonatomic) ZTableView*       currentTable;
//@property (nonatomic, strong) NSMutableArray*   tableArray;

@end

/////////////////////////////////////////

@implementation ZContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
    }
    return self;
}

-(void)dealloc
{
    ZLogInfo(@"---Into---ZContentView---dealloc-");
    _tableArray = nil;
    _zdelegate = nil;
    _currentTable = nil;
}

#pragma mark -
#pragma mark ZSlideTableViewDelegate

- (void)tableViewSlide:(ZSlideTableView *)tableView offset:(float)offset{
    
    int idx = 0;
    if (offset > 0){
        idx -= 1;
    }else{
        idx += 1;
    }
    
    if (idx >= 0 && idx <= 1 - 1){
        [self showTableView:idx];
    }
    else if (idx < 0){
//        [_zdelegate quit];
    }
}

- (void)showTableView:(int)index{
    UIScrollView* sv = (UIScrollView*)[self viewWithTag:kTagScroll];
    if (sv){
        float w = sv.frame.size.width;
        float h = sv.frame.size.height;
        float x = index * w;
        float y = 0;
        
        CGRect frame = ZRect(x, y, w, h);
        [sv scrollRectToVisible:frame animated:YES];
    }
}

-(UITableView*)getTableContainer {
//    UIScrollView* sv = (UIScrollView*)[self viewWithTag:kTagScroll];
    return _currentTable.tableView;
}

- (NSMutableArray*)tableArray{
    if (_tableArray == nil){
        _tableArray = [[NSMutableArray alloc] init];
    }
    
    return _tableArray;
}

- (void)setupTableView{
    
    float hTool = 0;
    
    if (_zdelegate)
    {
        hTool = [_zdelegate setupHeader:self];
    }
    
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = hTool;
    frame.size.height = self.frame.size.height - hTool;
    frame.size.width = self.frame.size.width;
        
    _currentTable = [[ZTableView alloc] initWithFrame:frame];
    
    _currentTable.delegate = self;
    [_currentTable setViewTag:(kTagStart + 0)];
    
    [_currentTable setupView];
    [self addSubview:_currentTable];
//    [_currentTable release];
}

- (void)finishLoad:(int)tagIndex{
    
    //kTagStart + i
//    UIView* sv = [self viewWithTag:kTagScroll];
    
//    ZTableView* zv = (ZTableView*)[sv viewWithTag:(kTagStart + tagIndex)];
    if (_currentTable){
        [_currentTable hideHeaderView];
        [_currentTable refreshTableView];
    }
}

- (void)setupView{

    [self setupTableView];
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    [_currentTable addGestureRecognizer:tap];
    //    [_contentView release];


}
//-(void)tap:(UITapGestureRecognizer*)tag
//{
//    [_currentTable becomeFirstResponder];
//    [_currentTable resignFirstResponder];
//}

//- (void)setupLoadingView:(UIView*)backView
//{
//    UIActivityIndicatorView* av = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    
//    float w = 20;
//    float h = 20;
//    float x = (backView.frame.size.width - w) / 2;
//    float y = (backView.frame.size.height - h) / 2;
//    av.frame = ZRect(x, y, w, h);
//    [av startAnimating];
//    [backView addSubview:av];
//}

#pragma mark -
#pragma mark  ZCellInput Delegate
- (void)keyboardShow:(UITextField*)tf isShow:(BOOL)bShow
{
    CGRect rect = tf.frame;
    CGRect frame =  [tf convertRect:rect toView:self];
    
    static float dis = 0;
    
    if (bShow)
    {
        CGSize size = CGSizeMake(frame.size.width, frame.size.height + 320 + 10);
        [[self getTableContainer] setContentSize:size];
        //        [self setContentSize:size];
        
        float distance = 0;
        float currentY = frame.origin.y + frame.size.height;
        distance = currentY - 320 - 10;
        
        if (distance > 0)
        {
            dis = distance;
            CGPoint pt = CGPointMake(0, distance);
            [[self getTableContainer] setContentOffset:pt animated:YES];
            //            [self setContentOffset:pt animated:YES];
        }
        
    }
    else
    {
        CGPoint pt = CGPointMake(0, 0);
        [[self getTableContainer] setContentOffset:pt animated:YES];
        //        [self setContentOffset:pt animated:YES];
    }
}
//------------------------------------------------------------------------
#pragma mark -
#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = 0;
    
    count = [_zdelegate getDataCount:self.tag];
    if([_zdelegate ifhasMorePage]) {
        return count +1;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float height = 0;
    int idx = [indexPath row];
    if (idx == [_zdelegate getDataCount:self.tag]){
        height = tableHeaderHeight;
    }
    else{
        height = [_zdelegate getCellHeightAtIndex:idx];
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ZTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ZTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    float w = tableView.frame.size.width;
    float h = [_zdelegate getCellHeightAtIndex:[indexPath row]];
    CGRect frame = ZRect(0, 0, w, h);
    cell.frame = frame;
    int rowIdx = [indexPath row];
    {
//        if(_donotReDrawCell) {
//            for(UIView* view in cell.subviews) {
//                if ([view isKindOfClass:[ZCell class]]) {
//                    return cell;
//                }
//            }
//            //在第一次，需要绘出界面
//            [_zdelegate setupCell:cell rowIndex:[indexPath row] page:(tableView.tag - kTagStart)];
//        } else {
//        }
        [_zdelegate setupCell:cell rowIndex:[indexPath row] page:(tableView.tag - kTagStart)];
    }
    
    if (rowIdx == [_zdelegate getDataCount:self.tag])
    {
        //在NumberofRowSection方法中，已经判断过是否有更多数据，并加1， 所以这里的比较就是针对“加载更多”这个cell的处理。
        if ([_zdelegate ifhasMorePage]) {
            [self loadMoreCell:cell];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}



- (void)loadNextPage:(UIButton*)button
{
    [_zdelegate loadMoreData];
}

- (void)loadMoreCell:(ZTableCell*)cell
{
     if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
     {
     }
    for(UIView* view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGRect frame1 = cell.frame;
    UIView* btnView = [[UIView alloc]initWithFrame:frame1];
    UIButton* button = [[UIButton alloc] initWithFrame:frame1];
    [button setTitle:@"加载更多" forState:UIControlStateNormal];
    [button setBackgroundColor:ZColor(217, 224, 227)];
    [button setTitleColor:ZColor(0, 0, 0) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadNextPage:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnView addSubview:button];
    [cell.contentView addSubview:button];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if ([indexPath row] == [_zdelegate getDataCount:self.tag])
    //{
    //    ZLogInfo(@"-------------------Post Next page----");
        //[_zdelegate postNextPageRequest:tableView.tag];
    //}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLogInfo(@"didSelectRowAtIndexPath----------");
    
    UIView* view = [UIApplication sharedApplication].keyWindow;
    [ZUtility endEdit:view];
    
    [_zdelegate cellSelected:[indexPath row] page:(tableView.tag - kTagStart)];
}

//------------------------------------------------------------------------
#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//	if (scrollView && [scrollView isKindOfClass:[UITableView class]])
//    {
//        ZLogInfo(@"   scrollViewDidScroll--1--  ");
//        if (scrollView.contentOffset.y < 0) {
//            [scrollView setContentOffset:CGPointMake(0, 0)];
//            scrollView.bounces = NO;
//        }
//        else if (scrollView.contentOffset.y == 0){
//            scrollView.bounces = YES;
//        }
//        else {
//            scrollView.bounces = YES;
//        }
//        ZLogInfo(@"   scrollViewDidScroll--1-- 2 ");
//        ZTableView* zv = (ZTableView*)scrollView.superview;
//        if(zv){
//            [zv scrollViewDidScroll];
//        }
//    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    if ([scrollView isKindOfClass:[UITableView class]])
    {
        scrollView.bounces = YES;
        
        ZTableView* zv = (ZTableView*)scrollView.superview;
        [zv scrollViewDidEndDragging];
         ZLogInfo(@"EndDragging, Offset.y = %f", scrollView.contentOffset.y);
        float offsety =  (scrollView.contentOffset.y +scrollView.frame.size.height) - scrollView.contentSize.height;
        if (_zdelegate && offsety > 70)
        {
            if([_zdelegate ifhasMorePage]){
                [_zdelegate postNextPageRequest:0];
                ZLogInfo(@"_zdelegate postNextPageRequest %f" ,offsety);
            }
        }
        
    }else{
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

        float offsetX = scrollView.contentOffset.x;
        ZLogInfo(@"EndDragging, page = %d, Offset.x = %f", page, offsetX);
    }
}

-(void)scrollToBottom
{
    int last = [_zdelegate getDataCount:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:last-1 inSection:0];
//    [zv :indexPath];
    [_currentTable scrollToBottom:indexPath];
}

//-------------------------------------header view callback-----------------------------------
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	//[self reloadTableViewDataSource];
	[_zdelegate reloadData:(view.tag - kTagStart)];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	//return _reloading; // should return if data source model is reloading
	return NO;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


@end
