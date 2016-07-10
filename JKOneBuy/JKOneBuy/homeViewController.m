//
//  homeViewController.m
//  NewOnePay
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "homeViewController.h"
#import <SVProgressHUD.h>
#import "JKProgressHuD.h"
#import "AFAppDotNetAPIClient.h"
#import "define.h"
#import <MJExtension/MJExtension.h>
#import "GlobalObject.h"
#import "OneDetailsViewController.h"

#import "LQJSortCell/LQJJKSortViewController.h"
#import "JKSortViewController.h"
#import "homeSortVIewController.h"

@implementation homeViewController
-(void)navigationBarModel{
    
    
    self.navigationItem.title = @"一元抢购";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]};
   
     self.navigationController.navigationBar.barTintColor=[GlobalObject colorWithHexString:@"#ED4D80"];
    
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn_right addTarget:self action:@selector(shareToVC) forControlEvents:UIControlEventTouchUpInside];
    [btn_right setBackgroundImage:[UIImage imageNamed:@"home_share.png"] forState:UIControlStateNormal];
    [btn_right setBackgroundImage:[UIImage imageNamed:@"home_share_sel.png"] forState:UIControlStateSelected];
    [btn_right setFrame:CGRectMake(0, 0, 20*kFloatSize, 20*kFloatSize)];
    UIBarButtonItem *rightItem  =[[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
#pragma mark-
#pragma mark ---分享---
-(void)shareToVC{
    NSDictionary *dict=@{@"title":@"微信分享",
                         @"cancelBtnTitle":@"取消",
                         @"otherTitles":@[@"发送给好友",@"分享到朋友圈"]
                         };
    JKAlertView *alert = [JKAlertView shareInstance];
    [alert showWithInfo:dict withAlertStyle:NSAlertStyleAction WithDelegate:self];
}
-(void)alertView:(JKAlertView *)alertView clickBtnTitle:(NSString *)title{
    if ([title isEqualToString:@"发送给好友"]) {
        //好友
        [self weixinSharewithWechatShareType:NSWechatShareTypeSceneSession];
    }else if([title isEqualToString:@"分享到朋友圈"]){
        //朋友圈
        [self weixinSharewithWechatShareType:NSWechatShareTypeSceneTimeline];
    }
}
-(void)weixinSharewithWechatShareType:(NSWechatShareType)type{
//    NSString *title = [NSString stringWithFormat:@"%@",DollaModel.sharetitle];
//    //    title = [self base64jiemiWithStr:[JKEncrypt returnJiemiStringWithString:title]];
//    NSString *des = [NSString stringWithFormat:@"%@",DollaModel.sharedesc];
//    //    des = [self base64jiemiWithStr:[JKEncrypt returnJiemiStringWithString:des]];
//    NSString *img = [NSString stringWithFormat:@"%@",DollaModel.shareimg];
//    //    img = [self base64jiemiWithStr:[JKEncrypt returnJiemiStringWithString:img]];
//    NSString *linkurl =[NSString stringWithFormat:@"%@",DollaModel.sharelinkurl];
//    //    linkurl = [self base64jiemiWithStr:[JKEncrypt returnJiemiStringWithString:linkurl]];
//    [JKWXShare WXShareWithTitle:title withDescription:des withImageURL:img withWebURL:linkurl withWXScene:type];
}
-(void)loadMainView{
    
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    mainTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    mainTableView.frame=frame;
    mainTableView.backgroundColor=[GlobalObject colorWithHexString:@"#F9FAFB"];
    
    mainTableView.separatorColor=[UIColor clearColor];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    mainTableView.sectionFooterHeight = 0;
    //    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
    mainTableView.showsVerticalScrollIndicator=NO;
    
    
    header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];

    // 马上进入刷新状态
//    [header beginRefreshing];
//
    // 设置刷新控件
    mainTableView.mj_header = header;
    
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:@"上拉加载" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    // 设置footer
    mainTableView.mj_footer = footer;
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    Array_celldata=[[NSMutableArray alloc]init];
    Array_sort=[[NSMutableArray alloc]init];
    pageCount=1;

    [self loadMainView];
    
    [self navigationBarModel];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getHomeHeadNews];
}
-(void)getHomeHeadNews{
    [[JKProgressHuD shareJKProgressHuD]showProgreessHuD:@"加载中" andView:self.view];
    
    [[AFAppDotNetAPIClient sharedClient]GET:BBG_ONEDOLLAR parameters:nil progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject objectForKey:@"code"] integerValue]==200) {
                homeModel * model=[homeModel mj_objectWithKeyValues:responseObject];
                
                _homeModel=model;
                
                [self getSortData];
               
            }else{
                
            }
            
            [[JKProgressHuD shareJKProgressHuD] dismiss];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        NSLog(@"aaaaaa=%@",error);
        
    }];
    
    
    
}
//分类
-(void)getSortData{
    [[AFAppDotNetAPIClient sharedClient]GET:BBG_SORT parameters:nil progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject objectForKey:@"code"] integerValue]==200) {
               
                if (Array_sort) {
                     [Array_sort removeAllObjects];
                }
                [Array_sort addObjectsFromArray:[responseObject objectForKey:@"sort"]];
            }else{
                
            }
            
             [self getTableCellData];
            [[JKProgressHuD shareJKProgressHuD] dismiss];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        NSLog(@"aaaaaa=%@",error);
        
    }];

}
-(void)getTableCellData{
    NSString *str_page=[NSString stringWithFormat:@"%ld",pageCount];
    NSDictionary *params = @{@"page":str_page,@"pagesize":@"10"};
    [[AFAppDotNetAPIClient sharedClient] POST:BBG_ONEDOLLARCELL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            NSLog(@"res:%@",responseObject);
            [mainTableView.mj_footer endRefreshing];
            [mainTableView.mj_header endRefreshing];
            
            if (code == 200) {
                
                //[dataCellArray setArray:[responseObject objectForKey:@"yiyuan"]];
                NSArray* arr=[responseObject objectForKey:@"yiyuan"];
                if (arr.count) {
                    
                    
                    if (pageCount>1) {
                        [Array_celldata addObjectsFromArray:arr];
                    }else
                    {
                        [Array_celldata removeAllObjects];
                        [Array_celldata addObjectsFromArray:arr];
                    }

                    
                }else{
                    [self setDataState];
                    if (pageCount>1) {
                        pageCount--;
                        
                    }else
                    {
                        [Array_celldata removeAllObjects];
                        
                    }

                   
                    
                }
                
                [mainTableView reloadData];
               
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JKProgressHuD shareJKProgressHuD] showProgreessText:@"网络异常,请稍后再试" andView:self.view];
        [header endRefreshing];
        [footer endRefreshing];
        
        
    }];
    
    
}


#pragma mark-
#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 215*kFloatSize;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self headerViewForSection];
    
}
#pragma  mark --TableView点击事件--
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
       
        return 520*kFloatSize;
    }
    else{
        return 60*kFloatSize;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return Array_celldata.count/2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneDollarBuyViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[OneDollarBuyViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    cell.backgroundColor=[UIColor clearColor];
    
    NSArray* arr;
    if (Array_celldata.count%2==0) {
        NSInteger number=indexPath.row;
        NSLog(@"%ld",number);
        arr=[[NSArray alloc]initWithObjects:[Array_celldata objectAtIndex:number*2+0],[Array_celldata objectAtIndex:number*2+1], nil];
    }else
    {
        if (indexPath.row*2+1==Array_celldata.count) {
            arr=[[NSArray alloc]initWithObjects:[Array_celldata objectAtIndex:indexPath.row*2+0], nil];
        }else{
            arr=[[NSArray alloc]initWithObjects:[Array_celldata objectAtIndex:indexPath.row*2+0],[Array_celldata objectAtIndex:indexPath.row*2+1], nil];
        }
        
    }
    
    [cell CreateViewArray:arr WihtTarget:@selector(pushToDollarVc:) WithSelf:self WithTag:indexPath.row];
    
    //    [cell setDataModel];
    return cell;
    
}
#pragma mark-
#pragma mark ---点击商品详情---
-(void)pushToDollarVc:(UIButton*)btn
{

    NSDictionary*parDic=[[NSDictionary alloc]initWithDictionary:[Array_celldata objectAtIndex:btn.tag/1000*2+btn.tag%1000]];
    
    
    NSString *str_Id=[NSString stringWithFormat:@"%@",[parDic objectForKey:@"id"]];
   
   // NSString* str_weid=[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:@"weid"]];
    NSString* str_weid=@"0ccm07e5";
    OneDetailsViewController *detailsView=[[OneDetailsViewController alloc]init];
    detailsView.str_one_yyid=str_Id;
    detailsView.str_one_weid=str_weid;
    detailsView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailsView animated:YES];
    NSLog(@"");
}


#pragma mark ---头视图---
-(UIView *)headerViewForSection{
    
    CGRect headframe =CGRectMake(0, 0, self.view.frame.size.width, 520*kFloatSize);
    
    homeOneHeaderView *headerView=[[homeOneHeaderView alloc]initWithFrame:headframe withmodel:_homeModel withSortArray:Array_sort];
    [headerView setBackgroundColor:[UIColor clearColor]];
    headerView.delegate=self;
    return headerView;
    
}
#pragma mark ---headOneDollarbtnDetails---
-(void)headOneDollarbtnDetails:(UIButton *)btn{
    NSLog(@"%sΩΩΩΩΩøøøøπππchen:%ld",__FUNCTION__,btn.tag);
   
    NSArray* ary_finish=[NSArray arrayWithArray:_homeModel.finish];
    NSArray* ary_sell=[NSArray arrayWithArray:_homeModel.sell];
    NSDictionary*parDic;
    if (btn.tag<=2) {
        parDic=[[NSDictionary alloc]initWithDictionary:[ary_finish objectAtIndex:btn.tag]];
    }else{
        parDic=[[NSDictionary alloc]initWithDictionary:[ary_sell objectAtIndex:btn.tag-4]];
    }
   
   // NSString* str_weid=[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:@"weid"]];
    NSString* str_weid=@"0ccm07e5";
    OneDetailsViewController *detailsView=[[OneDetailsViewController alloc]init];
    detailsView.str_one_yyid=[NSString stringWithFormat:@"%@",[parDic objectForKey:@"id"]];
    detailsView.str_one_weid=str_weid;
    detailsView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailsView animated:YES];
    
}

#pragma mark ---点击广告页---
-(void)headOneDollarADtotypleview:(ADModel *)model{
    NSString *str_LinkType=[NSString stringWithFormat:@"%@",model.LinkType];
    NSString *str_linkurl=[NSString stringWithFormat:@"%@",model.linkurl];
    NSLog(@"%@",str_linkurl);
    if (str_linkurl==nil||[str_linkurl isEqualToString:@"(null)"]||str_linkurl.length<=0) {
        if ([str_LinkType isEqualToString:@"3"]) {
//            mallViewController* mallVc=[[mallViewController alloc]init];
//            [mallVc setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:mallVc animated:YES];
        }
        return;
        
    }
    //1是跳转网页，2是跳到商品详情,3,商城
    if ([str_LinkType isEqualToString:@"1"]) {
        OneDetailsLookWebView *web_look=[[OneDetailsLookWebView alloc]init];
        //    web_look.str_to_url=[NSString stringWithFormat:BBG_ONEJSGS,@"1","1"];
        web_look.str_to_url=str_linkurl;
        web_look.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:web_look animated:YES];
        
    }else if ([str_LinkType isEqualToString:@"2"]){
//        NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
        NSString* str_weid=[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:@"weid"]];
        
        OneDetailsViewController *detailsView=[[OneDetailsViewController alloc]init];
        detailsView.str_one_yyid=[NSString stringWithFormat:@"%@",str_linkurl];
        detailsView.str_one_weid=str_weid;
        detailsView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detailsView animated:YES];
        
    }else{
//        mallViewController* mallVc=[[mallViewController alloc]init];
//        [mallVc setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:mallVc animated:YES];
    }

    
}


#pragma mark ---点击单个分类---
-(void)headAloneSortbtn:(UIButton *)btn
{
    NSDictionary*parDic=[[NSDictionary alloc]initWithDictionary:[Array_sort objectAtIndex:btn.tag]];
    
    LQJJKSortViewController * lqjSortVC = [[LQJJKSortViewController alloc] init];
    lqjSortVC.name_sort = parDic[@"pro_name"];
    
    NSString * urlSort = [NSString stringWithFormat:@"http://c.app.zckj.159.net/API/Api.ashx?action=mall_yyg_class&cid=%@&weid=nBcWr11319",parDic[@"pro_id"]];
    
    lqjSortVC.str_url = urlSort;
    lqjSortVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:lqjSortVC animated:YES];
    
    
    
}
#pragma mark ---headOneAllSortbtn---
-(void)headOneAllSortbtn:(UIButton *)btn{
    homeSortVIewController *sort_view=[[homeSortVIewController alloc]init];
    sort_view.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:sort_view animated:YES];
    
}

#pragma mark ---MJRefresh---
-(void)loadNewData
{
    pageCount=1;
    
    [self getHomeHeadNews];
}
-(void)loadMoreData
{
    pageCount++;
    
    
    [self getHomeHeadNews];
    
}
-(void)setDataState
{
    footer.state=MJRefreshStateNoMoreData;
}

@end
