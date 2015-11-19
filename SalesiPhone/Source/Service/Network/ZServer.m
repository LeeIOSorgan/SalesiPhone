//
//  ZServer.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZServer.h"
#import "GCDAsyncSocket.h"

#import "HTTPServer.h"

#define WELCOME_MSG  0
#define ECHO_MSG     1
#define WARNING_MSG  2

#define READ_TIMEOUT 15.0
#define READ_TIMEOUT_EXTENSION 10.0

@interface ZServer ()
{
    dispatch_queue_t _socketQueue;
    GCDAsyncSocket* _serverSocket;
    
    NSMutableArray* _connectedSockets;
    
    
    HTTPServer* _httpServer;
}

@end

@implementation ZServer

- (void)start
{
    [self startHttpServer];
}

- (void)stop
{
    
}

- (void)stopHttpServer{
    [_httpServer stop];
}

- (void)startHttpServer
{
    _httpServer = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[_httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
	// [httpServer setPort:12345];
	
    [_httpServer setPort:8080];
    
	// Serve files from our embedded Web folder
	NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web/json"];
	DDLogInfo(@"Setting document root: %@", webPath);
	
	[_httpServer setDocumentRoot:webPath];
    
    //[self startServer];
    NSError *error = nil;
	if([_httpServer start:&error])
	{
		ZLogInfo(@"Started HTTP Server on port %hu", [_httpServer listeningPort]);
	}
	else
	{
		ZLogError(@"Error starting HTTP Server: %@", error);
	}
}

+ (ZServer*)instance{
    static ZServer* _instance = nil;
    
    if (_instance == nil){
        _instance = [[ZServer alloc] init];
    }
    
    return _instance;
}





- (void)startTcpSocket{
    ZLogInfo(@"start");
    
    _connectedSockets = [[NSMutableArray alloc] initWithCapacity:1];
    _socketQueue = dispatch_queue_create("socketQueue", NULL);
    _serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:_socketQueue];
    
    int port = 8080;    
    NSError *error = nil;
    
    if(![_serverSocket acceptOnPort:port error:&error])
    {
        ZLogError(@"Error starting server: %@", error);
        return;
    }
    
    ZLogInfo(@"Echo server started on port %hu", [_serverSocket localPort]);
}

- (void)stopTcpSocket
{
    // Stop accepting connections
    [_serverSocket disconnect];
    
    // Stop any client connections
    @synchronized(_connectedSockets)
    {
        NSUInteger i;
        for (i = 0; i < [_connectedSockets count]; i++)
        {
            // Call disconnect on the socket,
            // which will invoke the socketDidDisconnect: method,
            // which will remove the socket from the list.
            [[_connectedSockets objectAtIndex:i] disconnect];
        }
    }
}

#pragma mark -
#pragma mark - GCDAsyncDelegate

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
	// This method is executed on the socketQueue (not the main thread)
	
	@synchronized(_connectedSockets)
	{
		[_connectedSockets addObject:newSocket];
	}
	
    NSString* host = [newSocket connectedHost];
	UInt16 port = [newSocket connectedPort];
	
    ZLogInfo(@"Accepted client %@: %hu", host, port);
	
	NSString *welcomeMsg = @"Welcome to the AsyncSocket Echo Server\r\n";
	NSData *welcomeData = [welcomeMsg dataUsingEncoding:NSUTF8StringEncoding];
	
	[newSocket writeData:welcomeData withTimeout:-1 tag:WELCOME_MSG];
	
	[newSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:READ_TIMEOUT tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	// This method is executed on the socketQueue (not the main thread)
	
	if (tag == ECHO_MSG)
	{
		[sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:READ_TIMEOUT tag:0];
	}
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	// This method is executed on the socketQueue (not the main thread)
	
	dispatch_async(dispatch_get_main_queue(), ^{
		@autoreleasepool {
            
			NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length] - 2)];
			NSString *msg = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
			if (msg)
			{
				//[self logMessage:msg];
			}
			else
			{
				//[self logError:@"Error converting received data into UTF-8 String"];
			}
//            [msg release];
		}
	});
	
	// Echo message back to client
	[sock writeData:data withTimeout:-1 tag:ECHO_MSG];
}

/**
 * This method is called if a read has timed out.
 * It allows us to optionally extend the timeout.
 * We use this method to issue a warning to the user prior to disconnecting them.
 **/
- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length
{
	if (elapsed <= READ_TIMEOUT)
	{
		NSString *warningMsg = @"Are you still there?\r\n";
		NSData *warningData = [warningMsg dataUsingEncoding:NSUTF8StringEncoding];
		
		[sock writeData:warningData withTimeout:-1 tag:WARNING_MSG];
		
		return READ_TIMEOUT_EXTENSION;
	}
	
	return 0.0;
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
	if (sock != _serverSocket)
	{
		dispatch_async(dispatch_get_main_queue(), ^{
			@autoreleasepool {
                
				//[self logInfo:FORMAT(@"Client Disconnected")];
                
			}
		});
		
		@synchronized(_connectedSockets)
		{
			[_connectedSockets removeObject:sock];
		}
	}
}


@end
