//
//  ZFHDPrintSwitchDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-10-1.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFHDPrintSwitchDTO : NSObject
//@property(nonatomic ) int type;
//@property(nonatomic ) int maxCount;
@property(nonatomic ) Boolean netPrint;
@property(nonatomic ) Boolean pcPrint;
@property(nonatomic ) Boolean btPrint112;

@property(nonatomic ) int maxNetCount;
@property(nonatomic ) int maxPcCount;
@property(nonatomic ) int maxBtCount;
@end
