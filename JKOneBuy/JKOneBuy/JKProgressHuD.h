//
//  JKProgressHuD.h
//  ELWashCar
//
//  Created by teaplant on 15/11/13.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MBProgressHUD;
@interface JKProgressHuD : NSObject{

    MBProgressHUD *hud;
    MBProgressHUD *cacheHud;
}

+(id)shareJKProgressHuD;

-(void)showProgreessHuD:(NSString *)messgae andView:(UIView *)view;
-(void)showProgreessText:(NSString *)messgae andView:(UIView *)view;

-(void)dismiss;

-(void)showCacheProgreessHuD:(NSString *)messgae andView:(UIView *)view;
-(void)dismissCache;

@end
