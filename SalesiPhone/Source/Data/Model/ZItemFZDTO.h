//
//  ZItemFZDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemFZDTO : Jastor
@property (nonatomic )NSNumber* itemFZId;
@property (nonatomic )NSString* kuanHao;
@property (nonatomic )NSString* name;
@property (nonatomic )NSNumber* salePrice;
@property(nonatomic )NSDate* created;
@property (nonatomic )NSString* memo;
@property (nonatomic )NSString* syncTime;

@end
