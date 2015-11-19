


#import "DDLog.h"
#import <Foundation/Foundation.h>

extern int ddLogLevel;

void zlogInit();

void initLogger(BOOL ttyOn, BOOL aslOn, BOOL fileOn);
void setLogLevel(unsigned int lvl);

//Log control switch

//enable or no, should be enable when debug
#define __ENABLE_LOG__

//show line and function, not need, maybe use in future
#define _SHOW_FILE_LINE_FUNC

//=====================================================================

#ifdef _SHOW_FILE_LINE_FUNC

#define ZLogBaseVerbose    DDLogVerbose(@"%d, %s: ", __LINE__, __FUNCTION__)
#define ZLogBaseInfo       DDLogInfo(   @"%d, %s: ", __LINE__, __FUNCTION__)
#define ZLogBaseWarn       DDLogWarn(   @"%d, %s: ", __LINE__, __FUNCTION__)
#define ZLogBaseError      DDLogError(  @"%d, %s: ", __LINE__, __FUNCTION__)

#else

#define ZLogBaseVerbose
#define ZLogBaseInfo
#define ZLogBaseWarn
#define ZLogBaseError

#endif

//=====================================================================

#ifdef __ENABLE_LOG__


#define ZLogError(frmt, ...)    do{ ZLogBaseError; DDLogError(frmt, ##__VA_ARGS__); } while(0)
#define ZLogWarn(frmt, ...)     do{ ZLogBaseWarn; DDLogWarn(frmt, ##__VA_ARGS__); } while(0)
#define ZLogVerbose(frmt, ...)   do{ ZLogBaseVerbose; DDLogVerbose(frmt, ##__VA_ARGS__); } while(0)
#define ZLogInfo(frmt, ...)     do{ ZLogBaseInfo; DDLogInfo(frmt, ##__VA_ARGS__); } while(0)

#define ZTLogError(Tag,frmt, ...)    do{ ZLogBaseError; DDLogError(frmt, ##__VA_ARGS__); } while(0)
#define ZTLogWarn(Tag,frmt, ...)     do{ ZLogBaseWarn; DDLogWarn(frmt, ##__VA_ARGS__); } while(0)
#define ZTLogVerbose(Tag,frmt, ...)   do{ ZLogBaseVerbose; DDLogVerbose(frmt, ##__VA_ARGS__); } while(0)
#define ZTLogInfo(Tag,frmt, ...)     do{ ZLogBaseInfo; frmt = DDLogInfo(frmt, ##__VA_ARGS__); } while(0)
/*
#define ZLogError(frmt, ...)    do{ NSLog(frmt, ##__VA_ARGS__); }      while(0)
#define ZLogWarn(frmt, ...)     do{ NSLog(frmt, ##__VA_ARGS__); }      while(0)
#define ZLogVerbose(frmt, ...)  do{ NSLog(frmt, ##__VA_ARGS__); }      while(0)
#define ZLogInfo(frmt, ...)     do{ NSLog(frmt, ##__VA_ARGS__); }      while(0)
*/

#endif



