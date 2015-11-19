
#import <Foundation/Foundation.h>


@interface ZModel : NSObject <NSCoding> {

}


+ (id)model;

+ (id)modelWithJSON:(NSDictionary*)json;

+ (NSArray *)modelArrayWithJSON:(NSArray *)jsonArray;

- (id)initWithDictionary:(NSDictionary *)dict;

- (void)setup;

-(NSDictionary *)keyMapDictionary;

- (Class)classForKey:(NSString*)key;


- (void)setFromDictionary:(NSDictionary*)dict;

- (NSArray *)keys;

- (NSDictionary*)toDictionary;

// only support string to number, number to string.
+(id)change:(id)temp intoClass:(Class)targetClass;

@end
