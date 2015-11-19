//
//  ZInventoryHandleRecord.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-12-29.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZInventoryHandleDTO.h"

@implementation ZInventoryHandleDTO

-(NSString*)createdOn{
    if(_createdOn) {
        float time = [_createdOn floatValue];
        NSDate* d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        return [formatter stringFromDate:d];
    }
    return nil;
}
@end
