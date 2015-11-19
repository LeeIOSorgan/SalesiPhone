//
//  ZImagesView.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-3-16.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "ZImageScrollView.h"
#import "UIImageView+WebCache.h"
#import "ZUtility.h"
#import "ZImageView.h"
#import "ZItemImageDTO.h"
#import "ZRequestInc.h"
#import "ZFileService.h"
#import "ZDataCache.h"

@interface ZImageScrollView ()<SDWebImageManagerDelegate>
{
    NSMutableDictionary* _images;
    CGRect _frame;
    NSMutableArray* _urls;
    NSNumber* _itemId;
}
@end

@implementation ZImageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _images = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)dealloc
{
    _images = nil;
    [self removeFromSuperview];
}

-(void)setupView
{

}

-(void)initWithImageURLs:(NSArray*)url itemId:(NSNumber*)itemId
{
//    url = [NSArray arrayWithObjects:
//                @"http://42.121.126.152:9080/resources/rs/graphics/show?id=527b89590cf27cae186fa72b",
//                @"http://e.hiphotos.bdimg.com/album/w%3D2048/sign=55dca5fedc54564ee565e33987e69e82/738b4710b912c8fcdf466f20fd039245d78821a1.jpg",
//                @"http://www.docaline.com/upload/uploadfiles/hao.jpg",
//                @"http://wenwen.sogou.com/p/20100811/20100811104042-721935416.jpg",nil];
    [self clearImageView];
    _itemId = itemId;
    _urls =  [[NSMutableArray alloc]initWithArray:url];
    float width = 400;
    _frame = CGRectMake(0, 0, 0, 420);
    for(int i =0;i<[_urls count];i++) {
        
        NSString* itemPicId = [_urls objectAtIndex:i];
        if(itemPicId.length <5) {//肯定不会小于5.
            continue;
        }
        _frame = [ZUtility getCGRect:_frame widt:width dis:10 topdis:4];
        UIView* imageView = [[UIView alloc]initWithFrame:_frame];
        
        NSString* itemImage = [NSString stringWithFormat:@"%@%@", [[ZDataCache sharedInstance] getUrlPrefix], itemPicId];
        
        CGRect frame = CGRectMake(0, 0, 400, 360);
        ZImageView* image = [[ZImageView alloc] initWithFrame:frame];
        [image setUrl:itemImage];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [imageView addSubview:image];
        CGRect btnFrame = CGRectMake(50, frame.origin.y +frame.size.height+10, 60, 30);
        UIButton* delBtn = [[UIButton alloc]initWithFrame:btnFrame];
        [delBtn setTitle:@"删除" forState:UIControlStateNormal];
        [delBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [delBtn setBackgroundColor:ZWhiteColor(240)];
        delBtn.tag = 1200 + i;
        [delBtn addTarget:self action:@selector(removeImage:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:delBtn];
        
        [self addSubview:imageView];
        [_images setObject:imageView forKey:itemImage];
    }
}

-(NSString*)getUrlString
{

    NSMutableString* nms = [[NSMutableString alloc]init];
//    NSEnumerator* urls =  _images.keyEnumerator;
//    for(NSString* url in urls) {
//        [nms appendString:url];
//    }
    return nms;
}

-(void)clearImageView
{
    if(_images) {
        NSArray* key = [_images allKeys];
        for(int i=0;i<key.count;i++ ) {
            UIView* view = [_images valueForKey:key[i]];
            [view removeFromSuperview];
        }
    }
}

-(void)removeImage:(UIButton*)btn
{
    int tag = btn.tag;
    int index = tag - 1200;
    if(index > [_urls count]) {
        return ;
    }
    NSString* url = [_urls objectAtIndex:index];
    ZImageView* image = [_images objectForKey:url];
    
    ZFileService* fileService = [[ZServiceFactory sharedService]getFileService];
    [fileService deleteImage:_itemId imageId:url type:_delegateView];
    
    image.hidden = YES;
    [image removeFromSuperview];
    [_images removeObjectForKey:url];
    NSArray* key = [_images allKeys];
    for(int i=0;i<key.count;i++ ) {
        UIView* view = [_images valueForKey:key[i]];
        [view removeFromSuperview];
    }
    [self initWithImageURLs:[_images allKeys] itemId:_itemId];
    
}

-(void)addImage:(NSString*)url
{
    float width = 400;
    _frame = [ZUtility getCGRect:_frame widt:width dis:10 topdis:4];
    UIView* imageView = [[UIView alloc]initWithFrame:_frame];
    
    CGRect frame = CGRectMake(0, 0, 400, 360);
    ZImageView* image = [[ZImageView alloc] initWithFrame:frame];
    [image setUrl:url];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [imageView addSubview:image];
    CGRect btnFrame = CGRectMake(0, frame.origin.y +frame.size.height+10, 60, 30);
    UIButton* delBtn = [[UIButton alloc]initWithFrame:btnFrame];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delBtn setBackgroundColor:ZWhiteColor(240)];
    delBtn.tag = 1200 + [_images count];
    [delBtn addTarget:self action:@selector(removeImage:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:delBtn];
    
    [self addSubview:imageView];
    [_images setObject:imageView forKey:url];
}

//-(void)addImage:(UIImage*)image
//{
//    float width = 400;
//    _frame = [ZUtility getCGRect:_frame widt:width dis:10 topdis:4];
//    ZImageView* imageView = [[ZImageView alloc] initWithFrame:_frame];
//    [imageView setUrl:url];
//    [_images setObject:imageView forKey:url];
//    [self addSubview:imageView];
//}

//-(void)removeImage:(NSString*)url
//{
//    [_images removeObjectForKey:url];
//}


/*
 界面传递 urlkey， 和imageview对象，当图片下载完成时，更新到imageview，
 这个地方要传入单个的值，界面上得scrollview上有多个Imageview，
 图片下载成功后，把key和value移除。
 */


@end
