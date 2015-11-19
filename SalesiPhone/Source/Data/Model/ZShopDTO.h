//
//  ZShopDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-11.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZShopDTO : Jastor

@property(nonatomic )NSNumber* shopId;
@property(nonatomic )NSString*  shopName;
@property(nonatomic )BOOL used;
@property(nonatomic )BOOL suptPCPrintFHD;   //支持电脑打印发货单 默认不支持
@property(nonatomic )BOOL suptBlueToothScan;//是否支持蓝牙扫描货品 默认不支持
@property(nonatomic )BOOL suptKuaiDiPrint;  //是否支持快递打印   默认不支持
@property(nonatomic )BOOL isSubShop;        //是否是子店，子店在， 采购中显示从商家采购的货品。确认交易后，自动转入子店。默认不是
@property(nonatomic )BOOL displayBC;        // 开单时 显示 品牌，类别。  默认显示
@property(nonatomic )BOOL suptShopSalerPerformance; //是否支持 销售员业绩统计。
@property(nonatomic )BOOL suptCustomerPoint;//是否支持客户积分。 设置积分规则等。
@property(nonatomic )BOOL suptPrintColorSize;//是否支持客户积分。 设置积分规则等。
@property(nonatomic )BOOL suptBTPrint112;  //是否支持蓝牙112打印

@end
