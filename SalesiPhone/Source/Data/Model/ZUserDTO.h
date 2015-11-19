//
//  ZUserDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZUserDTO : Jastor

@property(nonatomic) BOOL initPwd;
@property (nonatomic ) NSNumber *userId;
@property (nonatomic ) NSNumber *shopId;

@property(nonatomic ) NSString *username;
@property(nonatomic ) NSString *nickName;
@property(nonatomic ) NSString *password;
@property(nonatomic ) NSString *roles;
@property(nonatomic ) NSString *sfzm;
@property(nonatomic ) NSString *birthday;
@property(nonatomic ) NSString *telephone;
@property(nonatomic ) NSString *passwordNew;
@property(nonatomic ) NSString *memo;
@property(nonatomic ) NSString *registTime;
@property(nonatomic ) NSString *loginTime;
@property(nonatomic ) NSNumber *totalSales;
@property(nonatomic ) NSString *mdAddress;
@property(nonatomic ) NSString *syncTime;
@property(nonatomic ) BOOL used;

@property(nonatomic ) NSNumber *maxOnlineItemCount;
@property(nonatomic ) NSNumber *shopType;
@property(nonatomic ) NSNumber *performanceType;

@property(nonatomic ) NSString *imageUrl;
@property(nonatomic ) NSString *token;
@property(nonatomic ) NSString *expiredTime;

@end
