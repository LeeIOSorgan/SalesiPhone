//
//  ZItemDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZItemDTO.h"
#import "ZItemImageDTO.h"
#import "ZSkuPropertyDTO.h"
@implementation ZItemDTO

-(void)dealloc
{
    ZLogInfo(@"---Into---ZItemDTO--dealloc--");
    _name  = nil;
    _kuanHao  = nil;
    _itemId  = nil;
    _itemCompany  = nil;
    _itemCategory  = nil;
    _buyerPrice  = nil;
    _salePrice  = nil;
    _created  = nil;
    _total  = nil;
    _pictureUrl  = nil;
    _saledCount = nil;
    _skuPropertyDTOs  = nil;
}

+ (Class)skuPropertyDTOs_class { // used by Jastor
	return [ZSkuPropertyDTO class];
}
+ (Class)itemImage_class { // used by Jastor
	return [ZItemImageDTO class];
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

//-(NSNumber*)remainCount
//{
//    _remainCount = [NSNumber numberWithInt:[_total intValue] - [_saledCount intValue]];
//    return _remainCount;
//}

@end
