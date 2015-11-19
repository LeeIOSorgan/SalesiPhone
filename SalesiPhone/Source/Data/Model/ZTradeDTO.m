//
//  ZTradeDTO.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-15.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTradeDTO.h"
#import "ZOrderDTO.h"

@implementation ZTradeDTO
@synthesize orderDTOs,totalMoney,totalCount;
-(void)dealloc
{
//    ZLogInfo(@"---Into----ZTradeDTO--dealloc-");
    orderDTOs = nil;
}

-(void)setOrderDTOs:(NSMutableArray*)setOrders{
    orderDTOs = setOrders;
    int sumAll = 0;
    int countNum = 0;
    int buyNum = 0;
    int rtnNum = 0;
    int totalItemAll = 0;
    int totalOtherAll = 0;
    for (int i=0; i <[setOrders count]; i++) {
        ZOrderDTO *dishItem = [setOrders objectAtIndex:i];
        sumAll = sumAll + [dishItem.total intValue];
        if(!dishItem.fzItem) {//辅助对象不统计在内
            countNum = countNum + [dishItem.totalCount intValue];
            buyNum = buyNum + [dishItem.buyCount intValue];
            rtnNum = rtnNum + [dishItem.returnCount intValue];
            totalItemAll = totalItemAll + [dishItem.total intValue];
        } else {
            totalOtherAll = totalOtherAll + [dishItem.total intValue];
        }
    }
    totalMoney = [[NSNumber alloc] initWithInt:sumAll];
    totalCount = [[NSNumber alloc]initWithInt:countNum];
    _totalBuy =[[NSNumber alloc]initWithInt:buyNum];
    _totalReturn = [[NSNumber alloc]initWithInt:rtnNum];
    _totalItemSale = [NSNumber numberWithFloat:totalItemAll];
    _totalOtherFee = [NSNumber numberWithFloat:totalOtherAll];
}

+ (Class)orderDTOs_class { // used by Jastor
	return [ZOrderDTO class];
}

-(NSString*)operationTime{
    NSRange range = NSMakeRange(5,11);
    if (_operationTime) {
        if(_operationTime.length > 7) {
            NSString* creatDate = [_operationTime substringWithRange:range];
            return creatDate;
        }
    }
    return _operationTime;
}

-(NSString*)created
{
    NSRange range = NSMakeRange(5,11);
    if (_created) {
        if(_created.length > 11) {
            NSString* creatDate = [_created substringWithRange:range];
            return creatDate;
        }
    }
    return _created;
}
-(NSString*)tradeDate
{
    NSRange range = NSMakeRange(5,11);
    if (_tradeDate) {
        if(_tradeDate.length > 11) {
            NSString* creatDate = [_tradeDate substringWithRange:range];
            return creatDate;
        }
    }
    return _tradeDate;
}

-(void)clearPayData {
    _balance2owned = nil;
    _balanceFee = nil;
}

-(void)updateBalance {
    _balanceLeft =_balanceFeeHistory;
    _ownedLeft = _ownedFee;
    //货品总额大于0
    if([totalMoney intValue] >= 0) {
        if(_useBalance) {
            // 货品总额为正，且使用余额， 则自动抵消货款，付款
            int bfLeft = [totalMoney intValue]- [_balanceFeeHistory intValue];// 大于=0 还需要付款，余额抵扣完成。 小于0 只抵用了部分的余额
            if(bfLeft >=0) {
                // 余额全部抵用完成。 余额抵支付等于历史余额
                _payedCash = [NSNumber numberWithInt:bfLeft];
                _balanceChange = _balanceFeeHistory;
                _balanceLeft =[NSNumber numberWithInt:0];
            } else {
                // 说明 只抵用了部分的余额。
                _payedCash = [NSNumber numberWithInt:0];
                _balanceChange = totalMoney;
                _balanceLeft = [NSNumber numberWithInt:0-bfLeft];
            }
        } else {
            //货品总额为正，且没有使用余额，则不抵消货款，实收
            _payedCash = totalMoney;
        }
    } else {
        if(_useBalance) {
            // 货品总额为负，且使用余额，则自动 新增为余额，实退
            _balanceChange = [NSNumber numberWithInt:0-[totalMoney intValue]];// 总额为负，变化金额 正为新增，负为减少
            int blanceleft = [_balanceFeeHistory intValue] + [_balanceChange intValue];
            _balanceLeft = [NSNumber numberWithInt:blanceleft];
        } else {
            //货品总额为负，且没有使用余额，则实退
            _payedCash = totalMoney;// 实退 在今天的支付里减去。
        }
    }
}

/*
 修改了 支付栏位的金额后检查。
 货品总额为正，且使用余额， 则自动抵消货款，付款 调整 则为未付  这里的支付金额不能为负数。
 */
-(NSString*)updateFeeAfterAdjust {
    //货品总额大于0
    if([totalMoney intValue] >= 0) {
        if([_payedFee intValue] < 0) {
            return @"支付金额错误， 请检查！";
        }
        if(_useBalance) {
            //货品总额为正，且使用余额， 则自动抵消货款，付款 调整 则为未付
            int bfLeft = [totalMoney intValue] - [_balanceFeeHistory intValue];//余额抵消货款  = 付款
            if(bfLeft >= 0) {
                _balanceChange =[NSNumber numberWithInt:0-[_balanceFeeHistory intValue]];
                // 货款多出 _payedFee是实际付款。
                int newOwn = bfLeft - [_payedFee intValue];
                if(newOwn>=0) {
                    //>0新增了欠款 ==0 无影响。
                    _unpayed = [NSNumber numberWithInt:newOwn];
                    _ownedLeft = [NSNumber numberWithInt:[_ownedFee intValue] + newOwn];
                } else {
                    //多付了钱，作为新增的余额
                    _balanceChange = [NSNumber numberWithInt:-newOwn];
                    _balanceLeft = [NSNumber numberWithInt:[_balanceFeeHistory intValue] + (0-newOwn)];
                }
            } else {
                // 抵消 光了应付款
                if([_payedFee intValue] != 0) {
                    return @"余额抵消货款，无需支付!";
                }
                _balanceChange = [NSNumber numberWithInt:0-[totalMoney intValue]];
            }
        } else {
            ////货品总额为正，且没有使用余额， 则付款 调整 则为未付
            int unpayed = [totalMoney intValue] - [_payedFee intValue];
            if(unpayed>=0) {
                _unpayed = [NSNumber numberWithInt:unpayed];
                _ownedLeft = [NSNumber numberWithInt:[_ownedFee intValue] - unpayed];
            } else {
                //多付了钱
                _balanceChange = [NSNumber numberWithInt:0-unpayed];
                _balanceLeft = [NSNumber numberWithInt:[_balanceFeeHistory intValue] - unpayed];//增加余额
            }
        }
    } else {
        
        if([_payedFee intValue] > 0 || [_payedFee intValue] < [totalMoney intValue]) {
            // 负数 小于了货品的总负数。
            return @"付款数据有误！如需退款,请关闭使用余额。";
        }
        int toOwned = ([totalMoney intValue] - [_payedFee intValue]); //负数
        
        if(_useBalance) {
            //货品总额为负，且使用余额，则自动 新增为余额，实退  调整则抵欠款
            _balanceChange = [NSNumber numberWithInt:0-toOwned];
            _balanceLeft = [NSNumber numberWithInt:[_balanceFeeHistory intValue] -toOwned];
        } else  {
            // 退款， 抵欠款， 超出欠款的部分， 作为余额
            _unpayed = [NSNumber numberWithInt:toOwned]; //抵欠款
            int blance = (0-toOwned) - [_ownedFee intValue];// 余额 抵欠款
            if(blance >= 0) {
                // 抵消不足的，还是会作为余额，
                _balanceChange = [NSNumber numberWithInt:blance];
                _balanceLeft =[NSNumber numberWithInt:[_balanceFeeHistory intValue] + blance];
                _ownedLeft =[NSNumber numberWithInt:0];
            } else  {
                _ownedLeft =[NSNumber numberWithInt:[_ownedFee intValue] + toOwned];// 抵消欠款
            }
        }
    }
    
    if([_returnedFee intValue] > 0) {
        int ownLeft = [_ownedLeft intValue] - [_returnedFee intValue];
        if(ownLeft <= 0) {
            _balanceLeft = [NSNumber numberWithInt:[_balanceLeft intValue] - ownLeft];//多还款 作为余额
            _ownedLeft =[NSNumber numberWithInt:0];
        } else {
            _ownedLeft = [NSNumber numberWithInt:ownLeft];
        }
    }
    if( [_balance2owned intValue] > 0) {
        int balanceLeft = [_ownedLeft intValue] - [_balance2owned intValue];
        if(balanceLeft >= 0 ) {
            _balanceLeft = [NSNumber numberWithInt:0];
            _ownedLeft =[NSNumber numberWithInt:balanceLeft];
        } else {
            return @"余额抵欠款 金额有误，请检查！";
        }
    }
    return nil;
}

-(void)handleReturnedFee {
    
}

@end
