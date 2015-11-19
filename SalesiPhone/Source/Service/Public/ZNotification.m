//
//
//  Created by on 12/5/12.
//  Copyright (c) 2012 All rights reserved.
//

#import "ZNotification.h"

@implementation ZNotification

+ (ZNotification*)sharedInstance {
    static ZNotification* _notification = nil;
    if (_notification == nil) {
        _notification = [[ZNotification alloc] init];
    }
    
    return _notification;
}

#pragma mark -
#pragma mark notification methods

- (void)registerObserver:(id)observer selector:(SEL)sel message:(NSString*)msg {
    [self removeObserver:observer message:msg];
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:observer selector:sel name:msg object:nil];
}

- (void)removeObserver:(id)observer message:(NSString*)msg {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:observer name:msg object:nil];
}

- (void)removeObserver:(id)observer{
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:observer];
}

- (void)notify:(NSString*)message {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:message object:nil];
}

- (void)notify:(NSString*)message sender:(id)sender {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:message object:sender];
}

- (void)notify:(NSString*)message userInfo:(NSDictionary*)info{
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:message object:nil userInfo:info];
}

- (void)notify:(NSString*)message sender:(id)sender userInfo:(NSDictionary*)info{
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:message object:sender userInfo:info];
}


@end
