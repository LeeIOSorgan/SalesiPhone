//
//  ZRegisterDeviceDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-1-26.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZRegisterDeviceDTO : Jastor

@property(nonatomic)NSString* appid;
@property(nonatomic)NSString* verifyCode;
@property(nonatomic)NSNumber* shopType;

@end
