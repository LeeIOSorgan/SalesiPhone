//
//  WSSessionController.h
//  BTPrint
//
//  Created by woosimsystems on 2015. 2. 16..
//  Copyright (c) 2015년 woosimsystems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ExternalAccessory/ExternalAccessory.h>

#define ESC 0x1b

extern NSString *WSDataReceivedNotification;

// NOTE: WSSessionController is not threadsafe, calling methods from different threads will lead to unpredictable results
@interface WSSessionController : NSObject<EAAccessoryDelegate, NSStreamDelegate>
{
    NSString *_protocolString;
    EASession *_session;
    
    NSMutableData *_outData;
    NSMutableData *_inData;
    
}

@property (nonatomic, readonly) EAAccessory *accessory;


+ (WSSessionController *)sharedController;

- (void)setupControllerForAccessory:(EAAccessory *)accessory withProtocolString:(NSString *)protocolString;

- (BOOL)openSession;
- (void)closeSession;

- (void)writeData:(NSData *)data;
- (NSData *)readData:(NSUInteger)bytesToRead;
- (NSUInteger)getAvailableReadBytes;

@end
