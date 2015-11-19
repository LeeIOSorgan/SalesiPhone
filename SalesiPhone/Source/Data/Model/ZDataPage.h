//
//  ZDataPage.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZDataPage : Jastor
@property(nonatomic )NSNumber* pageSize;
@property(nonatomic )NSNumber* pageNo;
@property(nonatomic )BOOL hasMorePages;
@property(nonatomic )NSNumber* totalElements;
@property(nonatomic )NSNumber* totalPages;

@end
