//
//  ZTradeDTO.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  retainright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "Jastor.h"

@interface ZTradeDTO : Jastor

-(void)updateBalance;
-(NSString*)updateFeeAfterAdjust;

@property (nonatomic )NSNumber* localTradeId;
@property (nonatomic )NSNumber* tradeId;

@property (nonatomic )NSMutableArray* orderDTOs;
@property (nonatomic )NSString* pici;
@property (nonatomic )NSString* lsh;
@property (nonatomic )NSString* operationTime;
@property(nonatomic ) BOOL printed;
@property(nonatomic ) BOOL accounted;
@property(nonatomic ) BOOL useBalance;
@property(nonatomic ) BOOL deleted;
@property (nonatomic )NSString* created;//交易日期
@property (nonatomic )NSString*  tradeDate;

@property (nonatomic )NSString* yyyname;//nickName
@property (nonatomic )NSNumber* yyyId;
@property (nonatomic )NSNumber* fee;
@property (nonatomic )NSString* customer;
@property (nonatomic )NSNumber* customerId;
@property (nonatomic )NSNumber* totalCount;
@property (nonatomic )NSNumber* totalBuy;
@property (nonatomic )NSNumber* totalReturn;

@property (nonatomic )NSNumber* status;
@property (nonatomic )NSNumber* unpayed;
@property (nonatomic )NSString* memo;
@property (nonatomic )NSNumber* totalMoney; //应付 货品总额
@property (nonatomic )NSNumber* totalProfit;
@property (nonatomic )NSNumber* totalItemSale;
@property (nonatomic )NSNumber* totalOtherFee;

@property (nonatomic )NSNumber* payedFee;
@property (nonatomic )NSNumber* payedCash;
@property (nonatomic )NSNumber* payedCard;
@property (nonatomic )NSNumber* payedRemit;

@property (nonatomic )NSNumber* returnedFee;
@property (nonatomic )NSNumber* returnedCash;
@property (nonatomic )NSNumber* returnedCard;
@property (nonatomic )NSNumber* returnedRemit;
@property (nonatomic )NSNumber* balance2owned;//余额 抵欠款

//余额 抵应付
@property (nonatomic)NSNumber* balance2payed;
@property (nonatomic )NSNumber* balanceFee;//本次余额
// 变化的余额
@property (nonatomic)NSNumber* balanceChange; //改变为 新增
// 剩余 欠款 余额
@property (nonatomic)NSNumber* balanceLeft; //改变为 新增
@property (nonatomic)NSNumber* ownedLeft;

//localUse 这个客户历史欠款 历史余额
@property (nonatomic )NSNumber* ownedFee;
@property (nonatomic )NSNumber* balanceFeeHistory;

@end
