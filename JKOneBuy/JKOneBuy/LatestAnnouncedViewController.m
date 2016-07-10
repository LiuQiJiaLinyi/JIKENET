//
//  LatestAnnouncedViewController.m
//  NewOnePay
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LatestAnnouncedViewController.h"
#import "JKProgressHuD.h"
#import <AFNetworking.h>
#import "define.h"
//#import "goodDetailViewController.h"
#import "GlobalObject.h"
#import "OneDetailsViewController.h"
@implementation LatestAnnouncedViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    //    NSUserDefaults *userDefauts=[NSUserDefaults standardUserDefaults];
//    NSString *token = [userDefauts objectForKey:@"token"];
    
    _type_web=BBG_YYGRESULTS;
    _initial_url=BBG_YYGRESULTS;
    
    
    //加载导航栏
    [self loadMineNavigationBar];
    
    //加载内容视图
    }
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.MWebView) {
        [self.MWebView reload];
    }else{
        [self loadMineContentView];

    }
    
    
}
-(void)loadMineNavigationBar{
    
    
    
    self.navigationItem.title = @"最新揭晓";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.navigationController.navigationBar.barTintColor=[GlobalObject colorWithHexString:@"#ED4D80"];
    
    
    
    
    
    
}
- (void) headOneDollarShareView{
    
    NSDictionary *dict=@{@"title":@"微信分享",
                         @"cancelBtnTitle":@"取消",
                         @"otherTitles":@[@"发送给好友",@"分享到朋友圈"]
                         };
    JKAlertView *alert = [JKAlertView shareInstance];
    [alert showWithInfo:dict withAlertStyle:NSAlertStyleAction WithDelegate:self];
    
    
    
}
-(void)loadMineContentView{
    NSString *urlStr=[NSString stringWithFormat:@"%@",_type_web];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    self.MWebView = [[UIWebView alloc]init];
    self.MWebView.backgroundColor = [UIColor whiteColor];
    
    self.MWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.MWebView.delegate = self;
    [self.MWebView loadRequest:request];
    self.MWebView.scalesPageToFit = YES;
    [self.view addSubview:self.MWebView];
    
}


#pragma mark -UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //    //点击进入商品详情
    //    if ([request.URL.absoluteString hasPrefix:[NSString stringWithFormat:SHOPCENTERGOODDETAIL,COMMON_HEAD]]){
    //
    //        NSString* goodId;
    //        NSRange rangeOne=[request.URL.absoluteString rangeOfString:@"?id"];
    //        NSRange rangTwo=[request.URL.absoluteString rangeOfString:@"&type="];
    //        NSRange rangThree=NSMakeRange(rangeOne.location+rangeOne.length+1, rangTwo.location-rangeOne.location-rangeOne.length-1);
    //
    //        NSLog(@"absoStr=%@",request.URL.absoluteString);
    //        goodId=[request.URL.absoluteString substringWithRange:rangThree];
    //        NSLog(@"goodid=%@",goodId);
    //
    //        if ([request.URL.absoluteString hasSuffix:@"type=1"])
    //        {
    //            NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    //
    //
    //            NSString *str_Id=[NSString stringWithFormat:@"%@",goodId];
    //
    //            OneDetailsViewController *detailsView=[[OneDetailsViewController alloc]init];
    //            detailsView.str_one_yyid=str_Id;
    //            detailsView.str_one_weid=[NSString stringWithFormat:@"%@",[ud objectForKey:@"weid"]];
    //            detailsView.hidesBottomBarWhenPushed=YES;
    //            [self.navigationController pushViewController:detailsView animated:YES];
    //        }else
    //        {
    //            NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    //            NSString* url=[NSString stringWithFormat:MALL_GOOD_DETAIL,goodId,[ud objectForKey:@"weid"]];
    //            proId=goodId;
    //            [self getGoodDeatilData:url];
    //
    //        }
    //        return NO;
    //    }
    [[JKProgressHuD shareJKProgressHuD]showProgreessHuD:@"加载中" andView:self.view];
    
    NSLog(@"absoStr=%@",request.URL.absoluteString);
    _type_web=[NSString stringWithFormat:@"%@",request.URL.absoluteString];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //    self.MWebView.request.URL.
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _lable_web_title.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [[JKProgressHuD shareJKProgressHuD] dismiss];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//        [SVProgressHUD showInfoWithStatus:@"加载失败"];
    
}

-(void)backToMessageVC{
    
    if([_type_web.lowercaseString rangeOfString:_initial_url].location!=NSNotFound){
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"11");
    }else{
        if ([_type_web isEqualToString:_initial_url]) {
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"11");
        }else{
            [self.MWebView goBack];
            
        }
        
        
    }
    
    
    
    
    
}
-(void)getGoodDeatilData:(NSString*)url
{
    [[JKProgressHuD shareJKProgressHuD] showProgreessHuD:@"加载中" andView:self.view];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 6;
    //NSString* url=[NSString stringWithFormat:MALL_MAIN_LIST,proId];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * operation, id  responseObject){
        
        //        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        
        NSString * receiveStr=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (receiveStr.length==0) {
            [[JKProgressHuD shareJKProgressHuD] dismiss];
            return ;
        }
        
        NSData *jsonData = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        NSString* code=[dic objectForKey:@"code"];
        if ( [code integerValue]==200) {
            [[JKProgressHuD shareJKProgressHuD] dismiss];
            //NSArray* arr=[dic objectForKey:@"sort"];
            //            goodDetailViewController* goodDeatilVC=[[goodDetailViewController alloc]init];
            //            goodDeatilVC.dataDic=[[NSDictionary alloc]initWithDictionary:dic];
            //            goodDeatilVC.proId=proId;
            //            [self.navigationController pushViewController:goodDeatilVC animated:YES];
        }
        else{
            [[JKProgressHuD shareJKProgressHuD] dismiss];
        }
        //[mainTableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        
        //[mainTableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
