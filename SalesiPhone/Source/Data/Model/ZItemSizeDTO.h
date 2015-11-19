//
//  ZItemSizeDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZItemSizeDTO : Jastor

@property(nonatomic ) NSNumber* rowid;
@property(nonatomic ) NSNumber* sequency;
@property(nonatomic )NSString* size;
@property(nonatomic )NSString* sizeCode;
@property(nonatomic ) NSNumber* sizeCount;
@property (nonatomic )BOOL used;
@end
