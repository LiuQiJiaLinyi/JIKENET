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


#import "JKGetPwdViewController.h"

#import <MJExtension/MJExtension.h>


@interface JKLoginViewController ()<NSCoding>
{

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

-(void)loadMainView{

    UIView *phoneView=[self addmyView:CGRectMake(15*MainSize, 30*MainSize, self.view.frame.size.width-30*MainSize, 42*MainSize)];
    
    [self.view addSubview:phoneView];
    
    
    UILabel *lbl_Name=[self addMyUILable:CGRectMake(16*MainSize, 13*MainSize, 48*MainSize, 15*MainSize)];
    lbl_Name.text=@"手机号码";
    [phoneView addSubview:lbl_Name];
    
    
    txt_Name=[self addMyUITextFeild:CGRectMake(75*MainSize, 13*MainSize, 200*MainSize, 15*MainSize)];
    [txt_Name setPlaceholder:@"输入手机号码"];
    [txt_Name setKeyboardType:UIKeyboardTypePhonePad];

    [phoneView addSubview:txt_Name];
    
    
    UIView *pwdView=[self addmyView:CGRectMake(15*MainSize, 100*MainSize, self.view.frame.size.width-30*MainSize, 42*MainSize)];
    
    [self.view addSubview:pwdView];

    UILabel *lbl_Pwd=[self addMyUILable:CGRectMake(16*MainSize, 13*MainSize, 48*MainSize, 15*MainSize)];
    lbl_Pwd.text=@"密码";
    [pwdView addSubview:lbl_Pwd];
    
     
    txt_Pwd=[self addMyUITextFeild:CGRectMake(75*MainSize, 13*MainSize, 200*MainSize, 15*MainSize)];
    [txt_Pwd setPlaceholder:@"输入密码"];
    [txt_Pwd setKeyboardType:UIKeyboardTypeDefault];
    
    [pwdView addSubview:txt_Pwd];
    
    
    
    UIButton *btn_Login=[[UIButton alloc]initWithFrame:CGRectMake(15*MainSize, 170*MainSize, self.view.frame.size.width-30*MainSize, 44*MainSize)];
    
    [btn_Login setBackgroundColor:[GlobalObject colorWithHexString:@"#EE4A7E"]];
    
    [btn_Login setTitle:@"登录" forState:UIControlStateNormal];
    
    [btn_Login.layer setCornerRadius:20*MainSize];
    [btn_Login.layer setMasksToBounds:YES];
    
    
    [self.view addSubview:btn_Login];
    
    [btn_Login addTarget:self action:@selector(btnClickLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10*MainSize, 290*MainSize, 100*MainSize, 1)];
    [line setBackgroundColor:[GlobalObject colorWithHexString:@"#F0F1F1"]];
    [self.view addSubview:line];
    
    UIView *lineT=[[UIView alloc]initWithFrame:CGRectMake(210*MainSize, 290*MainSize, 100*MainSize, 1)];
    [lineT setBackgroundColor:[GlobalObject colorWithHexString:@"#F0F1F1"]];
    [self.view addSubview:lineT];
    
    
    UILabel *lbl_Three=[[UILabel alloc]initWithFrame:CGRectMake(110*MainSize, 282*MainSize, 100*MainSize, 16*MainSize)];
    [lbl_Three setText:@"快速登录"];
    [lbl_Three setFont:[UIFont systemFontOfSize:11*MainSize]];
    [lbl_Three setTextAlignment:NSTextAlignmentCenter];
    [lbl_Three setTextColor:[GlobalObject colorWithHexString:@"#868788"]];
    [self.view addSubview:lbl_Three];
    

    
    UIButton *btn_Forget=[[UIButton alloc]initWithFrame:CGRectMake(235*MainSize, 222*MainSize, 70*MainSize, 20*MainSize)];
    [btn_Forget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
    [btn_Forget.titleLabel setFont:[UIFont systemFontOfSize:12*MainSize]];
    
    [btn_Forget addTarget:self action:@selector(btnClickForget) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_Forget setTitleColor:[GlobalObject colorWithHexString:@"#A6A7A8"] forState:UIControlStateNormal];

    [self.view addSubview:btn_Forget];
    
    
    UIButton *btn_WeixinLogin=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-17.5*MainSize, 320*MainSize, 35*MainSize, 35*MainSize)];
    [btn_WeixinLogin setBackgroundImage:[UIImage imageNamed:@"wx_login"] forState:UIControlStateNormal];
    [btn_WeixinLogin addTarget:self action:@selector(btnClickWxLogin) forControlEvents:UIControlEventTouchUpInside];
    
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

 
    
}

-(void)btnClickForget{

    JKGetPwdViewController *getpwdVC=[[JKGetPwdViewController alloc]init];
    [self.navigationController pushViewController:getpwdVC animated:YES];
    
    
   
    
}

-(void)btnClickRegister{

    NSLog(@"点击注册按钮");
}

/*
 {
 "code": "200",
 "nickname": "龙井茶",
 "headimgurl": "http://wx.qlogo.cn/mmopen/ajNVdqHZLLDt4dpBPdyAy6NgXqR37Ku1f972CWx15P8ZfibxdJia2rKUK1gntxqVLicgB9SoGKzliaqB9oSW7DV5Gg/0",
 "xuehao": 123222,
 "level": "2",
 "attach": "班级",
 "monitornum": "www159net",
 "planbalance": "425.02",
 "confirmbalance": "425.02",
 "name": "文申",
 "weid": "nBcWr11319",
 "bossid": "www159net",
 "mobilephone": "15263986077",
 "mastertime": "2016-06-08 15:49:19",
 "IsSupplier": false,
 "IsStock": false,
 "stocktime": "0001-01-01 00:00:00",
 "isblack": false,
 "WechatCount": 0,
 "city": "廊坊市",
 "province": "河北省",
 "country": "中国",
 "wechat": "wenshen",
 "userlevel": 1,
 "hasProp": false,
 "IsAgent": false
 }
 */


-(void)btnClickLogin{

    
    [[JKProgressHuD shareJKProgressHuD]showProgreessHuD:@"登录中" andView:self.view];

    
    NSDictionary *dic=@{@"tel":txt_Name.text,@"pwd":txt_Pwd.text};
    
    NSString *url=[NSString stringWithFormat:@"%@%@",MainUrl,URL_Userlogin];
    
    
    [[AFAppDotNetAPIClient sharedClient]POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask *operation,id responseObject){
        
        [[JKProgressHuD shareJKProgressHuD]dismiss];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dictTemp = (NSDictionary *)responseObject;
            //code:状态码(200成功 400错误 401不存在该用户 402密码错误)
            NSString * codeStr = dictTemp[@"code"];
            
            int codeInt = [codeStr intValue];
            
            switch (codeInt) {
                case 200:
                {
                    NSMutableData *data = [[NSMutableData alloc] init];
                    //创建归档辅助类
                    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
                   
                    [archiver encodeObject:dictTemp forKey:@"user"];
                  
                    [archiver finishEncoding];
                  
                    [data writeToFile:[self getFilePathWithModelKey:@"userInfor"] atomically:YES];
                    
                    
                    
                }
                    break;
                case 400:
                {
                    UIAlertView * illegalUser = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [illegalUser show];
                }
                    break;
                case 401:
                {
                    UIAlertView * illegalUser = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [illegalUser show];
                }
                    break;
                case 402:
                {
                    UIAlertView * illegalUser = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码输入错误请重新输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [illegalUser show];
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

//得到Document目录
-(NSString *) getFilePathWithModelKey:(NSString *)modelkey
{
    
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
    
    
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
