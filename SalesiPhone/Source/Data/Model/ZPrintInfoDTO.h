//
//  ZPrintInfoDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZPrintInfoDTO : Jastor
@property(nonatomic )NSNumber* printInfoId;
@property(nonatomic )NSString* ipaddr;
@property(nonatomic )NSString* port;
@property(nonatomic )NSNumber* number;
@property(nonatomic )NSString* wifiName;
@property(nonatomic )NSString* wifiPwd;
@end
