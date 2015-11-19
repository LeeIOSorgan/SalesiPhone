//
//  ZItemCompanyDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemCompanyDTO.h"

@implementation ZItemCompanyDTO

-(void)dealloc
{
    ZLogInfo(@"---Into---ZItemCompanyDTO--");
    _itemCompanyId =nil;
    _name = nil;
    _address =nil;
    _telephone= nil;
    _syncTime= nil;
    _pictureUrl= nil;
    _created= nil;
}

//-(NSString*)created{
//    NSRange range = NSMakeRange(5,11);
//    if (_created) {
//        if(_created.length > 7) {
//            NSString* creatDate = [_created substringWithRange:range];
//            return creatDate;
//        }
//    }
//    return _created;
//}
@end
