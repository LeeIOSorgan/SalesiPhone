//
//  ZTestCustomerService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-25.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTestCustomerService.h"
#import "ZServiceFactory.h"
#import "ZRequestInc.h"
#import "ZCustomerService.h"
#import "ZCustomerDTO.h"

@implementation ZTestCustomerService
-(void)testCustomerService{
    ZCustomerService *zusers = [[ZServiceFactory sharedService]getCustomerService];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"all" forKey:@"customerType"];
    [zusers queryAllCustomers:params type:self];
//     
    ZCustomerDTO * custDto = [[ZCustomerDTO alloc]init];
    custDto.name =@"王小欢";
    custDto.telephone = @"1384495033";
    custDto.address =@"djfdklajfldaj";
    custDto.kuaiDiName=@"ShunFeng";
    custDto.memo=@"dajkl";
    [zusers createCustomer:custDto type:self];
//    [custDto release];
}

- (void)handleResponse:(ZResponse*)response
{
    switch (response.businessType) {
        case kCustomer_Qry:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                    if ([response.respObj isKindOfClass:[NSArray class]]){
                        NSArray *array = (NSArray*) response.respObj;
                        for(id tmpObj in array) {
                            if([tmpObj isKindOfClass:[ZCustomerDTO class]]) {
                                ZCustomerDTO *obj = (ZCustomerDTO*)tmpObj;
                                ZLogInfo(@"Query User succeed = %@", obj.name);
                            }
                        }
                        ZLogInfo(@"Query User succeed = %d", [array count]);
                    }
                }
            } else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kCustomer_Create:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                    if([response.respObj isKindOfClass:[ZCustomerDTO class]]) {
                        ZCustomerDTO *user = (ZCustomerDTO*)response.respObj;
                        ZLogInfo(@"Add ZCustomerDTO succeed = %@", user.name);
                    }
                }
            }
            break;
            
            
    }
}
@end
