//
//  ZKuaiDiToPCDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-6-8.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"
@class ZKuaiDiSender;
@class ZKuaiDiReceiver;

@interface ZKuaiDiToPCDTO : Jastor

@property(nonatomic ) ZKuaiDiReceiver * receiver;
@property(nonatomic ) ZKuaiDiSender* sender;
@property(nonatomic) NSString* kuaidiName;
@property(nonatomic) NSString* memo;

@end
