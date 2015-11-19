//
//  ZUtility.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZUtility.h"
#import "MBProgressHUD.h"
#import "ZTradeDTO.h"
#import "JSONKit.h"
#import "Jastor.h"
#import "NSString+HXAddtions.h"
#import "ZArchive.h"
#import "ZPopupUIItemDTO.h"
#import "ZDataCache.h"

@implementation ZUtility

+(UIColor*)getTopColor
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        return ZWhiteColor(255);
    } else {
        return  ZColor(52, 160, 211);
    }
}

+ (void)showLoadingView:(BOOL)bShow
{
    UIView* backView = [UIApplication sharedApplication].keyWindow;
    
    static MBProgressHUD* hud = nil;
    
    if (hud == nil)
    {
        hud = [[MBProgressHUD alloc] initWithView:backView];
    }
    
    if (bShow){
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        [backView addSubview:hud];
        [hud show:YES];
    }
    else{
        [hud show:NO];
        [hud removeFromSuperview];
//        [hud  release];
        hud = nil;
    }
}

+ (void)endEdit:(UIView*)view{
    [view endEditing:YES];
//    int i=0;
    for (UIView* vv in view.subviews){
//        i++;
//        ZLogInfo(@"--------------endEdit-------%d",i);
        [self endEdit:vv];
    }
}

+ (void)printFrame:(UIView*)view{
    CGRect f = view.frame;
    ZLogInfo(@"class: %@ frame: x = %f, y = %f, w = %f, h = %f", [view class], f.origin.x, f.origin.y, f.size.width, f.size.height);
    
    for (UIView* vv in view.subviews){
        [self printFrame:vv];
    }
}

+(NSString*) parametersWithDic:(NSMutableDictionary*)params {
    NSMutableString *paramStr = [[NSMutableString alloc]init];
    //得到词典中所有KEY值
    NSEnumerator * enumeratorKey = [params keyEnumerator];
    //快速枚举遍历所有KEY的值
    int i=0;
    for (NSObject *objKey in enumeratorKey) {
        //通过KEY找到value
        if (i==0) {
            NSObject *value = [params objectForKey:objKey];
            [paramStr appendFormat:@"%@=%@", objKey, value];
        } else {
            NSObject *value = [params objectForKey:objKey];
            [paramStr appendFormat:@"&%@=%@", objKey, value];
        }
        i++;
    }
    return paramStr;
}

+(CGRect)getCGRect:(CGRect)previousFrame widt:(int)width1 dis:(int)distance topdis:(int)topDis{
    return CGRectMake(previousFrame.origin.x+ previousFrame.size.width + distance, previousFrame.origin.y, width1, previousFrame.size.height);
}

+(CGRect)getCGRectMiddle:(float)containwidth frame:(CGRect)frame{
    float middle = containwidth/2;
    float x = middle - frame.size.width/2;
    return CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
}
+(void)showAlert:(NSString*)message
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil, nil];
    
    [alert show];
}

+(NSString*)getMoney:(float)value
{
    int type = [[ZDataCache sharedInstance]getDataHandleType];
    if(YES)
    {
        float rtn = 0;
        if( type == 3) {
            //四舍五入
            rtn = roundf(value);
            return [NSString stringWithFormat:@"%d",(int)rtn];
            
        } else if(type == 2) {
            //取上整
            if(value<0) {
                rtn = floorf(value);
                return [NSString stringWithFormat:@"%d",(int)rtn];
            } else {
                rtn = ceilf(value);
                return [NSString stringWithFormat:@"%d",(int)rtn];
                
            }
        }else if(type == 1) {
            if(value<0) {
                rtn = ceilf(value);
                return [NSString stringWithFormat:@"%d",(int)rtn];
            } else {
                //取下整
                rtn = floorf(value);
                return [NSString stringWithFormat:@"%d",(int)rtn];
                
            }
        }
        rtn = roundf(value);
        return [NSString stringWithFormat:@"%d",(int)rtn];
    } else {
        [NSString stringWithFormat:@"%.2f",value];
    }
}
+(NSString*)getDisplayMoneyNum:(NSNumber*)money {
    if(money) {
        return [self getDisplayMoney:[money stringValue]];
    }
    return @"";
}


+(NSString*)getDisplayMoney:(NSString*)money
{
    if(money) {
        
        NSMutableString* result = [[NSMutableString alloc]initWithString:money];
        if( [money intValue] > 0){
            
            NSNumber* tmpInt = [NSNumber numberWithInteger:([result length] -3)];
            if([result length]>6) {
                [result insertString:@"," atIndex:[tmpInt unsignedIntegerValue]];
                tmpInt = [NSNumber numberWithInteger:([result length] -7)];
                [result insertString:@"," atIndex:[tmpInt unsignedIntegerValue]];
            }else if([result length]>3) {
                [result insertString:@"," atIndex:[tmpInt unsignedIntegerValue]];
            }
        }
        if([money intValue] < 0) {
            NSNumber* tmpInt = [NSNumber numberWithInteger:([result length] -3)];
            if([result length]>7) {
                [result insertString:@"," atIndex:[tmpInt unsignedIntegerValue]];
                tmpInt = [NSNumber numberWithInteger:([result length] -7)];
                [result insertString:@"," atIndex:[tmpInt unsignedIntegerValue]];
            }else if([result length]>4) {
                [result insertString:@"," atIndex:[tmpInt unsignedIntegerValue]];
            }
        }
        return result;
    }
    return @"";
}

+(NSString*)getShortDate:(NSString*)strDate
{
    NSRange range = NSMakeRange(5,11);
    if (strDate) {
        if(strDate.length > 7) {
            NSString* creatDate = [strDate substringWithRange:range];
            return creatDate;
        }
    }
    return strDate;
}

+(NSNumber*)getMoneyNum:(float)value
{
    if(YES)
    {
        return [NSNumber numberWithInt:(int)value];
    } else {
        NSString* f2value = [NSString stringWithFormat:@"%.2f",value];
        return [NSNumber numberWithFloat:[f2value floatValue]];
    }
}


+(NSString*)convertNullString:(NSString *)str
{
    if([str isEqualToString:@"(null)"])
    {
        return nil;
    }
    return str;
}

+ (NSString *)getMoneyChar:(NSString *)digitString
{
    NSLog(@"The begin string:%@",digitString);
    if(digitString == nil)
    {
        return @"";
    }
    NSArray *datas = [NSArray arrayWithObjects:@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖", nil];
    NSArray *infos = [NSArray arrayWithObjects:@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"万", nil];
    NSMutableString *processString = [[NSMutableString alloc] initWithString:digitString];

    // creat a new mutable string
    NSMutableString *resultString = [NSMutableString string];
    int i = 0;
    int j = processString.length;

    // str:165047523
    
    // 1亿 6仟 5佰 0拾 4万 7仟 5佰 2拾 3分 ——> 壹亿 陆仟 伍佰 零拾 肆万 柒仟 伍佰 贰拾 叁分
    while (processString.length != 0) {
        // Add location tags after each number
        [resultString insertString:[infos objectAtIndex:i] atIndex:0];
        i++;
        // Obtain a character (a number), then the number corresponding uppercase characters restructuring to the ‘resultString’
        
        j--;
        NSString *specifiedNumberStrAtIndex = [processString substringWithRange:NSMakeRange(j, 1)];
        int specifiedNumber = [specifiedNumberStrAtIndex intValue];
        int number = specifiedNumber % 10;

        [resultString insertString:[datas objectAtIndex:number] atIndex:0];
        // Delete of a character, so that the next time through the loop with
        [processString deleteCharactersInRange:NSMakeRange(j, 1)];
        NSLog(@"resultString = %@",resultString);
        
    }
    NSString *moneyString = [NSString stringWithFormat:@"%@",resultString];
    // To use regular expressions to replace specific characters
    NSError *error=nil;
    NSArray *expressions = [NSArray arrayWithObjects:@"零[拾佰仟]", @"零+亿", @"零+万", @"亿万",nil];//@"零+分", @"零+",
    NSArray *changes = [NSArray arrayWithObjects:@"零", @"亿",@"万",@"",@"亿",nil];//,@"零"
//    NSArray *expressions = [NSArray arrayWithObjects:@"零[拾佰仟]", @"零+亿", @"零+万", @"零+分", @"零+",@"亿万",nil];
//    NSArray *changes = [NSArray arrayWithObjects:@"零", @"亿",@"万",@"",@"零",@"亿",nil];
    for (int k = 0; k < 4; k++)
        
    {

        NSRegularExpression *reg=[[NSRegularExpression alloc] initWithPattern:[expressions objectAtIndex:k] options:NSRegularExpressionCaseInsensitive error:&error];
        moneyString = [reg stringByReplacingMatchesInString:moneyString options:0 range:NSMakeRange(0, moneyString.length) withTemplate:[changes objectAtIndex:k]];
        NSLog(@"moneyString = %@",moneyString);

    }

    return moneyString;
   
}

+(void)saveSuppendTrade:(ZTradeDTO*)tradeDto {
    Jastor* obj = (Jastor*)tradeDto;
    NSMutableDictionary *toDic = [obj toDictionary];
    NSString * resultJSon = [toDic JSONString];
    [[ZArchive instance] saveSuppendTrade:resultJSon localId:tradeDto.localTradeId];
    [toDic removeAllObjects];
}

+(void)saveUnCommitTrade:(ZTradeDTO*)tradeDto {
    Jastor* obj = (Jastor*)tradeDto;
    NSMutableDictionary *toDic = [obj toDictionary];
    NSString * resultJSon = [toDic JSONString];
    [[ZArchive instance] saveUnCommitTrade:resultJSon];
    [toDic removeAllObjects];
}

+(NSMutableArray*)getUnCommitTrade
{
    NSArray* tradeStrs = [[ZArchive instance]getUnCommitTrade];
    NSMutableArray* trades = [[NSMutableArray alloc]init];
    for(ZPopupUIItemDTO* uiDto in tradeStrs) {
        NSString* tradeStr  = uiDto.displayString;
        NSDictionary* jsonObject = [tradeStr objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
        
        //    id jsonObject = [NSJSONSerialization JSONObjectWithData:response.data options:NSJSONReadingAllowFragments error:&error];
        ZTradeDTO* obj = nil;
        if (nil != jsonObject) {
            //如果json数据解析成功
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *resultDic = (NSDictionary *)jsonObject;
                @try {
                    //获取需要返回的class类型。
                    Class tmpClass = NSClassFromString(@"ZTradeDTO");
                    if(tmpClass){
                        //使用Jastor将dictionary转换成class的实例
                        obj = [[tmpClass alloc]initWithDictionary:resultDic];
                    }
                }@catch (NSException * e) {
                    ZLogError(@"NSException Dictionary : %@", e);
                }
            } else {
                ZLogInfo(@"Error JSON data.");
            }
        }
        if(obj) {
            obj.localTradeId = uiDto.itemId;
            [trades addObject:obj];
        }
    }
    return trades;
}

@end
