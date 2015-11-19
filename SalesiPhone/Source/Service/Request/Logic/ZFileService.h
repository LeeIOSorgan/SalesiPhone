//
//  ZFileService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-4.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFileService : NSObject

-(void)uploadItemImageFile:(NSString*)filePath type:(id)delegate itemId:(NSNumber*)itemId indi:(UIProgressView*)indi;

-(void)uploadImageFile:(NSString*)filePath type:(id)delegate zip:(BOOL)bzip  indi:(UIProgressView*)indi;

-(void)deleteImage:(NSNumber*) itemId imageId:(NSString*) imageId type:(id)delegate;

@end
