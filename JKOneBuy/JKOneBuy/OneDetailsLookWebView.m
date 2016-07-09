//
//  OneDetailsLookWebView.m
//  BoBoBuy
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "OneDetailsLookWebView.h"
#import "JKProgressHuD.h"
#import <AFNetworking.h>
#import "define.h"
//#import "goodDetailViewController.h"
#import "OneDetailsViewController.h"
@interface OneDetailsLookWebView ()

@end

@implementation OneDetailsLookWebView

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
//    NSUserDefaults *userDefauts=[NSUserDefaults standardUserDefaults];
//    NSString *token = [userDefauts objectForKey:@"token"];
   
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
    
    
    
    _lable_web_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200-25, 30)];
    [_lable_web_title setTextAlignment:NSTextAlignmentCenter];
    
    [_lable_web_title setTextColor:[UIColor whiteColor]];
    [_lable_web_title setBackgroundColor:[UIColor clearColor]];
    [_lable_web_title setFont:[UIFont boldSystemFontOfSize:16]];
    //    [_lable_web_title sizeToFit];
    //    [lable setText:_str_web_title];
    self.navigationItem.titleView=_lable_web_title;
    //    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:233.0/255.0 green:46.0/255.0 blue:106.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_barBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    

    
    
    
}
- (void) headOneDollarShareView{
    
    NSDictionary *dict=@{@"title":@"微信分享",
                         @"cancelBtnTitle":@"取消",
                         @"otherTitles":@[@"发送给好友",@"分享到朋友圈"]
                         };
    JKAlertView *alert = [JKAlertView shareInstance];
    [alert showWithInfo:dict withAlertStyle:NSAlertStyleAction WithDelegate:self];
    
    
    
}
//-(void)alertView:(JKAlertView *)alertView clickBtnTitle:(NSString *)title{
//    if ([title isEqualToString:@"发送给好友"]) {
//        //好友
//        [self weixinSharewithWechatShareType:NSWechatShareTypeSceneSession];
//    }else if([title isEqualToString:@"分享到朋友圈"]){
//        //朋友圈
//        [self weixinSharewithWechatShareType:NSWechatShareTypeSceneTimeline];
//    }
//
//    
//}
//
//-(void)weixinSharewithWechatShareType:(NSWechatShareType)type{
//    
// //   NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
//    
//    
//    NSString *url_str=[NSString stringWithFormat:WEIDIANShare,self.str_mall_ID];
//    
//    
//    [JKWXShare WXShareWithTitle:_lable_web_title.text withDescription:nil withImageURL:@"http://sucai.zckj.159.net/img/Share/myshopshare.jpg" withWebURL:url_str withWXScene:type];
//}
//
//
//-(void)shareView{
//    
//    
//    
//    
//}
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
    
    UIButton* loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake(0, 0, 25, 25);
    [loginBtn setImage:[UIImage imageNamed:@"share_wei_img"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(headOneDollarShareView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:loginBtn];
    loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    
    if([request.URL.absoluteString.lowercaseString rangeOfString:@"/user/myshop/index.aspx?"].location!=NSNotFound){
        
        self.navigationItem.rightBarButtonItem = rightItem;
        
       
    }else{
        
        self.navigationItem.rightBarButtonItem = nil;
        
    }
    
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
   
    
    NSLog(@"absoStr=%@",request.URL.absoluteString);
    _type_web=[NSString stringWithFormat:@"%@",request.URL.absoluteString];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //    self.MWebView.request.URL.
    
    [[JKProgressHuD shareJKProgressHuD]showProgreessHuD:@"加载中" andView:self.view];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _lable_web_title.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
