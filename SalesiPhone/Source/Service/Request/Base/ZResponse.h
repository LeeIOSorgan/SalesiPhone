//
//  ZResponse.h
//  MobileBoss
//
//  Created by ZTaoTech ZG on 6/6/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCode.h"

@interface ZResponse : NSObject

@property (nonatomic )  int  businessType;
@property (nonatomic ) ZCode* code;
@property (nonatomic ) NSData* data;
@property (nonatomic) NSObject* respObj;
@property (nonatomic, copy) NSMutableDictionary* mutDic;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) NSString* respClassType;
@property (assign) BOOL isArray;

@end
