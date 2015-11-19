//
//  ZFileService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-4.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZFileService.h"

#import "ZipArchive.h"
#import "HttpManager.h"
#import "ZType.h"
#import "ZItemImageDTO.h"

#define urlFile_Upload [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"image/upload"]
#define urlItemFile_Upload [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"image/item/upload/%@"]
#define urlItemFile_Remove [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"image/item/delete/%@"]


@implementation ZFileService

-(void)uploadItemImageFile:(NSString*)filePath type:(id)delegate itemId:(NSNumber*)itemId indi:(UIProgressView*)indi{
    
    NSString* path = filePath;
    NSData* fileData = [self createUpData:filePath];
    
    NSString* url = [NSString stringWithFormat:urlItemFile_Upload, itemId];
    [[HttpManager getInstance] addHttpUpLoadFileRequest:kItemFile_Upload fileData:fileData filePath:path url:url delegate:delegate indicator:indi respClassType:@"ZItemImageDTO"];
}

-(void)uploadImageFile:(NSString*)filePath type:(id)delegate zip:(BOOL)bzip indi:(UIProgressView*)indi{
    
    NSString* path = filePath;
    if (bzip)
    {
        path = [self zipFile:filePath];
    }
    NSData* fileData = [self createUpData:filePath];
    
    
    [[HttpManager getInstance] addHttpUpLoadFileRequest:kFile_Upload fileData:fileData filePath:path url:urlFile_Upload delegate:delegate indicator:indi respClassType:nil];
}

- (NSData*)createUpData:(NSString*)filePath
{
    NSFileManager *fm;
    fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:filePath]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
        [fileHandle seekToFileOffset:0];
        NSData *data = [fileHandle readDataToEndOfFile];
        return data;
    }
    return nil;
}

- (NSString*)zipFile:(NSString*)filePath
{
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if([fm fileExistsAtPath:filePath]) {
//        NSString* name = [[fm currentDirectoryPath] lastPathComponent];
//        NSString* zipName = [NSString stringWithFormat:@"%@.zip", name];
//        NSString* originPath = [NSString stringWithFormat:@"%@/%@", filePath, name];
//        
//        NSString * zipFilePath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), zipName];
//        
//        //实例化并创建zip文件
//        ZipArchive * zipArchive = [[ZipArchive alloc] init];
//        
//        if ([zipArchive CreateZipFile2:zipFilePath]) {
//            if ([zipArchive addFileToZip:originPath newname:name]){
//                ZLogInfo(@"zip ok");
//            }
//        }
//        
//        if([zipArchive CloseZipFile2])
//        {
////            [zipArchive release];
//            
//            return zipFilePath;
//            
//        }
//        
////        [zipArchive release];
//        
//    }
    return nil;
}
//重新更新当前的resource字段。
-(void)deleteImage:(NSNumber*) itemId imageId:(NSString*) imageId type:(id)delegate
{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlItemFile_Remove, itemId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    hp.strBody = imageId;
    hp.type = kItemFile_Remove;
    ZLogInfo(@"Request Service Request deleteImage type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
