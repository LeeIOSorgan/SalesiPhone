//
//  ZCell.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-5.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZCellInputDelegate <NSObject>

- (void)keyboardShow:(UITextField*)tf isShow:(BOOL)bShow;

@end
@protocol ZSortFieldDelegate <NSObject>

- (void)sortItem:(NSString*)fieldName;

@end


@class ZListTextField;

@interface ZCell : UIView
@property (nonatomic ) int caluteTag;
@property (nonatomic,assign ) id<ZCellInputDelegate> cellDelegate;
@property (nonatomic,assign ) id<ZSortFieldDelegate> sortFieldDelegate;

- (void)setupContentView;
- (void)setupTitleView;

-(void)bindDTO:(NSObject*)dto count:(int)sequence;
- (void)setupTitleViewWithModel:(NSArray*)items;
-(void)setupContentViewWithModel:(NSArray*)items;
-(NSMutableDictionary*)getInputStrings;
-(NSMutableDictionary*)getLabelViews;
- (void)textFieldDidEndEditing:(UITextField *)textField;
-(void)textFieldDidBeginEditing:(UITextField *)textField;


//-(void)caclute:(NSString*)string;
-(void)setIdDTO:(ZListTextField*)textField;

@end
