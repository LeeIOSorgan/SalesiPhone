//
//  ZMD5Util.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-16.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZMD5Util.h"
#import <CommonCrypto/CommonDigest.h> 

@implementation ZMD5Util

+(NSString*)getMD5pwd:(NSString*)srcStr{
    const char *cStr = [srcStr UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}
@end
