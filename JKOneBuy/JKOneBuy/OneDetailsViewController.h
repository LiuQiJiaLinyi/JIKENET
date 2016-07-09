//
//  OneDetailsViewController.h
//  JKOneBuy
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneLookLuckNumberView.h"
#import "OneDetailsLookWebView.h"
#import "JKWXShare.h"
#import "JKAlertView.h"
#import "JKWXPay.h"
#import "JKYYPaySuccessController.h"
#import "JKEncrypt.h"
#import "JKCommonWebView.h"
@interface OneDetailsViewController : UIViewController<UIScrollViewDelegate,OneLookLuckNumberViewDelegate,JKAlertDelegate>
{
    UIScrollView* mainScroll;
    UIButton* nowBuyBtn; //立即购买
    UIView* buyBackView;
    OneLookLuckNumberView *lucklooknumberView;
    
     NSDictionary *_payDict;   //保存提交订单的返回信息
}


@property (nonatomic,copy)NSString *str_one_yyid;
@property (nonatomic,copy)NSString *str_one_weid;


@property(retain,nonatomic)UIButton* reduceBtn;
@property(retain,nonatomic)UIButton* addBtn;
@property(retain,nonatomic)UILabel* numLab;
@property(retain,nonatomic)UILabel* Lab_money;
@end
