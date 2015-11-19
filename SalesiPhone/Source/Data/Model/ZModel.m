

#import "ZModel.h"

@implementation ZModel

#pragma mark -
#pragma mark Class methods

+ (id)model {
    return [[[self class] alloc] initWithDictionary:nil];
}

+ (id)modelWithJSON:(NSDictionary *)json {
    if ([json isKindOfClass:[NSDictionary class]]) {
        return [[[self class] alloc] initWithDictionary:json];
    }else{
        return nil;
    }
}

+ (id)modelArrayWithJSON:(NSArray *)jsonArray {
    if ([jsonArray isKindOfClass:[NSArray class]]) {
        Class cls = [self class];
        NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:[jsonArray count]];
        
        for (NSDictionary *dict in jsonArray) {
            NSDictionary *tempDict = [cls modelWithJSON:dict];
            if (tempDict!=nil) {
                [ret addObject:[cls modelWithJSON:dict]];
            }
        }
        
        return ret;
    }else{
        return nil;
    }
    
}

#pragma mark -
#pragma mark Initialize

- (id)init {
    return [self initWithDictionary:nil];
}


- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        //为了保证不因为服务端的数据错误crash
        @try {
            [self setup];
            [self setFromDictionary:dict];
        }
        @catch (NSException *exception) {
            self = nil;
        }
    }
    
    return self;
}


- (void)setup {
}


-(NSDictionary *)keyMapDictionary {
    return nil;
}

- (void)setFromDictionary:(NSDictionary *)dict {
    NSDictionary    *keyMap = [self keyMapDictionary];
    for (NSString *key in [dict keyEnumerator]) {
        
        id val = [dict objectForKey:key];
        
        if ([keyMap objectForKey:key]) {
//            key = [keyMap objectForKey:key];
        }
        
        if ([val isKindOfClass:[NSArray class]]) {
            Class type = [self classForKey:key];
            
            if (type) {
                [self setValue:[type modelArrayWithJSON:val] forKey:key];
            } else {
                [self setValue:val forKey:key];
            }
            
        } else if (![val isKindOfClass:[NSDictionary class]] && ![val isKindOfClass:[NSNull class]]) {
            
            [self setValue:val forKey:key];
            
        } else {
            
            id origVal = [self valueForKey:key];
			
            if ([origVal isKindOfClass:[NSArray class]]) {
                
                NSArray *allKeys = [val allKeys];
                
                if ([allKeys count] > 0) {
                    NSArray *arr = [val objectForKey:[allKeys objectAtIndex:0]];
                    
                    Class type = [self classForKey:key];
                    
                    if (type && [arr isKindOfClass:[NSArray class]]) {
                        [self setValue:[type modelArrayWithJSON:arr] forKey:key];
                    }
                }
                
            } else {
                Class cls = [self classForKey:key];
                if (cls) {
                    [self setValue:[cls modelWithJSON:val] forKey:key];
                } else {
                    [self setValue:val forKey:key];
                }
            }
                                                  
        }
    }
}

#pragma mark -
#pragma mark Key-Value Coding

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  // NSLog("WARNING: [%@] Set value for undefiend key %@", self.description,  key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    //NSLog("WARNING: [%@] Get value for undefiend key %@", [self.description UTF8String], [key UTF8String]);
    return nil;
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSArray *keys = [self keys];
    
    if ([aDecoder allowsKeyedCoding]) {
        for (NSString *key in keys) {
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    } else {
        for (NSString *key in keys) {
            [self setValue:[aDecoder decodeObject] forKey:key];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *keys = [self keys];
    
    if ([aCoder allowsKeyedCoding]) {
        for (NSString *key in keys) {
            [aCoder encodeObject:[self valueForKey:key] forKey:key];
        }
    } else {
        for (NSString *key in keys) {
            [aCoder encodeObject:[self valueForKey:key]];
        }
    }
}

#pragma mark -

- (Class)classForKey:(NSString *)key {
    return NULL;
}

- (NSArray *)keys {
    return nil;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:[[self keys] count]];
    NSArray *keys = [self keys];
    for (NSString *key in keys) {
        id val = [self valueForKey:key];
        if (val && ![val isKindOfClass:[NSNull class]]) {
            [ret setObject:val forKey:key];
        }
    }
    return ret;
}

#pragma mark -
// only support string to number, number to string. this change function 有bug！！！少年们别用 by christ.yuj
+(id)change:(id)temp intoClass:(Class)targetClass{
    if ([temp isKindOfClass:targetClass]) {
        return temp;
    }else if([temp isKindOfClass:[NSString class]]&&targetClass==[NSNumber class]){
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        return [formatter numberFromString:temp];
    }else if([temp isKindOfClass:[NSNumber class]]&&targetClass==[NSString class]){
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        return [formatter stringFromNumber:temp];
    }
    return nil;
}

@end
