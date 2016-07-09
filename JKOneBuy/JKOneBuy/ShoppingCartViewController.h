//
//  ShoppingCartViewController.h
//  NewOnePay
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "OneYiyuanModel.h"
#import "JKEncrypt.h"
#import "JKWXPay.h"
#import "JKYYPaySuccessController.h"
#import "JKCommonWebView.h"
#import "JKLoginViewController.h"
@interface ShoppingCartViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIButton         * btn_edit;
    FMDatabase       * db_shop_car;
    UITableView      * mainTableView;
    NSMutableArray   * dataArray;
    
    UILabel          * totalLab;
    UIView           * bottomView;
    UIButton         * allSelectBtn;
    UIButton         * setBtn;
    
    NSDictionary     *_payDict;   //保存提交订单的返回信息
    
    UIView           * doneView;
    CGPoint           tableViewPoint;
    
    UIView           *empty_bac_view;   //数据为空的view
}

@end
