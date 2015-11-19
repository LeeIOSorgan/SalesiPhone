//
//  ZOrderDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZOrderDTO : Jastor

@property(nonatomic)NSNumber* orderId;
@property(nonatomic)NSNumber* totalCount;// 数量小计
@property(nonatomic)NSNumber* remainCount;// 数量小计
@property(nonatomic)NSNumber* buyCount; //购买
@property(nonatomic)NSNumber* returnCount; //退货
@property(nonatomic)NSNumber* itemPrice; //售价
@property(nonatomic)NSNumber* total; //小计
@property(nonatomic)NSString* memo; //备注
@property(nonatomic)NSString* created; //交易日期
@property(nonatomic)NSNumber* itemId;
@property(nonatomic)NSString* kuanHao;
@property(nonatomic)NSString* name;
@property(nonatomic)NSString* itemCompany;
@property(nonatomic)NSString* itemBrand;
@property(nonatomic)NSString* itemCategory;
@property(nonatomic)NSMutableArray* skuPropertyDTOs;
@property(nonatomic)Boolean fzItem; //是否辅助项
@property(nonatomic)NSString* pictureUrl;

@property(nonatomic)NSNumber* disCount;//折扣

@property(nonatomic)NSNumber* customerId;
@property(nonatomic)NSString* customerName;//销售历史中显示


@end
