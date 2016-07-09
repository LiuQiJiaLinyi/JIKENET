//
//  homeViewController.h
//  NewOnePay
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeModel.h"
#import "OneDollarBuyViewCell.h"
#import "homeOneHeaderView.h"
#import <MJRefresh.h>
#import "JKAlertView.h"
#import "JKWXShare.h"
@interface homeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,homeOneHeaderViewDelegate,JKAlertDelegate>
{
    homeModel *_homeModel;
    UITableView       *mainTableView;
    NSMutableArray    *Array_celldata;
    NSMutableArray    *Array_sort;
    NSInteger pageCount;
    MJRefreshNormalHeader *header;
    MJRefreshAutoNormalFooter *footer;
    
}
@end
