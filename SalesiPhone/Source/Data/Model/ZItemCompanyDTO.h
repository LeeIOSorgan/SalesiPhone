//
//  ZItemCompanyDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemCompanyDTO : Jastor
@property(nonatomic )NSNumber* itemCompanyId;
@property (nonatomic )NSString* name;
@property (nonatomic )NSString* address;
@property (nonatomic )NSString* telephone;
@property (nonatomic )NSString* syncTime;
@property (nonatomic )NSString* pictureUrl;
@property (nonatomic )NSString* created;
@property (nonatomic )NSString* contactName;
@property (nonatomic )BOOL used;

@property (nonatomic )NSNumber* balanceFee;
@property(nonatomic )NSNumber*  shouldPayFee;
@property(nonatomic )NSNumber*  unpayedFee;
@property(nonatomic )NSNumber*  payedFee;

@property(nonatomic )NSNumber*  payedCash;
@property(nonatomic )NSNumber*  payedCard;
@property(nonatomic )NSNumber*  payedRemit;
@end
