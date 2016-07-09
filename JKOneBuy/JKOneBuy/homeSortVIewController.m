//
//  homeSortVIewController.m
//  JKOneBuy
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "homeSortVIewController.h"
#import <SVProgressHUD.h>
#import "JKProgressHuD.h"
#import "AFAppDotNetAPIClient.h"
#import "define.h"
#import <MJExtension/MJExtension.h>
#import "GlobalObject.h"
#import "homeSortCell.h"
#import "LQJSortCell/LQJJKSortViewController.h"

@implementation homeSortVIewController
-(void)navigationBarModel{
    
    
    self.navigationItem.title = @"分类";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.navigationController.navigationBar.barTintColor=[GlobalObject colorWithHexString:@"#ED4D80"];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftbtn addTarget:self action:@selector(backToMessageVC) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"nav_bar_left_new.png"] forState:UIControlStateNormal];
    [leftbtn setFrame:CGRectMake( 0, 0, 12*kFloatSize, 17*kFloatSize)];
    UIBarButtonItem *leftItem  =[[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
}
-(void)backToMessageVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadMainView{
    
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    mainTableView=[[UITableView alloc]init];
    mainTableView.frame=frame;
    mainTableView.backgroundColor=[UIColor whiteColor];
    
    mainTableView.separatorColor=[UIColor clearColor];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
   
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
    mainTableView.showsVerticalScrollIndicator=NO;
    
    
   
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    Array_celldata=[[NSMutableArray alloc]init];
       
    [self loadMainView];
    [self getTableCellData];
    [self navigationBarModel];
    
}
//分类
-(void)getTableCellData{
    
    [[AFAppDotNetAPIClient sharedClient]GET:BBG_SORT parameters:nil progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [[JKProgressHuD shareJKProgressHuD] dismiss];

            if ([[responseObject objectForKey:@"code"] integerValue]==200) {
                
                if (Array_celldata) {
                    [Array_celldata removeAllObjects];
                }
                [Array_celldata addObjectsFromArray:[responseObject objectForKey:@"sort"]];
            }else{
                
            }
            
            [mainTableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        NSLog(@"%@%s",error,__FUNCTION__);
        
    }];

}

#pragma mrak-
#pragma mark --tableView代理函数
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45*kFloatSize;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return Array_celldata.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    homeSortCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[homeSortCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    cell.backgroundColor=[UIColor clearColor];
    
         NSDictionary*parDic=[[NSDictionary alloc]initWithDictionary:[Array_celldata objectAtIndex:indexPath.row]];
    
    [cell CreateViewDict:parDic];
    
    return cell;
    
}

#pragma mark --cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     http://c.app.zckj.159.net/API/Api.ashx?action=mall_yyg_class&cid=1&weid=nBcWr11319
     */
    
    NSString * urlSort = [NSString stringWithFormat:@"http://c.app.zckj.159.net/API/Api.ashx?action=mall_yyg_class&cid=%@&weid=nBcWr11319",Array_celldata[indexPath.row][@"pro_id"]];
    
    LQJJKSortViewController * lqjJKSort = [[LQJJKSortViewController alloc] init];
    lqjJKSort.name_sort = Array_celldata[indexPath.row][@"pro_name"];
    lqjJKSort.str_url = urlSort;
    
    [self.navigationController pushViewController:lqjJKSort animated:YES];

}
@end
