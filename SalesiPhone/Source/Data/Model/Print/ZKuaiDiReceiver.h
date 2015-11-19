//
//  ZKuaiDiReceiver.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-6-8.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZKuaiDiReceiver : Jastor


@property(nonatomic) NSString* name; //收件人姓名
@property(nonatomic) NSString* address;//收件人地址，
@property(nonatomic) NSString* telephone;//收件人电话
@property(nonatomic) NSString* companyInfo;//收件人电话
@property(nonatomic) NSString* zipCode;

@end
