//
//  ZCustomerPrintInfoDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-10-9.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"
@class ZCustomerDTO;
@interface ZCustomerPrintInfoDTO : Jastor
@property(nonatomic,assign)NSNumber* customerId;
@property(nonatomic,assign)ZCustomerDTO* customer;
@property(nonatomic,assign)NSNumber* kuaidiId;
@property(nonatomic,assign)NSString* kuaidiName;

@end
