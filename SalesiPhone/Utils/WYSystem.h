//
//  WYSystem.h
//  WangYu
//
//  Created by KID on 15/4/22.
//  Copyright (c) 2015年 KID. All rights reserved.
//

#ifndef WangYu_WYSystem_h
#define WangYu_WYSystem_h

//#import "NSDictionary+ObjectForKey.h"
#import "SPUIUtils.h"

#define STAUTTAR_DEFAULT_HEIGHT 20
#define WY_Default_TitleNavBar_Height 64

#define SINGLE_CELL_HEIGHT 44.f
#define SINGLE_HEADER_HEADER 6.f

#define MAX_WX_IMAGE_SIZE 32*1024
#define WY_IMAGE_COMPRESSION_QUALITY 0.4

// 每页加载数
#define DATA_LOAD_PAGESIZE_COUNT 10

// 自定义字体时行高
#define CUSTOM_FONT_LINESPACING 4

//将16进制颜色转换为uicolor
#define UIColorToRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//rgbColor
#define UIColorRGB(r,g,b)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

#define SKIN_COLOR [UIColor colorWithRed:(1.0*0xfd/0xff) green:(1.0*0xd6/0xff) blue:(1.0*0x44/0xff) alpha:1]

#define SKIN_TEXT_COLOR1 [UIColor colorWithRed:(1.0*0x33/0xff) green:(1.0*0x33/0xff) blue:(1.0*0x33/0xff) alpha:1]
#define SKIN_TEXT_COLOR2 [UIColor colorWithRed:(1.0*0x9a/0xff) green:(1.0*0x9a/0xff) blue:(1.0*0x9a/0xff) alpha:1]
#define SKIN_TEXT_COLORRED [UIColor colorWithRed:(1.0*0xf0/0xff) green:(1.0*0x3f/0xff) blue:(1.0*0x3f/0xff) alpha:1]

#define FONT_NAME @"HiraginoSansGB-W3"//冬青 [SPUIUtils customFontWithFontName:FONT_NAME size:X]
#define SKIN_FONT_FROMNAME(X) [UIFont systemFontOfSize:X];

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//用于block获取弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 自定义Log
#ifdef DEBUG
#define WYLog(...) NSLog(__VA_ARGS__)
#else
#define WYLog(...)
#endif

#endif
