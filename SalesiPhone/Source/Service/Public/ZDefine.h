//
//  ZDefine.h
//
//  Created by ZTaoTech ZG on 5/21/13.
//  Copyright (c) 2013 All rights reserved.
//

#import <Foundation/Foundation.h>

#define IColor(fr, fg, fb, fa)  [UIColor colorWithRed:fr green:fg blue:fb alpha:fa]

#define IWhiteColor(w, a) [UIColor colorWithWhite:w/255.0 alpha:a]

#define ZColor(r, g, b) IColor(r/255.0f, g/255.0f, b/255.0f, 1.0f)
#define ZColorEx(r, g, b, a) IColor(r/255.0, g/255.0, b/255.0, a)

#define ZClearColor  [UIColor clearColor]

#define ZWhiteColor(w) IWhiteColor(w, 1.0)
#define ZWhiteColorEx(w, a) IWhiteColor(w, a)

#define ZRect(x, y, w, h) CGRectMake(x, y, w, h)

#define ZNumber(intValue)   [NSNumber numberWithInt:intValue]



//--------------------------------------------------------------
//#define _USE_OPPLE_LOG_


#ifdef _USE_OPPLE_LOG_

#define zztrace(message, ...) logTrace(message, ##__VA_ARGS__)
#define zzdebug(message, ...) logDebug(message, ##__VA_ARGS__)
#define zzinfo(message, ...)  logInfo(message, ##__VA_ARGS__)
#define zzwarn(message, ...)  logWarn(message, ##__VA_ARGS__)
#define zzerror(message, ...) logError(message, ##__VA_ARGS__)
#define zzfatal(message, ...) logFatal(message, ##__VA_ARGS__)

#else

#define zztrace(message, ...) NSLog(message, ##__VA_ARGS__)
#define zzdebug(message, ...) NSLog(message, ##__VA_ARGS__)
#define zzinfo(message, ...)  NSLog(message, ##__VA_ARGS__)
#define zzwarn(message, ...)  NSLog(message, ##__VA_ARGS__)
#define zzerror(message, ...) NSLog(message, ##__VA_ARGS__)
#define zzfatal(message, ...) NSLog(message, ##__VA_ARGS__)


#endif

#define ZFont(size) [UIFont systemFontOfSize:size]
#define ZFontBold(size) [UIFont boldSystemFontOfSize:size]

#define ZImage(name)    [UIImage imageNamed:name]
#define ZUrl(strUrl)    [NSURL URLWithString:strUrl]

void zzPrintRect(CGRect rect);

@interface  ZDefine: NSObject


@end

