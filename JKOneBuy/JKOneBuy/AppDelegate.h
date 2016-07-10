//
//  AppDelegate.h
//  JKOneBuy
//
//  Created by teaplant on 16/6/20.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarViecController.h"
#import "WXApi.h"
#import "define.h"
#import "JKWeixinLoginRequest.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate,JKWeixinRequestDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(retain,nonatomic)MainTabBarViecController* mainTab;

- (void)setupTabViewController;
@end

