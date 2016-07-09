//
//  JKProgressHuD.m
//  ELWashCar
//
//  Created by teaplant on 15/11/13.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import "JKProgressHuD.h"
#import "MBProgressHUD.h"
#import <UIImage+GIF.h>
#import "GlobalObject.h"
#import "define.h"
@implementation JKProgressHuD

+(id)shareJKProgressHuD{

    static JKProgressHuD *shareJKProgressHuD=nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        shareJKProgressHuD=[[self alloc]init];
    });
    
    return shareJKProgressHuD;
}

-(void)showProgreessHuD:(NSString *)messgae andView:(UIView *)view{

    if (hud == nil) {
        hud=[[MBProgressHUD alloc]initWithView:view];
    }
    
    [view addSubview:hud];
    hud.labelText=messgae;
    hud.square = YES;//设置显示框的高度和宽度一样
    hud.mode=MBProgressHUDModeCustomView;
    
    
    
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30*kFloatSize, 30*kFloatSize)];
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"ring1"],
                         [UIImage imageNamed:@"ring2"],
                         [UIImage imageNamed:@"ring3"],
                         [UIImage imageNamed:@"ring4"],
                         [UIImage imageNamed:@"ring5"],
                         [UIImage imageNamed:@"ring6"],
                         [UIImage imageNamed:@"ring7"],
                         [UIImage imageNamed:@"ring8"],                        [UIImage imageNamed:@"ring9"],
                         [UIImage imageNamed:@"ring10"],
                         [UIImage imageNamed:@"ring11"],
                         [UIImage imageNamed:@"ring12"],nil];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 0.8f; //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 0;  //动画重复次数
    [gifImageView startAnimating];
    

    
    
    
    
    hud.customView=gifImageView;
    
    hud.color=[UIColor grayColor];
    
    
    [hud show:YES];
    
    [hud hide:YES afterDelay:10.0f];

}
-(void)dismiss{

    [hud hide:YES];
    
}
-(void)showProgreessText:(NSString *)messgae andView:(UIView *)view{
    
    if (hud == nil) {
        hud=[[MBProgressHUD alloc]initWithView:view];
    }
    
    [view addSubview:hud];
    hud.labelText=messgae;
    hud.mode=MBProgressHUDModeText;
    hud.square = NO;
    hud.color=[GlobalObject colorWithHexString:@"#082416"];
   // hud.labelColor=[GlobalObject colorWithHexString:@"#F6FFFB"];
    
    

    hud.margin = 10.f;
    hud.yOffset = -20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
}

-(void)showCacheProgreessHuD:(NSString *)messgae andView:(UIView *)view
{
    if (cacheHud == nil) {
        cacheHud=[[MBProgressHUD alloc]init];
    }
    [view addSubview:cacheHud];
    cacheHud.labelText=messgae;
    cacheHud.square = YES;//设置显示框的高度和宽度一样
    cacheHud.mode=MBProgressHUDModeCustomView;
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30*kFloatSize, 30*kFloatSize)];
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"ring1"],
                         [UIImage imageNamed:@"ring2"],
                         [UIImage imageNamed:@"ring3"],
                         [UIImage imageNamed:@"ring4"],
                         [UIImage imageNamed:@"ring5"],
                         [UIImage imageNamed:@"ring6"],
                         [UIImage imageNamed:@"ring7"],
                         [UIImage imageNamed:@"ring8"],
                         [UIImage imageNamed:@"ring9"],
                         [UIImage imageNamed:@"ring10"],
                         [UIImage imageNamed:@"ring11"],
                         [UIImage imageNamed:@"ring12"],nil];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 0.8f; //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 0;  //动画重复次数
    [gifImageView startAnimating];
    
    cacheHud.customView=gifImageView;
    
    cacheHud.color=[UIColor colorWithWhite:0 alpha:0.4];
    [cacheHud show:YES];

}
-(void)dismissCache
{
    [hud hide:YES];
    [cacheHud hide:YES];
}
@end
