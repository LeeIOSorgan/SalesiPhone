#import <Foundation/Foundation.h>


typedef enum{
    WSDATA_MSR,
    WSDATA_MSRFAIL,
    WSDATA_SPECIAL,
    WSDATA_UNKNOWN
}WSDATATYPE;

@interface WSParser : NSObject

@property (nonatomic, readonly) NSData *track1;
@property (nonatomic, readonly) NSData *track2;
@property (nonatomic, readonly) NSData *track3;

@property (nonatomic, readonly) int specialDataType;

-(WSDATATYPE)decode:(NSData *)srcData;


@end