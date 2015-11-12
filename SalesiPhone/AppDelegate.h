//
//  AppDelegate.h
//  SalesiPhone
//
//  Created by Leejun on 15/11/12.
//  Copyright © 2015年 Leejun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readwrite, nonatomic) WYTabBarViewController* mainTabViewController;

- (void)signIn;
- (void)signOut;

@end

