//
//  MainTabBarViecController.m
//  NewOnePay
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MainTabBarViecController.h"
#import "GlobalObject.h"
@implementation MainTabBarViecController
-(void)viewDidLoad
{
        
    
    //改变tabbar 线条颜色
    [self.tabBar setShadowImage:[self createImageWithColor:[GlobalObject colorWithHexString:@"#F6F6F6"]]];
    [self.tabBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]];
    
}
//UIColor 转UIImage
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}
@end
