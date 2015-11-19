//
//  ZView.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/11/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZResponse;

@protocol ZViewDelegate <NSObject>

- (void)setupView;

@end

@protocol ZObjectOperatorDelegate <NSObject>

- (void)addDTO:(NSObject*)dto;
-(void)updateDTO:(NSObject*)dto;
-(void)deleteDTO:(NSObject*)dto;

@end

@protocol ZRightViewSelectDelegate <NSObject>

-(void)setSelectIndex:(int)subIndex;
-(void)initCurrentViewData:(NSMutableDictionary*)params;
@end

@interface ZView : UIView

- (void)setupView;
- (void)clearData;
- (void)clearView;
-(void)initData:(NSMutableDictionary*)params;
-(void)showNumPad;

-(void)hideKeyBoard:(NSMutableDictionary*)views;
-(void)showErrorResponse:(ZResponse*)errorResp;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
