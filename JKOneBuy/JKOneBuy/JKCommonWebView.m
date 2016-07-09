//
//  JKCommonWebView.m
//  JKOneBuy
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "JKCommonWebView.h"
#import "JKProgressHuD.h"
#import <AFNetworking.h>
#import "define.h"
@implementation JKCommonWebView
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
   
    
    _type_web=self.str_to_url;
    _initial_url=self.str_to_url;
    
    
    //加载导航栏
    [self loadMineNavigationBar];
    
    //加载内容视图
    [self loadMineContentView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
-(void)loadMineNavigationBar{
    
    
    
    
    leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake( 0, 0, 12*kFloatSize, 17*kFloatSize);
    [leftbtn addTarget:self action:@selector(backToMessageVC) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"nav_bar_left_new.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem  =[[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.title = @"收货地址";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:233.0/255.0 green:46.0/255.0 blue:106.0/255.0 alpha:1.0];
    
//    _lable_web_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200-25, 30)];
//    [_lable_web_title setTextAlignment:NSTextAlignmentCenter];
//    
//    [_lable_web_title setTextColor:[UIColor whiteColor]];
//    [_lable_web_title setBackgroundColor:[UIColor clearColor]];
//    [_lable_web_title setFont:[UIFont boldSystemFontOfSize:16]];
//    
//    self.navigationItem.titleView=_lable_web_title;
//   
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_barBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    
    
    
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
    
    
    NSLog(@"absoStr=%@",request.URL.absoluteString);
    _type_web=[NSString stringWithFormat:@"%@",request.URL.absoluteString];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //    self.MWebView.request.URL.
    
    [[JKProgressHuD shareJKProgressHuD]showProgreessHuD:@"加载中" andView:self.view];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    _lable_web_title.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [[JKProgressHuD shareJKProgressHuD] dismiss];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //    [SVProgressHUD showInfoWithStatus:@"加载失败"];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
