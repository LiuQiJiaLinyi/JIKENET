//
//  JKGetPwdViewController.m
//  BoBoBuy
//
//  Created by teaplant on 16/3/3.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "JKGetPwdViewController.h"
#import "JKProgressHuD.h"
#import "define.h"
#import "AFAppDotNetAPIClient.h"

@interface JKGetPwdViewController ()<UITextFieldDelegate>{

    UITextField *txt_phone;
    UITextField *txt_captcha;
    UITextField *txt_pwd;
    UITextField *txt_pwdAgain;
    UIButton *btn_getChatcha;
    
    NSTimer *timer;
    
    NSInteger timeCount;
}

@end

@implementation JKGetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTitleViewWithTitle:@"找回密码"];
    
    [self addTitleViewWithTitle:nil imageName:@"nav_bar_left_new.png" selectedimageName:nil selector:@selector(BackUp) location:YES andFrame:CGRectMake(0, 0, 24, 20)];
    [self.view setBackgroundColor:[GlobalObject colorWithHexString:@"#FEFFFF"]];
    
    [self loadMianView];
    
    timeCount=60;
    
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [txt_phone resignFirstResponder];
    [txt_captcha resignFirstResponder];
    [txt_pwd resignFirstResponder];
    [txt_pwdAgain resignFirstResponder];



}
-(void)loadMianView{

    UIView *phoneView=[self addmyView:CGRectMake(15*MainSize, 30*MainSize, self.view.frame.size.width-30*MainSize, 42*MainSize)];
    
    [self.view addSubview:phoneView];
    
    
    UILabel *lbl_Name=[self addMyUILable:CGRectMake(16*MainSize, 13*MainSize, 48*MainSize, 15*MainSize)];
    lbl_Name.text=@"手机号码";
    [phoneView addSubview:lbl_Name];
    
    
    txt_phone=[self addMyUITextFeild:CGRectMake(75*MainSize, 13*MainSize, 100*MainSize, 15*MainSize)];
    [txt_phone setPlaceholder:@"输入手机号码"];
    [txt_phone setKeyboardType:UIKeyboardTypePhonePad];
    
    [phoneView addSubview:txt_phone];
    
    
    btn_getChatcha=[[UIButton alloc]initWithFrame:CGRectMake(225*MainSize, 0, 65*MainSize, phoneView.frame.size.height)];
    
    [btn_getChatcha setBackgroundColor:[GlobalObject colorWithHexString:@"#EE4A7E"]];
    
    [btn_getChatcha setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [btn_getChatcha.titleLabel setFont:[UIFont systemFontOfSize:10*MainSize]];
    
    [btn_getChatcha addTarget:self action:@selector(btnClickGet) forControlEvents:UIControlEventTouchUpInside];
    
    [phoneView addSubview:btn_getChatcha];
    
    
    
    UIView *chatchaView=[self addmyView:CGRectMake(15*MainSize, 100*MainSize, self.view.frame.size.width-30*MainSize, 42*MainSize)];
    
    [self.view addSubview:chatchaView];
    
    
    UILabel *lbl_captcha=[self addMyUILable:CGRectMake(16*MainSize, 13*MainSize, 48*MainSize, 15*MainSize)];
    lbl_captcha.text=@"验证码";
    [chatchaView addSubview:lbl_captcha];
    
    
    txt_captcha=[self addMyUITextFeild:CGRectMake(75*MainSize, 13*MainSize, 200*MainSize, 15*MainSize)];
    [txt_captcha setPlaceholder:@"输入验证码"];
    [txt_captcha setKeyboardType:UIKeyboardTypeNumberPad];
    
    [chatchaView addSubview:txt_captcha];
    
    
    UIView *pwdView=[self addmyView:CGRectMake(15*MainSize, 170*MainSize, self.view.frame.size.width-30*MainSize, 42*MainSize)];
    
    [self.view addSubview:pwdView];
    
    
    UILabel *lbl_pwd=[self addMyUILable:CGRectMake(16*MainSize, 13*MainSize, 48*MainSize, 15*MainSize)];
    lbl_pwd.text=@"新密码";
    [pwdView addSubview:lbl_pwd];
    
    
    txt_pwd=[self addMyUITextFeild:CGRectMake(75*MainSize, 13*MainSize, 200*MainSize, 15*MainSize)];
    [txt_pwd setPlaceholder:@"输入新密码"];
    [txt_pwd setSecureTextEntry:YES];
    
    [txt_pwd setDelegate:self];
    
    [pwdView addSubview:txt_pwd];
    
    UIView *pwdAView=[self addmyView:CGRectMake(15*MainSize, 240*MainSize, self.view.frame.size.width-30*MainSize, 42*MainSize)];
    
    [self.view addSubview:pwdAView];
    
    
    UILabel *lbl_pwdA=[self addMyUILable:CGRectMake(16*MainSize, 13*MainSize, 48*MainSize, 15*MainSize)];
    lbl_pwdA.text=@"确认密码";
    [pwdAView addSubview:lbl_pwdA];
    
    
    txt_pwdAgain=[self addMyUITextFeild:CGRectMake(75*MainSize, 13*MainSize, 200*MainSize, 15*MainSize)];
    [txt_pwdAgain setPlaceholder:@"再次输入新密码"];
    [txt_pwdAgain setKeyboardType:UIKeyboardTypeDefault];
    [txt_pwdAgain setSecureTextEntry:YES];

    [txt_pwdAgain setDelegate:self];
    [pwdAView addSubview:txt_pwdAgain];
    
    
    
    UIButton *btn_Login=[[UIButton alloc]initWithFrame:CGRectMake(15*MainSize, 308*MainSize, self.view.frame.size.width-30*MainSize, 44*MainSize)];
    
    [btn_Login setBackgroundColor:[GlobalObject colorWithHexString:@"#EE4A7E"]];
    
    [btn_Login setTitle:@"提交" forState:UIControlStateNormal];
    
    [btn_Login.layer setCornerRadius:20*MainSize];
    [btn_Login.layer setMasksToBounds:YES];
    
    
    [self.view addSubview:btn_Login];
    
    [btn_Login addTarget:self action:@selector(btnClickSend) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)btnClickGet{
    
    
    if (txt_phone.text.length>5) {
        [btn_getChatcha setEnabled:NO];
        
        
        timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:)  userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
        
        
        NSDictionary *dic=[NSDictionary dictionaryWithObject:txt_phone.text forKey:@"tel"];
        
       // NSString *url=[NSString stringWithFormat:@"%@%@",COMMON_HEAD,GetYZM];
        NSString *url;
        
        [[AFAppDotNetAPIClient sharedClient]POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask *operation,id responseObject){
            
            [[JKProgressHuD shareJKProgressHuD]dismiss];
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                if ([[responseObject objectForKey:@"code"] isEqualToString:@"200"]) {
                    
                  
                    [[JKProgressHuD shareJKProgressHuD]showProgreessText:@"验证码已发送,请注意查收" andView:self.view];
                    
                }else{
                   
                    
                    
                }
                
            }
            
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error){
            
            [[JKProgressHuD shareJKProgressHuD]showProgreessText:@"网络错误" andView:self.view];
            
        }];
        

    }else{
    
        [[JKProgressHuD shareJKProgressHuD ]showProgreessText:@"请输入手机号码" andView:self.view];
        
        
    }
    

    

    
}

-(void)timerFireMethod:(NSTimer *)theTimer {
    
    
    if (timeCount>0) {
        
        NSString *str=[NSString stringWithFormat:@"%ld秒后重发",(long)timeCount];
        [btn_getChatcha setTitle:str forState:UIControlStateNormal];
        
        [btn_getChatcha setBackgroundColor:[GlobalObject colorWithHexString:@"#515151"]];

        
    }else{
        [timer invalidate];
        
    
        timeCount=60;
        [btn_getChatcha setTitle:@"获取验证码" forState:UIControlStateNormal];
        btn_getChatcha.enabled=YES;
        [btn_getChatcha setBackgroundColor:[GlobalObject colorWithHexString:@"#EE4A7E"]];

        
    }
    
    timeCount--;
    
}

-(void)btnClickSend{
    
    
    if (txt_phone.text.length>0) {
        
        if (txt_captcha.text.length>0) {
            
            if (txt_pwd.text==txt_pwdAgain.text) {
                
                
                
                NSDictionary *dic=@{@"tel":txt_phone.text,@"yzm":txt_captcha.text,@"pwd":txt_pwd.text};
                
               // NSString *url=[NSString stringWithFormat:@"%@%@",COMMON_HEAD,ModifyPWD];
                NSString *url;
                
                [[AFAppDotNetAPIClient sharedClient]POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask *operation,id responseObject){
                    
                    [[JKProgressHuD shareJKProgressHuD]dismiss];
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        
                        if ([[responseObject objectForKey:@"code"]  isEqualToString:@"200"]) {
                                [[JKProgressHuD shareJKProgressHuD]showProgreessText:@"密码设置成功"andView:self.view];
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        }else{
                            [[JKProgressHuD shareJKProgressHuD]showProgreessText:[responseObject objectForKey:@"message"] andView:self.view];

                        }
                        
                    }
                    
                    
                } failure:^(NSURLSessionDataTask *operation, NSError *error){
                    
                    [[JKProgressHuD shareJKProgressHuD]showProgreessText:@"网络错误" andView:self.view];
                    
                }];
                

            }
        }
    }
    
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)BackUp{

    [self.navigationController popViewControllerAnimated:YES];
    
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
