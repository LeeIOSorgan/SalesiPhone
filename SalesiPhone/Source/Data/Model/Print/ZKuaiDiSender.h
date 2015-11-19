//
//  ZKuaiDiSender.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 14-6-8.
//  Copyright (c) 2014年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZKuaiDiSender : Jastor


@property(nonatomic) NSString* senderName; //发件人姓名
@property(nonatomic) NSString* senderEmail;//发件人邮件地址，
@property(nonatomic) NSString* telephone;//发件人电话
@property(nonatomic) NSString* signature;//发件人
@property(nonatomic) NSString* zipCode;//邮编
@property(nonatomic) NSString* address;//发件人地址
@property(nonatomic) NSString* companyInfo;//发件人店铺名称
@property(nonatomic) NSString* senderMemo;// 发件人备注

@end
