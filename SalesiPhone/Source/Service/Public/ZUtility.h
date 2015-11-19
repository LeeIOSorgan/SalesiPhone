//
//  ZUtility.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZResourceMgr.h"

@class ZTradeDTO;

@interface ZUtility : NSObject

+(UIColor*)getTopColor;
+ (void)showLoadingView:(BOOL)bShow;

+ (void)endEdit:(UIView*)view;

+ (void)printFrame:(UIView*)view;

+(NSString*)parametersWithDic:(NSMutableDictionary*)params;

+(CGRect)getCGRect:(CGRect)previousFrame widt:(int)width1 dis:(int)distance topdis:(int)topDis;

+(CGRect)getCGRectMiddle:(float)containwidth frame:(CGRect)frame;

+(void)showAlert:(NSString*)message;

+(NSString*)convertNullString:(NSString*)str;

+(NSString*)getMoney:(float)value;

+(NSString*)getDisplayMoney:(NSString*)money;
+(NSString*)getDisplayMoneyNum:(NSNumber*)money;

+(NSString*)getShortDate:(NSString*)strDate;

+(NSString *)getMoneyChar:(NSString *)digitString;

+(NSMutableArray*)getUnCommitTrade;
+(void)saveUnCommitTrade:(ZTradeDTO*)tradeDto;
+(void)saveSuppendTrade:(ZTradeDTO*)tradeDto;

@end
