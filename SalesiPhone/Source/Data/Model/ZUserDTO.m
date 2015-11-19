//
//  ZUserDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZUserDTO.h"

@implementation ZUserDTO

-(NSString*)registTime{
    NSRange range = NSMakeRange(5,11);
    if (_registTime) {
        if(_registTime.length > 7) {
            NSString* creatDate = [_registTime substringWithRange:range];
            return creatDate;
        }
    }
    return _registTime;
}
-(NSString*)loginTime{
    NSRange range = NSMakeRange(5,11);
    if (_loginTime) {
        if(_loginTime.length > 7) {
            NSString* creatDate = [_loginTime substringWithRange:range];
            return creatDate;
        }
    }
    return _loginTime;
}


@end
