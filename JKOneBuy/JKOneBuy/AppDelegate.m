//
//  AppDelegate.m
//  JKOneBuy
//
//  Created by teaplant on 16/6/20.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "AppDelegate.h"
#import "homeViewController.h"
#import "LatestAnnouncedViewController.h"
#import "ShoppingCartViewController.h"
#import "personViewController.h"
#import "JKLoginViewController.h"

@interface AppDelegate ()
{
  BOOL userIsLogIn;//记录用户是否已经登录
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //引导页相关
    /*
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        
        [self gotoGuide];
    }
    else
    {
        NSLog(@"不是第一次启动");
        
        
        [self setupTabViewController];
        
    }

    */
    
        [self setupTabViewController];
    
    [self.window makeKeyAndVisible];
    
    
    [WXApi registerApp:APP_ID withDescription:@"播播购"];

    
    [self setupTabViewController];
    return YES;
}
-(void)gotoGuide{
    
}
- (void)setupTabViewController{
    
    
    self.mainTab=[[MainTabBarViecController alloc]init];
    
    
    
    //主页
    homeViewController* homeVc=[[homeViewController alloc]init];
    
    homeVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"home_icon.png"] selectedImage:[UIImage imageNamed:@"home_icon_sel.png"]];
    UINavigationController* homeNav=[[UINavigationController alloc]initWithRootViewController:homeVc];
    //最新揭晓
    LatestAnnouncedViewController* latestAnnouncedVc=[[LatestAnnouncedViewController alloc]init];
    latestAnnouncedVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"最新揭晓" image:[UIImage imageNamed:@"LatestAnnounced.png"] selectedImage:[UIImage imageNamed:@"LatestAnnounced_sel.png"]];
    UINavigationController* latestANav=[[UINavigationController alloc]initWithRootViewController:latestAnnouncedVc];
    
    //购物车
    ShoppingCartViewController *shopCarVC = [[ShoppingCartViewController alloc]init];
    shopCarVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[UIImage imageNamed:@"shopingcar.png"] selectedImage:[UIImage imageNamed:@"shopingcar_sel.png"]];
    UINavigationController *shopCarNav = [[UINavigationController alloc]initWithRootViewController:shopCarVC];
    
    //个人中心
    
    
    NSString * logState = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLogState"];
    
    UINavigationController* personNav;
    if ([logState isEqualToString:@"1"])
    {
        personViewController* personVc=[[personViewController alloc]init];
        personVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"个人中心" image:[UIImage imageNamed:@"personVC.png"] selectedImage:[UIImage imageNamed:@"personVC_sel.png"]];
        personNav=[[UINavigationController alloc]initWithRootViewController:personVc];
    }
    else
    {
        JKLoginViewController * jklogin = [[JKLoginViewController alloc] init];
        jklogin.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"登录" image:[UIImage imageNamed:@"personVC.png"] selectedImage:[UIImage imageNamed:@"personVC_sel.png"]];
        jklogin.mainTabbr = _mainTab;
        
        personNav=[[UINavigationController alloc]initWithRootViewController:jklogin];
        
        
    }
    
//    personViewController* personVc=[[personViewController alloc]init];
//    personVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"个人中心" image:[UIImage imageNamed:@"personVC.png"] selectedImage:[UIImage imageNamed:@"personVC_sel.png"]];
//    UINavigationController* personNav=[[UINavigationController alloc]initWithRootViewController:personVc];
    
    
    
    NSArray* viewCons=[[NSArray alloc]initWithObjects:homeNav,latestANav,shopCarNav,personNav, nil];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:233.0/255.0 green:46.0/255.0 blue:106.0/255.0 alpha:1.0]];
    
     
    
    self.mainTab.delegate=self;
    
    
    [self.mainTab setViewControllers:viewCons animated:NO];
    
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:self.mainTab.view
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished)
     {
         self.window.rootViewController=self.mainTab;
         
     }];
    
    if (self.window.rootViewController.view) {
        
    }else{
        self.window.rootViewController=self.mainTab;
    }
    
}
#pragma mark -- 第三方 --
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
}
//IOS9
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark ---------weixin--------------
-(void) onReq:(BaseReq*)req{
    
}
-(void) onResp:(BaseResp*)resp{
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //        [[JKProgressHuD shareJKProgressHuD] showProgreessText:@"aaa" andView:self.window];
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        NSLog(@"%@",response.lang);
        NSLog(@"%@",response.country);
    }
    else if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PAY_STATE" object:@"1"];
                break;
            case WXErrCodeUserCancel:
                //取消
                NSLog(@"支付取消");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PAY_STATE" object:@"2"];
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PAY_STATE" object:@"3"];
                break;
        }
    }else if([resp isKindOfClass:[SendAuthResp class]]) {
        int errCode = resp.errCode;
        if (errCode == 0) {
            SendAuthResp *aresp = (SendAuthResp *)resp;
            NSString *code = aresp.code;
            NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",APP_ID,APP_SECRET,code];
//            [self sendWXShouQuanRequest:url];
        }else {
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
