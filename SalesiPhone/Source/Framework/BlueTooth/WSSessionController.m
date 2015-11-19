//
//  WSSessionController.m
//  BTPrint
//
//  Created by woosimsystems on 2015. 2. 16..
//  Copyright (c) 2015년 woosimsystems. All rights reserved.
//

#import "WSSessionController.h"
#import <ExternalAccessory/ExternalAccessory.h>

NSString *WSDataReceivedNotification = @"WSDataReceivedNotification";


@implementation WSSessionController

@synthesize accessory = _accessory;


+ (WSSessionController *)sharedController
{
    static WSSessionController *sessionController = nil;
    
    if (sessionController == nil) {
        sessionController = [[WSSessionController alloc] init];
    }
    
    return sessionController;
}

- (void)dealloc
{
    [self closeSession];
    [self setupControllerForAccessory:nil withProtocolString:nil];

}


// initialize the accessory with the protocolString
- (void)setupControllerForAccessory:(EAAccessory *)accessory withProtocolString:(NSString *)protocolString
{
    
    _accessory = accessory;
    _protocolString = [protocolString copy];
  
}


// open a session with the accessory and set up the input and output stream on the default run loop
- (BOOL)openSession
{

    [_accessory setDelegate:self];
    _session = [[EASession alloc] initWithAccessory:_accessory forProtocol:_protocolString];
    
    if (_session) {
        [[_session inputStream] setDelegate:self];
        [[_session inputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [[_session inputStream] open];
        
        [[_session outputStream] setDelegate:self];
        [[_session outputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [[_session outputStream] open];
    }
    
    
    return (_session != nil);
}

// close the session with the accessory.
- (void)closeSession
{

    [[_session inputStream] close];
    [[_session inputStream] removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [[_session inputStream] setDelegate:nil];
    
    [[_session outputStream] close];
    [[_session outputStream] removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [[_session outputStream] setDelegate:nil];
    
    
    if(_session != nil) _session = nil;
    if(_outData != nil) _outData = nil;
    if(_inData != nil) _inData = nil;
    

}

// write data to instance variable
- (void)writeData:(NSData *)data
{
    if (_outData == nil) {
        _outData = [[NSMutableData alloc] init];
    }
    
    [_outData appendData:data];
    [self _writeDataToStream];
}

// read data from instance variable
- (NSData *)readData:(NSUInteger)bytesToRead
{
    NSData *data = nil;
    
    if ([_inData length] >= bytesToRead) {
        // copy the receiver’s bytes that fall within the limits specified by a given range
        NSRange range = NSMakeRange(0, bytesToRead);
        data = [_inData subdataWithRange:range];
        
        // delete bytes in the receiver in the range
        [_inData replaceBytesInRange:range withBytes:NULL length:0];
    }
    
    return data;
}

// get number of bytes read into local buffer
- (NSUInteger)getAvailableReadBytes
{
    return [_inData length];
}


#pragma mark - NSStream delegate event

// asynchronous NSStream handleEvent method
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventNone:
            break;
            
        case NSStreamEventOpenCompleted:
            break;
            
        case NSStreamEventHasBytesAvailable:
            [self _readDataFromStream];
            break;
            
        case NSStreamEventHasSpaceAvailable:
            [self _writeDataToStream];
            break;
            
        case NSStreamEventErrorOccurred:
            break;
            
        case NSStreamEventEndEncountered:
            break;
            
        default:
            break;
    }
}


#pragma mark Internal

// internal write method - write data to the accessory while there is space available and data to write
- (void)_writeDataToStream
{
    while (([[_session outputStream] hasSpaceAvailable]) && ([_outData length] > 0))
    {
        // Writes the contents of a provided data buffer to the receiver
        NSInteger bytesWritten = [[_session outputStream] write:[_outData bytes] maxLength:[_outData length]];
        
        if (bytesWritten == -1)
        {
            NSLog(@"write error");
            break;
        }
        else if(bytesWritten > 0)
        {
            // delete bytes in the receiver in the range (0, bytesWritten)
            [_outData replaceBytesInRange:NSMakeRange(0, bytesWritten) withBytes:NULL length:0];
        }
    }
}

// internal read method - read data while there is data and space available in the input buffer
- (void)_readDataFromStream
{
#define INPUT_BUFFER_SIZE 128
    
    uint8_t buffer[INPUT_BUFFER_SIZE];
    while ([[_session inputStream] hasBytesAvailable])
    {
        NSInteger bytesRead = [[_session inputStream] read:buffer maxLength:INPUT_BUFFER_SIZE];
        NSLog(@"read %ld bytes from input stream", (long)bytesRead);
        
        if (_inData == nil) {
            _inData = [[NSMutableData alloc] init];
        }
        
        [_inData appendBytes:(void *)buffer length:bytesRead];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WSDataReceivedNotification object:self];
}



@end
