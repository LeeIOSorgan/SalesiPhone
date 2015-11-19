//
//  ZTestUserService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-25.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZTestUserService.h"
#import "ZUserService.h"
#import "ZServiceFactory.h"
#import "ZRequestInc.h"


@implementation ZTestUserService

-(void)testUserService {
    ZUserService *zusers = [[ZServiceFactory sharedService]getUserService];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [zusers queryUsers:dic type:self];
//    [dic release];
    ZUserDTO *user = [[ZUserDTO alloc] init];
    user.nickName=@"花花";
    user.username=@"王小艳";
    user.roles = @"经理，销售员";
    //    user.roletype= [NSNumber numberWithInt:1];
    user.sfzm=@"422422198708034567";
    user.telephone=@"13587654321";
    user.memo=@"这是一个好员工";
    [zusers addUser:user type:self];
//    [user release];
}

- (void)handleResponse:(ZResponse*)response
{
    switch (response.businessType) {
        case kUser_Query:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                    if ([response.respObj isKindOfClass:[NSArray class]]){
                        NSArray *array = (NSArray*) response.respObj;
                        for(id tmpObj in array) {
                            if([tmpObj isKindOfClass:[ZUserDTO class]]) {
                                ZUserDTO *obj = (ZUserDTO*)tmpObj;
                                ZLogInfo(@"Query User succeed = %@", obj.nickName);
                            }
                        }
                        ZLogInfo(@"Query User succeed = %d", [array count]);
                    }
                }
            } else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kUser_Add:
            if (response.code.code == 200 || response.code.code == 204) {
                if (response.respObj) {
                    if([response.respObj isKindOfClass:[ZUserDTO class]]) {
                        ZUserDTO *user = (ZUserDTO*)response.respObj;
                        ZLogInfo(@"Add User succeed = %@", user.roles);
                        ZUserService *zusers = [[ZServiceFactory sharedService]getUserService];
                        [zusers disableUser:user.userId type:self];
                    }
                }
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            
            break;
        case kUser_Dis:
            if (response.code.code == 200 || response.code.code == 204) {
                ZLogInfo(@"Disable User succeed");
                ZUserService *zusers = [[ZServiceFactory sharedService]getUserService];
                [zusers enableUser:_userId type:self];
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
        case kUser_En:
            if (response.code.code == 200 || response.code.code == 204) {
                ZLogInfo(@"Enable User succeed %d", response.businessType);
            }else {
                ZLogInfo(@" Error  = %d",response.businessType);
            }
            break;
            default:
            break;
    }
}

@end
