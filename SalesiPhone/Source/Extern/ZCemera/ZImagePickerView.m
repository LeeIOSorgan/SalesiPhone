//
//  ZImagePickerView.m
//  eSeller4iPad
//
//  Created by neil on 9/2/13.
//  Copyright (c) 2013 yunying. All rights reserved.
//

#import "ZImagePickerView.h"
#import "ZDefine.h"

@interface ZImagePickerView ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    
    UIPopoverController* _popover;
    // CameraImageHelper*  _cemera;
    
    UIImagePickerController* _picker;
}

@end

@implementation ZImagePickerView

+ (ZImagePickerView*)instance{
    static ZImagePickerView* instance = nil;
    if (instance == nil){
        instance = [[ZImagePickerView alloc] init];
    }
    
    return instance;
}

- (void)dealloc{
    
    _delegate = nil;
    
    if (_picker){
//        [_picker release];
        _picker = nil;
    }
    
    if (_popover){
//        [_popover release];
        _popover = nil;
    }
    
//    [super dealloc];
}

- (void)presentPopoverFromRect:(CGRect)rect
                        inView:(UIView *)view
                          type:(UIImagePickerControllerSourceType)type
{
    UIImagePickerControllerSourceType sourceType = type;
    
    if (_picker == nil)
    {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.allowsEditing = NO;
    }

    _picker.sourceType = sourceType;
    
    if (_popover == nil)
    {
        _popover = [[UIPopoverController alloc]initWithContentViewController:_picker];
    }
    if(sourceType == UIImagePickerControllerSourceTypeCamera && (UIDeviceOrientationIsLandscape([[UIDevice currentDevice]orientation]))) {
        _picker.cameraViewTransform = CGAffineTransformMakeRotation(-M_PI/2);
    }

    [_popover presentPopoverFromRect:rect inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setupView
{
    
}

- (NSString*)makeName{
    NSDate* date = [NSDate date];
    double number = [date timeIntervalSince1970];
    NSString* text = [NSString stringWithFormat:@"SDL_%f.jpg", number];
    return text;
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(CGSize)scaleSize
{
    UIGraphicsBeginImageContext(scaleSize);
    
    [image drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;                                
}

- (CGSize)makeSize:(UIImage*)image
{
    float w = image.size.width;
    float h = image.size.height;
    
    float k = w / h;
    
    if (k >= 1024 / 768){
        if (w >= 1024){
            w = 1024;
            
            h = w / k;
        }
    }
    else{
        if (h >= 1024){
            h = 1024;
            
            w = h * k;
        }
    }
    
    CGSize size = CGSizeMake(w, h);
    return size;
}

- (void) saveImage:(UIImage *)currentImage
{
    NSString* imageName = [self makeName];
    
    UIImage* imageScale = [self scaleImage:currentImage toScale:[self makeSize:currentImage]];
    
    NSData *imageData = UIImageJPEGRepresentation(imageScale, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    BOOL isSucceed = [imageData writeToFile:fullPath atomically:NO];
    if (isSucceed) {
        if (_delegate){
            [_delegate imageTaked:currentImage path:fullPath];
        }
        
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	//[picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image];
    
//    [picker.view removeFromSuperview];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_popover dismissPopoverAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//	[picker.view removeFromSuperview];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_popover dismissPopoverAnimated:YES];
    
    if (_delegate){
        [_delegate cancel];
    }
}



@end
