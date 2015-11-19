//
//  TestModel.h
//  ConnectTest
//
//  Created by ZTaoTech on 13-8-7.
//
//

#import "Jastor.h"
#import "ZOrderDTO.h"
#import "ZShopInfoDTO.h"
#import "ZTradeDTO.h"
@interface WifiPrintBean : Jastor

//@property (nonatomic ) ItemOrders *itemOrder;
@property (nonatomic ) ZTradeDTO * itemOrder;
//@property(nonatomic ) NSString * orderId;
@property(nonatomic ) NSString * title;
@property(nonatomic ) NSString * foot;
@property(nonatomic ) NSString * printer;
@property(nonatomic ) ZShopInfoDTO * shopInfo;


@end
