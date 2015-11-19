
#import <Foundation/Foundation.h>

#define kHeaderType @"HeaderType"
#define kHeaderValue @"HeaderValue"

@interface HttpParam : NSObject
{
    NSString* strUrl_;
//    NSDictionary* dictHead_;
//    NSString* strBody_;
//    NSString* strMethod_;
    BOOL isArray_;
    
    int type_;
    int timeout_;
}

- (NSString *)description;

@property (nonatomic, copy) NSString* strUrl;

@property (nonatomic,assign ) id requestObj;
@property (nonatomic, assign) NSString* strBody;
@property (nonatomic, assign) NSString* strMethod;
@property (nonatomic ) int type;
@property (nonatomic ) int timeout;
@property (nonatomic,assign )  NSDictionary* dictHead;
@property (nonatomic, assign) NSString* respClassType;
@property (nonatomic )BOOL isArray;
@property (nonatomic,assign ) id delegate;
@property(nonatomic )BOOL showLoading;

- (void)makeLoginHead;
-(void)makeJsonHead;
-(void)makeUpdateShopIdHead:(NSString*)shopId;

- (NSString*)encodeURL:(NSString *)string;
+ (BOOL)isiPad;

@end
