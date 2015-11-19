//
//  ZUserService.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-8-16.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZUserService.h"
#import "HttpManager.h"
#import "ZUtility.h"
#import "ZQueryItemConditionDTO.h"
#import "ZShopSalerDTO.h"

#define urlUser [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user"]
#define urlUserQry [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user?%@"]
#define urlUserEn [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user/enable/%@"]
#define urlUserDis [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user/disable/%@"]
#define urlUserPwdChange [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user/password"]
#define urlUserPwdReset [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user/password/reset?userId=%@"]
#define urlUserMySelf [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user/info"]
#define urlUserUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"user/update"]

#define urlSalerRecordQuery [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"saler/query"]
#define urlSalerMonthlyRecordQuery [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"saler/querymonthly"]
#define urlSalerQuery [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"saler/querysaler"]
#define urlSalerAdd [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"saler/create"]
#define urlSalerUpdate [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"saler/update"]
#define urlSalerDel [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"saler/delete/%@"]
#define urlSalerClean [NSString stringWithFormat:@"%@%@", kHttpPrefix,@"saler/clean/saledfee/%@"]

@implementation ZUserService

-(void)querySalerMonthlyRecords:(ZQueryItemConditionDTO*)conditionDTO type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"sortDirection=desc&%@", tmps];
    hp.strUrl = urlSalerMonthlyRecordQuery;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZSalerRecordPage";
    hp.delegate = delegate;
    hp.requestObj= conditionDTO;
    hp.type = kSalerMonthlyRecord_Query;
    
    ZLogInfo(@"Request Service querySaler type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)querySalerRecords:(ZQueryItemConditionDTO*)conditionDTO type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"sortDirection=desc&%@", tmps];
    hp.strUrl = urlSalerRecordQuery;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZSalerRecordPage";
    hp.delegate = delegate;
    hp.requestObj= conditionDTO;
    hp.type = kSalerRecord_Query;
    
    ZLogInfo(@"Request Service querySaler type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];

}
-(void)querySaler:(ZQueryItemConditionDTO*)conditionDTO type:(id)delegate {
    
    HttpParam* hp = [[HttpParam alloc] init];
    //    NSString* param = [NSString stringWithFormat:@"sortDirection=desc&%@", tmps];
    hp.strUrl = urlSalerQuery;
    hp.strMethod = @"POST";
    hp.respClassType =@"ZShopSalersPage";
    hp.delegate = delegate;
    hp.requestObj= conditionDTO;
    hp.type = kSaler_Query;
    
    ZLogInfo(@"Request Service querySaler type = %d", hp.type);
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}

//可用的查询参数：name，shopName
-(void)queryUsers:(NSMutableDictionary*)params type:(id)delegate {
    NSString *param = [ZUtility parametersWithDic:params];
    HttpParam* hp = [[HttpParam alloc] init];
    if(!params && params.count == 0) {
        hp.strUrl = urlUser;
    } else {
        hp.strUrl = [NSString stringWithFormat:urlUserQry, param];
    }
    hp.strMethod = @"GET";
    hp.respClassType =@"ZUserDTO";
    hp.delegate = delegate;  
    hp.isArray = YES;
    hp.type = kUser_Query;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}
-(void)queryLoginAccount:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlUserMySelf;
    hp.strMethod = @"GET";
    hp.respClassType =@"ZUserDTO";
    hp.delegate = delegate;
    hp.type = kUser_LogInAccount;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)updateLoginUser:(ZUserDTO *)user1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlUserUpdate;
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    hp.requestObj = user1;
    hp.type = kUser_Update;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)addSaler:(ZShopSalerDTO*)user1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlSalerAdd;
    hp.strMethod = @"POST";
    hp.respClassType=@"ZShopSalerDTO";
    hp.delegate = delegate;
    hp.requestObj = user1;
    hp.type = kSaler_Add;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)updateSaler:(ZShopSalerDTO*)user1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlSalerUpdate;
    hp.strMethod = @"POST";
    hp.respClassType=@"ZShopSalerDTO";
    hp.delegate = delegate;
    hp.requestObj = user1;
    hp.type = kSaler_Update;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)deleteSaler:(ZShopSalerDTO*)user1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlSalerDel, user1.salerId];
    hp.strMethod = @"POST";
    hp.respClassType=@"ZShopSalerDTO";
    hp.delegate = delegate;
    hp.type = kSaler_Del;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)cleanSaledFee:(NSNumber*)userId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString  stringWithFormat:urlSalerClean, userId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;
    hp.type = kSaler_Clean;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)addUser:(ZUserDTO*)user1 type:(id)delegate{
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlUser;
    hp.strMethod = @"POST";
    hp.respClassType=@"ZUserDTO";    
    hp.delegate = delegate;  
    hp.requestObj = user1;
    hp.type = kUser_Add;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
    
}
-(void)resetUserPwd:(NSNumber*)userId type:(id)delegate{
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString stringWithFormat:urlUserPwdReset, userId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;  
    hp.type = kUser_PwdReset;
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

-(void)changeUserPwd:(ZUserDTO*)user type:(id)delegate{
//    ZUserDTO *user = [[ZUserDTO alloc] init];
//    user.userId= userId;
//    user.password =pwd;
//    user.passwordNew =pwdNew;
    
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = urlUserPwdChange;
    hp.strMethod = @"PUT";
    hp.respClassType=@"ZUserDTO";
    hp.delegate = delegate;  
    hp.requestObj = user;
    hp.type = kUser_PwdChange;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}


-(void)enableUser:(NSNumber*)userId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString  stringWithFormat:urlUserEn, userId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;  
    hp.type = kUser_En;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}


-(void)disableUser:(NSNumber*)userId type:(id)delegate {
    HttpParam* hp = [[HttpParam alloc] init];
    hp.strUrl = [NSString  stringWithFormat:urlUserDis, userId];
    hp.strMethod = @"PUT";
    hp.delegate = delegate;  
    hp.type = kUser_Dis;
    
    HttpManager* hm = [HttpManager getInstance];
    [hm postHttpRequest:hp];
}

@end
