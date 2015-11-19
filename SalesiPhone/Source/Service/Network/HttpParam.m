

#import "HttpParam.h"

@implementation HttpParam

@synthesize strUrl = strUrl_;
@synthesize strBody = strBody_;
@synthesize strMethod = strMethod_;
@synthesize type = type_;
@synthesize dictHead = dictHead_;
@synthesize timeout = timeout_;
@synthesize respClassType = respClassType_;
@synthesize isArray = isArray_;
@synthesize showLoading = showLoading_;

- (NSString *)description
{
    NSMutableString* desc = [[NSMutableString alloc]init];
    [desc appendString:@"{"];
    if (strUrl_) {
        [desc appendFormat:@"url = %@;\r\n",strUrl_];
    }
    if (strBody_) {
        [desc appendFormat:@"body = %@;\r\n",strBody_];
    }
    
    if (dictHead_) {
        [desc appendFormat:@"head = %@;\r\n",dictHead_];
    }
    
    if (strMethod_) {
        [desc appendFormat:@"method = %@;\r\n",strMethod_];
    }
    if (respClassType_) {
        [desc appendFormat:@"responseClass = %@;\r\n", respClassType_];
    }
    
    [desc appendFormat:@"type = %d;\r\n",type_];
    
    if (timeout_ > 0) 
    {
        [desc appendFormat:@"timeout = %d;\r\n",timeout_];
    }
    
    [desc appendString:@"}\r\n"];
    return desc;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        timeout_ = 20;
        respClassType_ = @"";
        isArray_ = NO;
        showLoading_ = YES;
        [self makeJsonHead];
    }
    
    return self;
}

- (void)dealloc
{
    ZLogInfo(@"---Into---HttpParam---%@__%@__%@", dictHead_, strUrl_, strBody_);
    if (dictHead_ != nil) {
        dictHead_ = nil;
    }
    if (strUrl_ != nil) {
        strUrl_ =nil;
    }    
    if (strBody_ != nil) {
        strBody_ = nil;
    }
    if (strMethod_ != nil) {
        strMethod_ = nil;
    }
    _requestObj = nil;
    _delegate = nil;
//
//    [super dealloc];
}

//+ (BOOL)isiPhone
//{
//    BOOL ret = YES;
//    NSString *str = [UIDevice currentDevice].model;
//    NSRange r = [str rangeOfString:@"iPhone"];
//    if (r.location == NSNotFound) {
//        ret = NO;
//    }
//    return ret;
//}

+ (BOOL)isiPad
{
    BOOL ret = YES;
    NSString *str = [UIDevice currentDevice].model;
    NSRange r = [str rangeOfString:@"iPad"];
    if (r.location == NSNotFound) {
        ret = NO;
    }
    return ret;
}

- (void)makeLoginHead
{
    self.dictHead = [NSDictionary dictionaryWithObjectsAndKeys:@"application/x-www-form-urlencoded",
                     @"Content-Type",
                   @"no-cache", @"Cache-Control",
                     @"utf-8", @"charset",
                   nil];
}
-(void)makeJsonHead
{
    self.dictHead = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json",@"Content-Type",
                     @"no-cache", @"Cache-Control",
                     @"utf-8", @"charset",
                      nil];
}
-(void)makeUpdateShopIdHead:(NSString*)shopId
{
    self.dictHead = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json",@"Content-Type",
                     @"shopId", shopId,
                     @"no-cache", @"Cache-Control",
                     @"utf-8", @"charset",
                     nil];
}
-(void)makeUserInfo {
 

    
}

- (NSString*)encodeURL:(NSString *)string
{
    //    NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByAddingPercentEscapes(
    //                                                                                                 kCFAllocatorDefault,
    //                                                                                                 (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
    //                                                                                            CFStringConvertNSStringEncodingToEncoding([self stringEncoding])) autorelease]);
    
    NSString *newString = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,
                                                                             (CFStringRef)string, nil,
                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    if (newString) {
        return newString;
    }
    return @"";
}

@end
