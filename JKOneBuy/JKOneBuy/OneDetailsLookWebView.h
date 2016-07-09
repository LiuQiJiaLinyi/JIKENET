//
//  OneDetailsLookWebView.h
//  BoBoBuy
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JKAlertView.h"
@interface OneDetailsLookWebView : UIViewController<UIWebViewDelegate,JKAlertDelegate>
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
