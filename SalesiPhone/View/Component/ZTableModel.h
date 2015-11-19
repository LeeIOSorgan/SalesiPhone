//
//  ZTableModel.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-26.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZListTextField.h"

@interface ZTableModel : NSObject

@property(nonatomic ) CGRect frame;
@property(nonatomic ) NSString* title;
@property(nonatomic ) NSString* key;
@property(nonatomic ) NSString* actionName;
@property(nonatomic ) BOOL isReadOnly;
@property(nonatomic ) BOOL isNumber;
@property(nonatomic ) BOOL isLeft;
@property(nonatomic ) BOOL isRight;
@property(nonatomic ) SEL action;

@property(nonatomic ) BOOL inputable;
@property(nonatomic ) BOOL isButton;
@property(nonatomic ) BOOL isListView;
@property(nonatomic ) BOOL isAutoSelect;
@property(nonatomic ) BOOL isSkuView;
@property(nonatomic ) BOOL isSortAble;
@property(nonatomic ) BOOL clearOnClick;
@property(nonatomic ) BOOL isImage;

@property (nonatomic ) eListType listType;
@property(nonatomic ) BOOL isHide; //是否隐藏
@property(nonatomic ) BOOL didBegin;//
@property(nonatomic ) BOOL supportKeyboard;
@property(nonatomic ) int listenTag;
@property(nonatomic ) BOOL shouldListen;
@property(nonatomic ) int viewag;

@end
