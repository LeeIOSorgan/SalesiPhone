//
//  ZImagesView.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-3-16.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ZItemImageDTO;
@interface ZImageScrollView : UIScrollView


@property(nonatomic)UIView* delegateView;

-(void)initWithImageURLs:(NSArray*)urls itemId:(NSNumber*)itemId;
-(void)addImage:(NSString*)url;
-(NSString*)getUrlString;

@end
