//
//  ZJson.m
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import "ZJson.h"

//https://github.com/elado/jastor
//http://blog.csdn.net/ck89757/article/details/7928073%20

@implementation ZJson

- (void)test{
    //NSJSONSerialization* tt = nil;
}

- (id)parse:(NSData*)jsonData
{
    if (1) //[NSJSONSerialization isValidJSONObject:jsonData])
    {
        unsigned long x = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments;
        NSError* error = nil;
        
        NSData* jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:x error:&error];
        
        if ([jsonObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
            NSLog(@"Dersialized JSON Dictionary = %@", deserializedDictionary);
        }
        else if ([jsonObject isKindOfClass:[NSArray class]])
        {
            NSArray *deserializedArray = (NSArray *)jsonObject;
            NSLog(@"Dersialized JSON Array = %@", deserializedArray);
        }
        else
        {
            NSLog(@"An error happened while deserializing the JSON data.");
        }
        
        return jsonObject;
    }
    
    return nil;
}

@end
