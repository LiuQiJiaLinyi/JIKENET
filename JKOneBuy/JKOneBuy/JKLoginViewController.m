//
//  JKLoginViewController.m
//  BoBoBuy
//
//  Created by teaplant on 16/3/1.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "JKLoginViewController.h"
#import "JKProgressHuD.h"
#import "AFAppDotNetAPIClient.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WXUtil.h"
#import "personViewController.h"
#import "JKRegisterVC.h"
#import "ShoppingCartViewController.h"



#import "JKGetPwdViewController.h"

#import <MJExtension/MJExtension.h>
#import "UserModel.h"


@interface JKLoginViewController ()<WXApiDelegate>{
    
    UITextField *txt_Name;
    UITextField *txt_Pwd;
    NSString    *rongUserId;
    
}
@end
@implementation JKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:233.0/255.0 green:46.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    [self addTitleViewWithTitle:@"登录"];
    [self.view setBackgroundColor:[GlobalObject colorWithHexString:@"#FEFFFF"]];
    
    [self addTitleViewWithTitle:nil imageName:@"nav_bar_left_new.png" selectedimageName:nil selector:@selector(BackUp) location:YES andFrame:CGRectMake(0, 0, 12, 20)];
    [self loadMainView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [txt_Name resignFirstResponder];
    [txt_Pwd resignFirstResponder];
}

-(void)BackUp{
    [self.mainTabbar setSelectedIndex:0];
    
}

-(void)loadMainView{
    
    UIView *phoneView=[self addmyView:CGRectMake(15*MainSize, 30 * MainSize+64, self.view.frame.size.width-30 * MainSize, 42 * MainSize)];
    
    [self.view addSubview:phoneView];
    
    
    UILabel *lbl_Name=[self addMyUILable:CGRectMake(16*MainSize, 13*MainSize, 48 * MainSize, 15 * MainSize)];
    lbl_Name.text=@"手机号码";
    [phoneView addSubview:lbl_Name];
    
    
    txt_Name=[self addMyUITextFeild:CGRectMake(75*MainSize, 13*MainSize, 200*MainSize, 15*MainSize)];
    [txt_Name setPlaceholder:@"输入手机号码"];
    [txt_Name setKeyboardType:UIKeyboardTypePhonePad];
    
    [phoneView addSubview:txt_Name];
    
    
    UIView *pwdView=[self addmyView:CGRectMake(15*MainSize, 100*MainSize+64, self.view.frame.size.width-30*MainSize, 42*MainSize)];
    
    [self.view addSubview:pwdView];
    
    UILabel *lbl_Pwd=[self addMyUILable:CGRectMake(16*MainSize, 13*MainSize, 48*MainSize, 15*MainSize)];
    lbl_Pwd.text=@"密码";
    [pwdView addSubview:lbl_Pwd];
    
    
    txt_Pwd=[self addMyUITextFeild:CGRectMake(75*MainSize, 13*MainSize, 200*MainSize, 15*MainSize)];
    [txt_Pwd setPlaceholder:@"输入密码"];
    [txt_Pwd setKeyboardType:UIKeyboardTypeDefault];
    
    [pwdView addSubview:txt_Pwd];
    
    
    
    UIButton *btn_Login=[[UIButton alloc]initWithFrame:CGRectMake(15*MainSize, 170*MainSize+64, self.view.frame.size.width-30*MainSize, 44*MainSize)];
    
    [btn_Login setBackgroundColor:[GlobalObject colorWithHexString:@"#EE4A7E"]];
    
    [btn_Login setTitle:@"登录" forState:UIControlStateNormal];
    
    [btn_Login.layer setCornerRadius:20*MainSize];
    [btn_Login.layer setMasksToBounds:YES];
    
    UIButton * but_register = [[UIButton alloc]initWithFrame:CGRectMake(15*MainSize, 187*MainSize+64+(44*MainSize), self.view.frame.size.width-30*MainSize, 44*MainSize)];
    but_register.backgroundColor = [UIColor whiteColor];
    but_register.alpha = 1;
    [but_register setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [but_register setTitle:@"立即注册" forState:UIControlStateNormal];
    [but_register setTitleColor:[GlobalObject colorWithHexString:@"#EE4A7E"] forState:UIControlStateNormal];
    
    [but_register.layer setCornerRadius:20*MainSize];
    [but_register.layer setBorderColor:(__bridge CGColorRef _Nullable)([GlobalObject colorWithHexString:@"#EE4A7E"])];
    [but_register.layer setBorderWidth:10];
    [but_register.layer setMasksToBounds:YES];
    
    
    [but_register.layer setCornerRadius:20*MainSize];
    [but_register.layer setMasksToBounds:YES];
    
    
    [self.view addSubview:but_register];
    [self.view addSubview:btn_Login];
    
    [but_register addTarget:self action:@selector(btnClickRegister) forControlEvents:UIControlEventTouchUpInside];
    [btn_Login addTarget:self action:@selector(btnClickLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10*MainSize, (290 + 39)*MainSize+64, 100*MainSize, 1)];
    [line setBackgroundColor:[GlobalObject colorWithHexString:@"#F0F1F1"]];
    [self.view addSubview:line];
    
    UIView *lineT=[[UIView alloc]initWithFrame:CGRectMake(210*MainSize, (290 + 39)*MainSize+64, 100*MainSize, 1)];
    [lineT setBackgroundColor:[GlobalObject colorWithHexString:@"#F0F1F1"]];
    [self.view addSubview:lineT];
    
    
    UILabel *lbl_Three=[[UILabel alloc]initWithFrame:CGRectMake(110*MainSize, (282 + 39)*MainSize+64, 100*MainSize, 16*MainSize)];
    [lbl_Three setText:@"或通过微信登录"];
    [lbl_Three setFont:[UIFont systemFontOfSize:11*MainSize]];
    [lbl_Three setTextAlignment:NSTextAlignmentCenter];
    [lbl_Three setTextColor:[GlobalObject colorWithHexString:@"#868788"]];
    [self.view addSubview:lbl_Three];
    
    
    
    UIButton *btn_Forget=[[UIButton alloc]initWithFrame:CGRectMake(235*MainSize, 222*MainSize+64, 70*MainSize, 20*MainSize)];
    [btn_Forget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
    [btn_Forget.titleLabel setFont:[UIFont systemFontOfSize:12*MainSize]];
    
    [btn_Forget addTarget:self action:@selector(btnClickForget) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_Forget setTitleColor:[GlobalObject colorWithHexString:@"#A6A7A8"] forState:UIControlStateNormal];
    
    [self.view addSubview:btn_Forget];
    
    
    UIButton *btn_WeixinLogin=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-32.5*MainSize, (320 + 39)*MainSize+64, 65*MainSize, 65*MainSize)];
    [btn_WeixinLogin setBackgroundImage:[UIImage imageNamed:@"wx_login"] forState:UIControlStateNormal];
    [btn_WeixinLogin addTarget:self action:@selector(btnClickWxLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * label_weixin = [[UILabel alloc] initWithFrame:CGRectMake(btn_WeixinLogin.frame.origin.x, btn_WeixinLogin.frame.size.height + (btn_WeixinLogin.frame.origin.y +10), btn_WeixinLogin.frame.size.width, 18* MainSize)];
    label_weixin.textAlignment = NSTextAlignmentCenter;
    label_weixin.font = [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width * (13.f/320.f)];
    label_weixin.text = @"微信登录";
    [label_weixin setTextColor:[GlobalObject colorWithHexString:@"#868788"]];
    
    [self.view addSubview:label_weixin];
    [self.view addSubview:btn_WeixinLogin];
    
}



-(UIView *)addmyView:(CGRect )frame{
    
    UIView *phoneView=[[UIView alloc]initWithFrame:frame];
    [phoneView.layer setBorderWidth:1];
    [phoneView.layer setBorderColor:[GlobalObject colorWithHexString:@"#F3F4F5"].CGColor];
    [phoneView.layer setCornerRadius:20*MainSize];
    [phoneView.layer setMasksToBounds:YES];
    return phoneView;
    
}


-(UILabel *)addMyUILable:(CGRect)frame{
    
    UILabel *lbl_Name=[[UILabel alloc]initWithFrame:frame];
    
    [lbl_Name setTextColor:[GlobalObject colorWithHexString:@"#656565"]];
    
    [lbl_Name setFont:[UIFont systemFontOfSize:12*MainSize]];
    
    return lbl_Name;
    
}


-(UITextField *)addMyUITextFeild:(CGRect)frame{
    
    UITextField *txt=[[UITextField alloc]initWithFrame:frame];
    
    [txt setFont:[UIFont systemFontOfSize:12*MainSize]];
    
    return txt;
    
}


-(void)btnClickWxLogin{
    NSUserDefaults *userDefauls=[NSUserDefaults standardUserDefaults];
    [userDefauls setObject:@"YES" forKey:@"isWXLogin"];
    BOOL iswx=[WXApi isWXAppSupportApi];
    
    SendAuthReq* req =[[SendAuthReq alloc ] init ] ;
    req.scope = @"snsapi_userinfo,snsapi_base" ;
    req.state = @"0744";
    [WXApi sendAuthReq:req viewController:self delegate:self];
    
    
}

-(void)btnClickForget{
    
    JKGetPwdViewController *getpwdVC=[[JKGetPwdViewController alloc]init];
    [self.navigationController pushViewController:getpwdVC animated:YES];
    
}

#pragma mark-
#pragma mark –––––注册点击事件––––––
-(void)btnClickRegister{
    
    JKRegisterVC * jkregister = [[JKRegisterVC alloc] init];
    [self.navigationController pushViewController:jkregister animated:YES];
}

-(void)btnClickLogin{
    
    [[JKProgressHuD shareJKProgressHuD]showProgreessHuD:@"登录中" andView:self.view];
    
    
    NSDictionary *dic=@{@"tel":txt_Name.text,@"pwd":txt_Pwd.text};
    
    NSString *url=[NSString stringWithFormat:@"%@%@",MainUrl,URL_Userlogin];
    
    //http://c.app.zckj.159.net/API/Api.ashx?action=log_telp&tel=15263986077&pwd=123456
    
#pragma mark •••开发时固定注意修改•••
    
    __weak __block JKLoginViewController * weakself = self;
    [[AFAppDotNetAPIClient sharedClient]POST:@"http://c.app.zckj.159.net/API/Api.ashx?action=log_telp&tel=15263986077&pwd=123456" parameters:nil progress:nil success:^(NSURLSessionDataTask *operation,id responseObject){
        
        [[JKProgressHuD shareJKProgressHuD]dismiss];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * temp = (NSDictionary *)responseObject;
            
            NSString * tempStr = temp[@"code"];
            NSInteger code = [tempStr integerValue];
            
            switch (code) {
                case 200:
                {
                    [weakself writeToUserInformation:temp];
                    
//       •注意需要再次判断是否有购物车有则上传否则不传•
            [weakself performSelectorInBackground:@selector(gotShoppingCartDataAndSendToServer) withObject:nil];
                  
                    [weakself resetViewController];
                }
                    break;
                case 400:
                {
                    [weakself showAlertView:@"未知错误！"];
                }
                    break;
                case 401:
                {
                    [weakself showAlertView:@"不存在此用户"];
                }
                    break;
                case 402:
                {
                    [weakself showAlertView:@"密码错误，请检查密码！"];
                }
                    break;
                    
                    
                default:
                    break;

            }
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        
        [[JKProgressHuD shareJKProgressHuD]showProgreessText:@"网络错误" andView:self.view];
        
    }];
    
}

#pragma mark ————写入数据——–––
-(void)writeToUserInformation:(NSDictionary *)userInfor
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:userInfor forKey:@"userInformation"];
    [archiver finishEncoding];
    
    //写入
    NSLog(@"%@",[self getFilePathWithModelKey:@"userInformation"]);
    if ([data writeToFile:[self getFilePathWithModelKey:@"userInformation"] atomically:YES]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"userState"];
    }
}

#pragma mark --获取Document路径
-(NSString *) getFilePathWithModelKey:(NSString *)modelkey

{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
}


#pragma mark –––成功后更改控制器
-(void)resetViewController
{
    UINavigationController * nav = [_mainTabbar.viewControllers objectAtIndex:3];
    personViewController * personer = [[personViewController alloc] init];
    
    
    [self addChildVcItem:personer title:@"个人中心" image:@"personVC.png" selectedImage:@"personVC_sel.png"];
    
    [nav setViewControllers:@[personer]];
    
}

-(void)gotShoppingCartDataAndSendToServer
{
    [_weakShoppingCart Click_setOrder:nil];
}


- (void)addChildVcItem:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)showAlertView:(NSString * )massgae
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:massgae delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
