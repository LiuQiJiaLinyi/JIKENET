//
//  LatestAnnouncedViewController.h
//  NewOnePay
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAlertView.h"
@interface LatestAnnouncedViewController : UIViewController<UIWebViewDelegate,JKAlertDelegate>
{
    NSString * _type_web;
    NSString * _initial_url;
    UIButton *leftbtn;
    UILabel *_lable_web_title;
    
    NSString* proId;
}

@property (nonatomic,strong)NSString *str_to_url;
@property (nonatomic,strong)UIWebView *MWebView;
@property (nonatomic,strong)NSString *str_mall_ID;
@end
