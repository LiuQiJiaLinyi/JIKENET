//
//  homeSortVIewController.h
//  JKOneBuy
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
@interface homeSortVIewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView       *mainTableView;
    NSMutableArray    *Array_celldata;
}
@end
