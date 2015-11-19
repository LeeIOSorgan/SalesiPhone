//
//  ZKuaiDiInfoService.h
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-10-9.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCustomerPrintInfoDTO;

@interface ZKuaiDiInfoService : NSObject

-(void)queryAllKuaiDi:(id)delegate;
-(void)queryMyKuaiDiList:(id)delegate;
-(void)updateMyKuaiDiInfo:(NSArray*)dtos used:(BOOL)enable type:(id)delegate;
-(void)sentPrintKuaiDiRequest:(ZCustomerPrintInfoDTO*)dto type:(id)delegate;

@end
