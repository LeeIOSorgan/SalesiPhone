//
//  ZDataCache.m
//  eSeller
//
//  Created by ZTaoTech on 13-7-3.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZDataCache.h"
#import "ZUserDTO.h"
#import "ZArchive.h"
#import "ZItemBarcodeRuleDTO.h"
@implementation ZDataCache

static ZDataCache * zcache = nil;
@synthesize mArrays;
@synthesize mTotal;
@synthesize mPage;
@synthesize mMisc;

+ (ZDataCache *) sharedInstance {
    if(zcache) {
        return zcache;
    }
    zcache = [[ZDataCache alloc] init];
    NSMutableDictionary * marrays = [[NSMutableDictionary alloc] initWithCapacity:5];
    zcache.mArrays = marrays;
    
    NSMutableDictionary * mtotal = [[NSMutableDictionary alloc] initWithCapacity:5];
    zcache.mTotal = mtotal;
    
    NSMutableDictionary * mpage = [[NSMutableDictionary alloc] initWithCapacity:5];
    zcache.mPage = mpage;
    
    NSMutableDictionary * mmisc = [[NSMutableDictionary alloc] initWithCapacity:5];
    zcache.mMisc = mmisc;
    
//    [mtotal release];
//    [mpage release];
//    [mmisc release];
//    [marrays release];
    
    return zcache;
}
- (void) dealloc {
    ZLogInfo(@"---Into----ZDataCache--dealloc-");
    zcache = nil;
    _supportColorSize = nil;
    _supportDiscount = nil;
    _psView = nil;
    _sizes = nil;
    mArrays = nil;
    mTotal = nil;
    mPage = nil;
    mMisc = nil;
}
- (NSMutableArray *) getMutableArrayByKey:(NSString *) key {
    return [self.mArrays objectForKey:key];
}

- (void) putMutableArray:(NSString *) key array:(NSMutableArray *) array {
    
    NSArray * narray = [self.mArrays objectForKey:key];
    if(narray) {
        NSMutableArray* are = [[NSMutableArray alloc] initWithArray:narray];
        [are addObjectsFromArray:array];
        [self.mArrays setValue:are forKey:key];
    } else {
        [self.mArrays setValue:array forKey:key];
    }
}

-(void)addObjectToArray:(NSString*)key obj:(NSObject*)object
{
    NSMutableArray * narray = [self.mArrays objectForKey:key];
    if(narray) {
        NSMutableArray* are = [[NSMutableArray alloc] initWithArray:narray];
        [are addObject:object];
        [self.mArrays setValue:are forKey:key];
    } else {
        [narray addObject:object];
    }
}

- (void) removeMutableArrayByKey:(NSString *)key {
    [self.mArrays removeObjectForKey:key];
}

- (NSNumber *) getTotalByKey:(NSString *) key {
    return [self.mTotal objectForKey:key];
}

- (void) putMutableTotal:(NSString *) key total:(NSNumber *) total {
    ZLogInfo(@"add total is %d", total.intValue);
    [self.mTotal setValue:total forKey:key];
}

- (void) removeTotalByKey:(NSString *)key {
    [self.mTotal removeObjectForKey:key];
}

- (NSNumber *) getPageByKey:(NSString *) key {
    
    NSNumber * number = [self.mPage objectForKey:key];
    if(!number) {
        return [NSNumber numberWithInt:1];
    } else {
        return [self.mPage objectForKey:key];
    }
}

- (void) putMutablePage:(NSString *) key page:(NSNumber *) page {
    [self.mPage setValue:page forKey:key];
}

- (void) removePageByKey:(NSString *)key {
    [self.mPage removeObjectForKey:key];
}

-(void)clear
{
    _userDto = nil;
    _psView = nil;
    [mArrays removeAllObjects];
    [mTotal removeAllObjects];
    [mPage removeAllObjects];
    [mMisc removeAllObjects];
    zcache = nil;
    _supportColorSize = nil;
    _supportDiscount = nil;
    _displayBrandCat= nil;
    [_sizes removeAllObjects];
}

-(NSNumber*)getAverageColorId
{
    if(_averageColor == nil || [_averageColor intValue]== 0) {
        _averageColor = [[ZArchive instance] getAvargeColorID];
    }
    return _averageColor;
}
-(NSNumber*)getAverageSizeId{
    if(_averageSize == nil || [_averageSize intValue]== 0) {
        _averageSize = [[ZArchive instance] getAvargeSizeID];
    }
    return _averageSize;
}

-(NSString*)getUrlPrefix {
    if(_userDto.imageUrl) {
        return _userDto.imageUrl;
    }
    return @"";
}

-(void)resetDBCache
{
    _supportColorSize= nil;
    _supportDiscount = nil;
    _accountAfterPrint = nil;
    _sizes = nil;
}
-(BOOL)getIfSupportColorSize{
    if(_supportColorSize == nil) {
        if ([[ZArchive instance]isSupportColorSize]) {
            _supportColorSize = [NSNumber numberWithBool:YES];
        } else {
            _supportColorSize = [NSNumber numberWithBool:NO];
        }
        return [_supportColorSize intValue];
    }
    return [_supportColorSize intValue];
}
-(BOOL)getIfSupportSingleColorSize{
    if(_supportSingleColorSize == nil) {
        if ([[ZArchive instance]isSupportSingleColorSize]) {
            _supportSingleColorSize = [NSNumber numberWithBool:YES];
        } else {
            _supportSingleColorSize = [NSNumber numberWithBool:NO];
        }
        return [_supportSingleColorSize intValue];
    }
    return [_supportSingleColorSize intValue];
}

-(BOOL)getIfSupportDisCount{
    if(_supportDiscount == nil) {
        if ([[ZArchive instance]isSupportDiscount]) {
            _supportDiscount = [NSNumber numberWithBool:YES];
        } else {
            _supportDiscount = [NSNumber numberWithBool:NO];
        }
        return [_supportDiscount intValue];
    }
    return [_supportDiscount intValue];
}
-(BOOL)getIfAccountAfterPrint{
    if(_accountAfterPrint == nil) {
        if ([[ZArchive instance]isAccountAfterPrint]) {
            _accountAfterPrint = [NSNumber numberWithBool:YES];
        } else {
            _accountAfterPrint = [NSNumber numberWithBool:NO];
        }
        return [_accountAfterPrint intValue];
    }
    return [_accountAfterPrint intValue];
}
-(BOOL)getIfNotDisplayItemName{
    if(_notDisplayItemName == nil) {
        if ([[ZArchive instance]isNotDisplayItemName]) {
            _notDisplayItemName = [NSNumber numberWithBool:YES];
        } else {
            _notDisplayItemName = [NSNumber numberWithBool:NO];
        }
        return [_notDisplayItemName intValue];
    }
    return [_notDisplayItemName intValue];
}
-(BOOL)getIfUsePinYinInput{
    if(_usePinYinInput == nil) {
        if ([[ZArchive instance]isUsePinYinInputKuanHao]) {
            _usePinYinInput = [NSNumber numberWithBool:YES];
        } else {
            _usePinYinInput = [NSNumber numberWithBool:NO];
        }
        return [_usePinYinInput intValue];
    }
    return [_usePinYinInput intValue];
}
-(BOOL)getIfDisplayItemBrandCat{
    if(_displayBrandCat == nil) {
        if ([[ZArchive instance]ifDisplayItemBrandCat]) {
            _displayBrandCat = [NSNumber numberWithBool:YES];
        } else {
            _displayBrandCat = [NSNumber numberWithBool:NO];
        }
        return [_displayBrandCat intValue];
    }
    return [_displayBrandCat intValue];
}
-(void)setSwitchValue:(int)key setting:(BOOL)setting {
    switch (key) {
        case 28:
            _displayBrandCat = [NSNumber numberWithBool:setting];
            break;
        default:
            break;
    }
}
-(int)getDataHandleType{
    if(dataHandleType == 0) {
        dataHandleType = [[ZArchive instance]getDataHandleType];
    }
    return dataHandleType;
}

-(NSArray*)getSizes
{
    if(_sizes == nil) {
        _sizes = [[ZArchive instance]getItemSizeEnabled];
    }
    return _sizes;
}
-(NSArray*)getColors
{
        _colors = [[ZArchive instance]getItemColorEnabled];
//    if(_colors == nil) {
//    }
    return _colors;
}
-(BOOL)isDemoShop
{
    if(_userDto) {
        if([_userDto.shopId intValue] == 2) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isManager{
    if(_userDto) {
        NSRange range = [_userDto.roles rangeOfString:@"manager"];
        if(range.length > 0)
        {
            return YES;
        }
    }
    return NO;
}
-(BOOL)isXSY
{
    if(_userDto) {
        NSRange range = [_userDto.roles rangeOfString:@"xsy"];
        if(range.length > 0)
        {
            return YES;
        }
    }
    return NO;
}
-(BOOL)isCGY
{
    if(_userDto) {
        NSRange range = [_userDto.roles rangeOfString:@"cgy"];
        NSRange range2 = [_userDto.roles rangeOfString:@"manager"];
        if(range.length > 0 || range2.length > 0)
        {
            return YES;
        }
    }
    return NO;
}
-(BOOL)hasMangerRole {
    return [self isManager] || [self isBOSS];
}
-(BOOL)isBOSS
{
    if(_userDto) {
        NSRange range = [_userDto.roles rangeOfString:@"BOSS"];
        if(range.length > 0)
        {
            return YES;
        }
    }
    return NO;
}
-(BOOL)isKDY
{
    if(_userDto) {
        NSRange range = [_userDto.roles rangeOfString:@"kdy"];
        if(range.length > 0)
        {
            return YES;
        }
    }
    return NO;
}

-(NSString*)getRolesName:(NSString*)role
{
    NSMutableString* str = [[NSMutableString alloc]init];
    NSRange range = [role rangeOfString:@"manager"];
    if(range.length > 0){
        [str appendString:@"经理"];
        return str;
    }
    range = [role rangeOfString:@"xsy"];
    if(range.length > 0){
        [str appendString:@"销售员"];
        return str;
    }
    range = [role rangeOfString:@"cgy"];
    if(range.length > 0){
        [str appendString:@"采购员"];
        return str;
    }
    range = [role rangeOfString:@"kdy"];
    if(range.length > 0){
        [str appendString:@"开单员"];
        return str;
    }
    return @"未知";
}

@end
