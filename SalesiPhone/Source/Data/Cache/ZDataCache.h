//
//  ZDataCache.h
//  eSeller
//
//  Created by ZTaoTech on 13-7-3.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZUserDTO;
@class ZTradeDTO;
@class ZMainView;
@class ZItemCGTradeDTO;
@class ZMyShopsDTO;
@class ZShopDTO;
@class ZItemBarcodeRuleDTO;

@interface ZDataCache : NSObject {
    
    NSMutableDictionary * mArrays;
    NSMutableDictionary * mTotal;
    NSMutableDictionary * mPage;
    
    NSMutableDictionary * mMisc;
     NSNumber* _averageColor;
     NSNumber* _averageSize;
    
     NSNumber* _supportColorSize;
    NSNumber* _supportSingleColorSize;
    NSNumber* _notDisplayItemName;
    NSNumber* _supportDiscount;
    NSNumber* _accountAfterPrint;
    NSNumber* _usePinYinInput;
    NSNumber* _displayBrandCat;
    
    int dataHandleType;
    NSMutableArray *_sizes;
    NSMutableArray* _colors;
}

//我的店铺 关联的店铺
@property(nonatomic)ZMyShopsDTO* myShopsDto;
//我的店铺
@property(nonatomic)ZShopDTO* myShop;

@property (nonatomic ) NSMutableDictionary * mArrays;
@property (nonatomic ) NSMutableDictionary * mTotal;
@property (nonatomic ) NSMutableDictionary * mPage;
@property (nonatomic ) NSMutableDictionary * mMisc;
@property (nonatomic ) ZUserDTO * userDto;

@property (nonatomic ) UIView * psView;

@property (nonatomic ) ZTradeDTO* tradeDto;
@property (nonatomic ) ZItemCGTradeDTO* tradeCGDto;
@property (nonatomic ) ZItemCGTradeDTO* tradeIODto;
@property (nonatomic)  ZItemBarcodeRuleDTO* itemBarcodeRuleDTO;

@property (nonatomic) ZMainView * mainView;

+ (ZDataCache *) sharedInstance;


- (NSMutableArray *) getMutableArrayByKey:(NSString *) key;
- (void) putMutableArray:(NSString *) key array:(NSMutableArray *) array;
- (void) removeMutableArrayByKey:(NSString *) key;

- (NSNumber *) getTotalByKey:(NSString *) key;
- (void) putMutableTotal:(NSString *) key total:(NSNumber *) total;
- (void) removeTotalByKey:(NSString *) key;

- (NSNumber *) getPageByKey:(NSString *) key;
- (void) putMutablePage:(NSString *) key page:(NSNumber *) page;
- (void) removePageByKey:(NSString *) key;

-(void)resetDBCache;
-(BOOL)getIfSupportColorSize;
-(BOOL)getIfSupportSingleColorSize;
-(BOOL)getIfSupportDisCount;
-(BOOL)getIfAccountAfterPrint;
-(BOOL)getIfUsePinYinInput;
-(BOOL)getIfDisplayItemBrandCat;
-(BOOL)getIfNotDisplayItemName;
-(int)getDataHandleType;

-(void)setSwitchValue:(int)key setting:(BOOL)setting;

-(NSString*)getUrlPrefix;

-(NSNumber*)getAverageColorId;
-(NSNumber*)getAverageSizeId;
-(NSArray*)getSizes;
-(NSArray*)getColors;

-(BOOL)isDemoShop;
-(BOOL)isManager;
-(BOOL)isXSY;
-(BOOL)isCGY;
-(BOOL)isBOSS;
-(BOOL)isKDY;
-(BOOL)hasMangerRole;

-(NSString*)getRolesName:(NSString*)role;
-(void)clear;
@end
