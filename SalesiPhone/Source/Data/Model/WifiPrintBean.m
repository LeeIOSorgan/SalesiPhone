//
//  TestModel.m
//  ConnectTest
//
//  Created by ZTaoTech on 13-8-7.
//
//

#import "WifiPrintBean.h"

@implementation WifiPrintBean

//@synthesize foot, itemOrder,shopInfo, title;

-(void)dealloc
{
    ZLogInfo(@"---Into----WifiPrintBean--dealloc-");
    _foot = nil;
    _itemOrder = nil;
    _shopInfo = nil;
    _title = nil;
}

@end
