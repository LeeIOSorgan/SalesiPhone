//
//  ZImagePickerView.h
//  eSeller4iPad
//
//  Created by neil on 9/2/13.
//  Copyright (c) 2013 yunying. All rights reserved.
//

#import "ZView.h"

@protocol ZImagePickerViewDelegate <NSObject>

- (void)imageTaked:(UIImage*)image path:(NSString*)imagePath;
- (void)cancel;

@end

/////////////

@interface ZImagePickerView : ZView

@property (nonatomic,assign ) id<ZImagePickerViewDelegate> delegate;


+ (ZImagePickerView*)instance;

- (void)presentPopoverFromRect:(CGRect)rect
                        inView:(UIView *)view
                          type:(UIImagePickerControllerSourceType)type;

@end
