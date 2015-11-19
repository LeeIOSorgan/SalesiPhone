//
//  ZImageView.m
//  zg
//
//  Created by ZTaoTech ZG on 5/31/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZImageView.h"
#import "UIImageView+WebCache.h"

typedef void(^DownloadResultBlock)(BOOL bOK);

@implementation ZImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc
{
    [self removeFromSuperview];
}

- (UIImage*)imageWithLink:(NSString*)strLink{
    NSURL* url = [NSURL URLWithString:strLink];
    NSData* data = [NSData dataWithContentsOfURL:url];
    UIImage* image = [UIImage imageWithData:data];
    return image;
}

- (void)setUrl2:(NSString*)strUrl{

    [self setImageWithURL:ZUrl(strUrl) placeholderImage:ZImage(@"")];
}

- (void)setUrl:(NSString*)strUrl{
    
    __block UIImage* image = nil;
    __block NSString* strTemp = strUrl;
    __block UIImageView* iv = self;
    
    dispatch_queue_t queue = dispatch_queue_create("downloadImage", NULL);
    
    dispatch_async(queue,
                   ^(void) {
                       image = [self imageWithLink:strTemp];
                       
                       dispatch_async(dispatch_get_main_queue(), ^(void){
                           
                           if (image){
                               iv.image = image;
                               [iv setNeedsDisplay];
//                               [image release];
                           }
                           
//                           [iv release];
                       });
                   }
                   );
    
//    dispatch_release(queue);
}

- (UIImage*)downloadImageWithUrl:(NSString*)strUrl
                          target:(UIImageView*)imageView
                        complete:(DownloadResultBlock)resultBlock{
    
    __block UIImage* image = nil;
    __block NSString* strTemp = strUrl;
    __block UIImageView* iv = imageView;
    
    dispatch_queue_t queue = dispatch_queue_create("downloadImage", NULL);
    
    dispatch_async(queue,
                   ^(void) {
                       image = [self imageWithLink:strTemp];
                       
                       dispatch_async(dispatch_get_main_queue(), ^(void){
                           
                           if (image){
                               iv.image = image;
                               [iv setNeedsDisplay];
                           }
                           
                           if (resultBlock){
                               resultBlock(image != nil);
                           }
                       });
                   }
                   );
    
//    dispatch_release(queue);
    
    return image;
}


@end
