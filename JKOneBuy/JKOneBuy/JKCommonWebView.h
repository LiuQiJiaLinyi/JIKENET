//
//  JKCommonWebView.h
//  JKOneBuy
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKCommonWebView : UIViewController<UIWebViewDelegate>
{
    NSString * _type_web;
    NSString * _initial_url;
    UIButton *leftbtn;
    UILabel *_lable_web_title;
    
    NSString* proId;
}

@property (nonatomic,strong)NSString *str_to_url;
@property (nonatomic,strong)UIWebView *MWebView;

@end
