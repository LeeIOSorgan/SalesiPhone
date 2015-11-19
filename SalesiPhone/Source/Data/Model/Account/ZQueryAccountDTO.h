//
//  ZQueryAccountDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-11-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZConditionDTO.h"
@interface ZQueryAccountDTO : ZConditionDTO

@property(nonatomic)NSString* customerName;
@property(nonatomic)NSString* customerId;
@property(nonatomic)NSString* itemCompany;
@property(nonatomic)NSString* itemCompanyId;
@property(nonatomic)NSString* companyTelphone;


@end

