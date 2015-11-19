

#import "ZLog.h"
#import "DDTTYLogger.h"
#import "DDASLLogger.h"
#import "DDFileLogger.h"

int ddLogLevel = LOG_LEVEL_VERBOSE;


void zlogInit()
{
    initLogger(YES, NO, NO);
    setLogLevel(LOG_LEVEL_VERBOSE);
}

void initLogger(BOOL ttyOn, BOOL aslOn, BOOL fileOn)
{
    NSLog(@"home: %@", NSHomeDirectory());
    [DDLog removeAllLoggers];
    
    if (ttyOn)
    {
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
    }
    
    if (aslOn)
    {
        [DDLog addLogger:[DDASLLogger sharedInstance]];
    }
    
    if (fileOn)
    {
        NSString* strDir = [NSString stringWithFormat:@"%@/Documents/zzlog", NSHomeDirectory()];
        DDLogFileManagerDefault *defaultLogFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:strDir];
        DDFileLogger* fileLogger = [[DDFileLogger alloc] initWithLogFileManager:defaultLogFileManager];
        fileLogger.maximumFileSize = 1024*1024*5;
        
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;

        [DDLog addLogger:fileLogger];
//        [defaultLogFileManager release];
//        [fileLogger release];
    }
}

void setLogLevel(unsigned int lvl)
{
    ddLogLevel = lvl;
}