//
//  ZBannerView.m
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/5/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZBannerView.h"
#import "ZImageView.h"

#import "PagePhotosDataSource.h"
#import "PagePhotosView.h"

#define kTagScrollView   1000
#define kTagPageControl  1001

@interface ZBannerView ()<PagePhotosDataSource>
{
    NSArray*  _imageUrlArray;
}

@end

@implementation ZBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -
#pragma mark PagePhotosDataSource

- (int)numberOfPages{
    return [_imageUrlArray count];
}

- (NSString*)imageUrlAtIndex:(int)index{
    return [_imageUrlArray objectAtIndex:index];
}

- (void)setupView:(NSArray*)urlArray{
    
    _imageUrlArray = [[NSArray alloc] initWithArray:urlArray];
    
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    
    PagePhotosView *pagePhotosView = [[PagePhotosView alloc] initWithFrame:frame
                                                            withDataSource:self];
	[self addSubview:pagePhotosView];
//    [pagePhotosView release];
}

@end
