//
//  ZContentView.h
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/8/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZContentView;
@class ZTableCell;

@protocol ZContentViewDelegate <NSObject>

- (int)getDataCount:(int)tagIndex;
- (void)reloadData:(int)tagIndex;

- (float)getCellHeightAtIndex:(int)tagIndex;
- (void)setupCell:(ZTableCell*)cell rowIndex:(int)rowIdx page:(int)pageIdx;
- (void)cellSelected:(int)rowIdx page:(int)pageIdx;
//- (void)quit;

//- (void)postRequest:(BOOL)nextPage;

- (void)postNextPageRequest:(int)tagIndex;
-(BOOL)ifhasMorePage;
- (void)loadMoreData;
@optional

- (float)setupHeader:(ZContentView*)contentView;

@end

////////////////////////////////////////////////////////////////////////////////////////////////

@interface ZContentView : UIView

@property (nonatomic,assign) id<ZContentViewDelegate>  zdelegate;
@property (nonatomic ) BOOL donotReDrawCell;

-(UIScrollView*)getTableContainer;
- (void)setupView;
- (void)finishLoad:(int)tagIndex;

//-(void)scrollToBottom;
@end
