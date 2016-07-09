//
//  OneDetailsViewController.m
//  JKOneBuy
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "OneDetailsViewController.h"
#import "define.h"
#import "GlobalObject.h"
#import "AFAppDotNetAPIClient.h"
#import "JKProgressHuD.h"
#import "OneAllModel.h"
#import "OneYiyuanModel.h"
#import "OneLuckuserModel.h"
#import "OneYygnewModel.h"
#import "OneHeadDetailsView.h"
#import "OneCentreView.h"
#import "OneDetailsBottomView.h"

#define BBGSIGNKEY @"native159netnative159netnative159net"

@implementation OneDetailsViewController
{
    OneAllModel       *_OneAllModel;
    OneYiyuanModel    *_YiYuanModel;
    OneLuckuserModel  *_LuckUserModel;
    OneYygnewModel    *_NewOneModel;
}
- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    
    // Do any additional setup after loading the view.
    [self setMyNavigationBar];
    [self loadMainView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getOnedollarsData];
}
-(void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
    //    for (UIView *subview in mainScroll.subviews) {
    //        [subview removeFromSuperview];
    //    }
    [mainScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
-(void)loadMainView
{
    mainScroll=[[UIScrollView alloc]init];
    mainScroll.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    mainScroll.contentSize=CGSizeMake(self.view.frame.size.width,740*kFloatSize);
    [mainScroll setBackgroundColor:[GlobalObject colorWithHexString:@"#E9E7E8"]];
    mainScroll.userInteractionEnabled=YES;
    mainScroll.showsVerticalScrollIndicator=NO;
    mainScroll.delegate=self;
    [self.view addSubview:mainScroll];
    
}
-(void)setMyNavigationBar{
    
    self.navigationItem.title = @"商品详情";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:233.0/255.0 green:46.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftbtn addTarget:self action:@selector(backToMessageVC) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"nav_bar_left_new.png"] forState:UIControlStateNormal];
    [leftbtn setFrame:CGRectMake( 0, 0, 12*kFloatSize, 17*kFloatSize)];
    UIBarButtonItem *leftItem  =[[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn_right addTarget:self action:@selector(shareToVC) forControlEvents:UIControlEventTouchUpInside];
    [btn_right setBackgroundImage:[UIImage imageNamed:@"home_share.png"] forState:UIControlStateNormal];
    [btn_right setBackgroundImage:[UIImage imageNamed:@"home_share_sel.png"] forState:UIControlStateSelected];
    [btn_right setFrame:CGRectMake(0, 0, 20*kFloatSize, 20*kFloatSize)];
    UIBarButtonItem *rightItem  =[[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    
    
    
    
}
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
        NSString *title = [NSString stringWithFormat:@"%@",_OneAllModel.sharetitle];
        //    title = [self base64jiemiWithStr:[JKEncrypt returnJiemiStringWithString:title]];
        NSString *des = [NSString stringWithFormat:@"%@",_OneAllModel.sharedesc];
        //    des = [self base64jiemiWithStr:[JKEncrypt returnJiemiStringWithString:des]];
        NSString *img = [NSString stringWithFormat:@"%@",_OneAllModel.shareimg];
        //    img = [self base64jiemiWithStr:[JKEncrypt returnJiemiStringWithString:img]];
        NSString *linkurl =[NSString stringWithFormat:@"%@",_OneAllModel.sharelinkurl];
        //    linkurl = [self base64jiemiWithStr:[JKEncrypt returnJiemiStringWithString:linkurl]];
        [JKWXShare WXShareWithTitle:title withDescription:des withImageURL:img withWebURL:linkurl withWXScene:type];
}

-(void)backToMessageVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getOnedollarsData{
    //&yyid=%@&weid=%@
    [[JKProgressHuD shareJKProgressHuD] showProgreessHuD:@"加载中" andView:self.view];
    NSDictionary *params = @{@"yyid":self.str_one_yyid,@"weid":self.str_one_weid};
    [[AFAppDotNetAPIClient sharedClient] POST:BBG_ONEDETAILS parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [[JKProgressHuD shareJKProgressHuD] dismiss];
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            NSString *str_message=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            NSLog(@"OneDetails:%@",str_message);
            if (code == 200) {
                OneAllModel * model=[OneAllModel mj_objectWithKeyValues:responseObject];
                
                _OneAllModel=model;
//                NSDictionary *dic_yiyuan=[model.yiyuan objectAtIndex:0];
                OneYiyuanModel *model_yiyuan=[OneYiyuanModel mj_objectWithKeyValues:[model.yiyuan objectAtIndex:0]];
                _YiYuanModel=model_yiyuan;
                
                OneLuckuserModel *luckuser= [OneLuckuserModel mj_objectWithKeyValues:[responseObject objectForKey:@"luckuser"]];
                _LuckUserModel=luckuser;
                
                OneYygnewModel *new_one= [OneYygnewModel mj_objectWithKeyValues:[responseObject objectForKey:@"yygnew"]];
                _NewOneModel=new_one;

               [self loadLayoutView];
                
            }else{
                [[JKProgressHuD shareJKProgressHuD] showProgreessText:@"该商品未找到" andView:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        
        [[JKProgressHuD shareJKProgressHuD] showProgreessText:@"网络异常,请稍后再试" andView:self.view];
    }];
    
    
}
-(void)loadLayoutView{
    int num_yiyuan;
    int num_scroll;
    //状态，1、普通状态; 2、揭晓已完成;3、倒计时中
    NSString *str_State=[NSString stringWithFormat:@"%@",_YiYuanModel.State];
    int num_centent=80*kFloatSize;
    if ([str_State isEqualToString:@"1"]) {
        
        num_scroll=0;
        num_yiyuan=65*kFloatSize;
        num_centent=50*kFloatSize;
    }else if ([str_State isEqualToString:@"2"]){
        num_scroll=150*kFloatSize;
        num_yiyuan=180*kFloatSize;
    }else if ([str_State isEqualToString:@"3"]){
        num_scroll=65*kFloatSize;
        num_yiyuan=100*kFloatSize;
    }
    
    mainScroll.contentSize=CGSizeMake(self.view.frame.size.width, 750*kFloatSize+num_scroll);
    //标题的高度
    CGFloat _title_Height=[self getHeightByWidth:295*kFloatSize title:_OneAllModel.productname font:[UIFont systemFontOfSize:14*kFloatSize]];;
    
    
    OneHeadDetailsView *headview=[[OneHeadDetailsView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,295*kFloatSize+5*kFloatSize+_title_Height+15*kFloatSize+15*kFloatSize+num_yiyuan) withType:str_State withTitleHight:_title_Height];
    headview.backgroundColor=[UIColor whiteColor];
    __weak typeof(self) headweakSelf=self;
    headview.headLookTaNumberBlock=^(){
        __strong typeof(headweakSelf) headstrongSelf=headweakSelf;
        [headstrongSelf lookTaNumber];
    };
    
    headview.lookJsDetailsBlock=^(){
        __strong typeof(headweakSelf) headstrongSelf=headweakSelf;
        [headstrongSelf lookJsDetailsWebView];
    };

    headview.headTimeShowEnd=^(){
        __strong typeof(headweakSelf) headstrongSelf=headweakSelf;
        [headstrongSelf toOnetimeView];
    };
    [mainScroll addSubview:headview];
    [headview setOneDollarModel:_YiYuanModel withAllmodel:_OneAllModel withLuckUserMosel:_LuckUserModel];
    
    OneCentreView *centreView=[[OneCentreView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headview.frame), self.view.frame.size.width, num_centent) withType:str_State];
    [centreView setBackgroundColor:[UIColor clearColor]];
    
    [centreView.layer setBorderWidth:1.0*kFloatSize];
    
    [centreView.layer setBorderColor:[GlobalObject colorWithHexString:@"#E0DEDF"].CGColor];
    
    __weak typeof(self) weakSelf = self;

    centreView.lookMyNumberBlock = ^(){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf lookMyNumber];
    };
    
    centreView.buyNewsOneBlock = ^(){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getOneNewList];
    };
    
    [mainScroll addSubview:centreView];
    
    [centreView setOneDollarModel:_OneAllModel withModelTyple:str_State];
    
    
    OneDetailsBottomView *detailsBottomView=[[OneDetailsBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(centreView.frame), self.view.frame.size.width, 230*kFloatSize)];
    [detailsBottomView setBackgroundColor:[UIColor whiteColor]];
    
    [detailsBottomView.layer setBorderWidth:1.0*kFloatSize];
    
    [detailsBottomView.layer setBorderColor:[GlobalObject colorWithHexString:@"#E0DEDF"].CGColor];
    
    __weak typeof(self) BottomweakSelf=self;
    detailsBottomView.bottomWebBlock=^(NSString *str_tag){
        __strong typeof(BottomweakSelf) bottomstrongSelf=BottomweakSelf;
        [bottomstrongSelf bottomProductWeb:str_tag];
    };
    [mainScroll addSubview:detailsBottomView];
    
    [self creatNowBuyView:str_State];
    
    
}
-(void)creatNowBuyView:(NSString *)str_State{
    
    NSString *str_btn_title;
    if ([str_State isEqualToString:@"1"]) {
    str_btn_title=@"立即抢购";
    }else{
    str_btn_title=@"一元抢购";
    }
    UIView *bottom_back_view=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-45*kFloatSize, self.view.frame.size.width, 45*kFloatSize)];
    bottom_back_view.backgroundColor=[GlobalObject colorWithHexString:@"#EAEBEC"];
    [self.view addSubview:bottom_back_view];
    
    nowBuyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    nowBuyBtn.frame = CGRectMake(13*kFloatSize, 7*kFloatSize, self.view.frame.size.width-26*kFloatSize, 33*kFloatSize);
    nowBuyBtn.backgroundColor=[GlobalObject colorWithHexString:@"#f0497f"];
    [nowBuyBtn setTitle:str_btn_title forState:UIControlStateNormal];
    [nowBuyBtn addTarget:self action:@selector(CLick_addviewBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [nowBuyBtn.layer setMasksToBounds:YES];
    [nowBuyBtn.layer setCornerRadius:8.0*kFloatSize];
    [nowBuyBtn.layer setBorderWidth:1.0*kFloatSize];
    
    [nowBuyBtn.layer setBorderColor:[GlobalObject colorWithHexString:@"#EA4C7F"].CGColor];
    
    [bottom_back_view addSubview:nowBuyBtn];
    
    buyBackView=[[UIView alloc]init];
    CGRect backFrame=self.navigationController.view.frame;
//    backFrame.size.height-=nowBuyBtn.frame.size.height;
    buyBackView.frame=backFrame;
    buyBackView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];
    buyBackView.userInteractionEnabled=YES;
    
    UIView* whiteBackView=[[UIView alloc]init];
    whiteBackView.backgroundColor=[UIColor whiteColor];
    whiteBackView.frame=CGRectMake(0, 455*kFloatSize-45*kFloatSize-15*kFloatSize-45*kFloatSize, buyBackView.frame.size.width, 217*kFloatSize);
    //    }else
    
    whiteBackView.userInteractionEnabled=YES;
    [buyBackView addSubview:whiteBackView];
    
    
    UIButton *btn_close=[UIButton buttonWithType:UIButtonTypeCustom];
    btn_close.frame = CGRectMake(295*kFloatSize, 7*kFloatSize, 15*kFloatSize, 15*kFloatSize);
    btn_close.backgroundColor=[UIColor clearColor];
    [btn_close setImage:[UIImage imageNamed:@"close_view.png"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(CLick_closeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackView addSubview:btn_close];
    
    UILabel *lbl_join=[[UILabel alloc]initWithFrame:CGRectMake(0, 15*kFloatSize, whiteBackView.frame.size.width, 15*kFloatSize)];
    lbl_join.text=@"参与人次";
    lbl_join.textAlignment=NSTextAlignmentCenter;
    [lbl_join setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    lbl_join.textColor=[GlobalObject colorWithHexString:@"#6E6E6E"];
    [whiteBackView addSubview:lbl_join];
    
//    self.perTitleLab=[[UILabel alloc]init];
//    self.perTitleLab.frame=CGRectMake(37*kFloatSize,45*kFloatSize, 45, 36);
//    self.perTitleLab.font=[UIFont systemFontOfSize:15];
//    self.perTitleLab.textColor=[UIColor colorWithWhite:166.0/255.0 alpha:1.0];
//    self.perTitleLab.text=@"数量";
//    [whiteBackView addSubview:self.perTitleLab];
    
    self.reduceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceBtn.frame=CGRectMake(39*kFloatSize, 45*kFloatSize, 32*kFloatSize, 32*kFloatSize);
    [self.reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.reduceBtn setTitleColor:[GlobalObject colorWithHexString:@"#9D9D9D"] forState:UIControlStateNormal];
    self.reduceBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17*kFloatSize];
    self.reduceBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.reduceBtn.layer.borderWidth=0.6*kFloatSize;
    self.reduceBtn.backgroundColor=[UIColor whiteColor];
    [self.reduceBtn addTarget:self action:@selector(Click_reduceBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.numLab=[[UILabel alloc]init];
    self.numLab.frame=CGRectMake(CGRectGetMaxX(self.reduceBtn.frame)-1*kFloatSize, self.reduceBtn.frame.origin.y, 178*kFloatSize, 32*kFloatSize);
    self.numLab.textAlignment=NSTextAlignmentCenter;
    self.numLab.font=[UIFont systemFontOfSize:12*kFloatSize];
    self.numLab.textColor=[UIColor blackColor];
    self.numLab.text=@"1";
    self.numLab.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.numLab.layer.borderWidth=0.6*kFloatSize;
    [whiteBackView addSubview:self.numLab];
    //后加这个button
    [whiteBackView addSubview:self.reduceBtn];
    
    self.addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame=CGRectMake(247*kFloatSize, 45*kFloatSize, 32*kFloatSize, 32*kFloatSize);
    [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[GlobalObject colorWithHexString:@"#9D9D9D"] forState:UIControlStateNormal];
    self.addBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17*kFloatSize];
    self.addBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.addBtn.layer.borderWidth=0.6*kFloatSize;
    self.addBtn.backgroundColor=[UIColor whiteColor];
    [self.addBtn addTarget:self action:@selector(Click_addBtn:) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackView addSubview:self.addBtn];
    
    
     NSArray *array_money = [NSArray arrayWithObjects:@"5",@"20",@"50",@"100",nil];
    CGRect frameA=CGRectMake(39*kFloatSize, 85*kFloatSize, 50*kFloatSize, 25*kFloatSize);
    for (int i=0; i<4; i++) {
        
        
        UIButton * btn_num;
        
        
        
        frameA.origin.x=i*63*kFloatSize+39*kFloatSize;
        
        
        NSString *str_num=[NSString stringWithFormat:@"%@",[array_money objectAtIndex:i]];
       btn_num= [self createButton:str_num WithFrame:frameA];
        
        
        
        [btn_num addTarget:self action:@selector(Click_sectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn_num.tag=i;
        
        [whiteBackView addSubview:btn_num];
    }

    UILabel *lbl_line=[[UILabel alloc]initWithFrame:CGRectMake(15*kFloatSize, 120*kFloatSize, whiteBackView.frame.size.width-30*kFloatSize, 1*kFloatSize)];
    lbl_line.backgroundColor=[GlobalObject colorWithHexString:@"#DEDEDE"];
    [whiteBackView addSubview:lbl_line];
    
    _Lab_money=[[UILabel alloc]initWithFrame:CGRectMake(0, 138*kFloatSize, whiteBackView.frame.size.width, 15*kFloatSize)];
    _Lab_money.textColor=[GlobalObject colorWithHexString:@"#ED4D81"];
    [_Lab_money setFont:[UIFont systemFontOfSize:14*kFloatSize]];
    _Lab_money.textAlignment=NSTextAlignmentCenter;
    
//    NSString *str_money=@"共";
    NSString *str_money_num=[NSString stringWithFormat:@"%@",self.numLab.text];
//    NSString *name_content=[NSString stringWithFormat:@"%@%@.00元",str_money,str_money_num];
//    
//    NSMutableAttributedString *str_num = [[NSMutableAttributedString alloc] initWithString:name_content];
//    NSInteger join_int=str_money.length;
//    [str_num addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#989597"] range:NSMakeRange(0,join_int)];
    
    _Lab_money.attributedText=[self createLabelText:str_money_num];
    [whiteBackView addSubview:_Lab_money];
    
    
   UIButton * Btn_buy=[UIButton buttonWithType:UIButtonTypeCustom];
    Btn_buy.frame = CGRectMake(0, 172*kFloatSize, self.view.frame.size.width, 45*kFloatSize);
    Btn_buy.backgroundColor=[UIColor colorWithRed:233.0/255.0 green:46.0/255.0 blue:106.0/255.0 alpha:1.0];
    [Btn_buy setTitle:@"立即抢购" forState:UIControlStateNormal];
    [Btn_buy addTarget:self action:@selector(Click_setOrder:) forControlEvents:UIControlEventTouchUpInside];
   [whiteBackView addSubview:Btn_buy];
    

    
}
-(void)CLick_addviewBtn:(UIButton *)btn{
    NSString *str_name=[NSString stringWithFormat:@"%@",btn.titleLabel.text];
    if ([str_name isEqualToString:@"立即抢购"]) {
        btn.hidden=YES;
        [self.navigationController.view addSubview:buyBackView];
        //购买
        if (btn.selected) {
            
            
        }
        //弹出选择框
        else
        {
            
            //               [self.navigationController.view addSubview:buyBackView];
        }

    }else{
        [self getOneNewList];
    }
    
   
}
-(void)CLick_nowBuyBtn:(UIButton*)btn
{
    
     }
-(void)CLick_closeBtn:(UIButton*)btn{
    nowBuyBtn.hidden=NO;
    if (buyBackView) {
        [buyBackView removeFromSuperview];
    }
    
}

-(void)Click_addBtn:(UIButton*)btn
{
    NSInteger count=[self.numLab.text integerValue];
//    if (count>=100||count==0) {
//        return;
//    }
    count++;
    
    
    
    NSString *remainStr=[NSString stringWithFormat:@"%@",[NSString  stringWithFormat:@"%d",_YiYuanModel.ProCount.intValue-_YiYuanModel.SalerCount.intValue]];
    NSInteger rem_num=[remainStr integerValue];
    
    if (count>=rem_num) {
        [[JKProgressHuD shareJKProgressHuD]showProgreessText:[NSString stringWithFormat:@"剩余%@次",remainStr] andView:self.view];
        
        self.numLab.text=[NSString stringWithFormat:@"%@",remainStr];
        _Lab_money.attributedText=[self createLabelText:remainStr];
    }else{
        self.numLab.text=[NSString stringWithFormat:@"%ld",count];
        _Lab_money.attributedText=[self createLabelText:self.numLab.text];    }
    
}
-(void)Click_reduceBtn:(UIButton*)btn
{
    NSInteger count=[self.numLab.text integerValue];
    if (count<=1) {
        return;
    }
    count--;
    self.numLab.text=[NSString stringWithFormat:@"%ld",count];
     _Lab_money.attributedText=[self createLabelText:self.numLab.text];
}
-(void)Click_sectionBtn:(UIButton *)btn{
    
    NSString *str_num=[NSString stringWithFormat:@"%@",btn.titleLabel.text];
    NSString *old_str_num=[NSString stringWithFormat:@"%@",self.numLab.text];
    
    NSInteger new_number=[str_num integerValue];
    NSInteger old_number=[old_str_num integerValue];
    
    NSInteger old_new_num=new_number+old_number;
    NSString *str_old_new_num=[NSString stringWithFormat:@"%ld",old_new_num];
    
    NSString *remainStr=[NSString stringWithFormat:@"%@",[NSString  stringWithFormat:@"%d",_YiYuanModel.ProCount.intValue-_YiYuanModel.SalerCount.intValue]];
    NSInteger rem_num=[remainStr integerValue];
    
    if (old_new_num>=rem_num) {
        [[JKProgressHuD shareJKProgressHuD]showProgreessText:[NSString stringWithFormat:@"剩余%@次",remainStr] andView:self.view];
        self.numLab.text=[NSString stringWithFormat:@"%@",remainStr];
        _Lab_money.attributedText=[self createLabelText:remainStr];
    }else{
        self.numLab.text=[NSString stringWithFormat:@"%@",str_old_new_num];
        _Lab_money.attributedText=[self createLabelText:str_old_new_num];
    }
    
    
}
#pragma mark ---查看我的号码---
-(void)lookMyNumber{
    NSArray *ary_Isstate=_OneAllModel.yiyuan;
    NSDictionary *dic_Isstate=[ary_Isstate objectAtIndex:0];
    lucklooknumberView=[[OneLookLuckNumberView alloc]initWithFrame:[UIScreen mainScreen].bounds andInfo:_OneAllModel.userblist andinfoDic:dic_Isstate];
    lucklooknumberView.delegate=self;
    [self.navigationController.view addSubview:lucklooknumberView];
    
}

#pragma mark ---查看Ta的号码---

-(void)lookTaNumber{
    
    
    NSArray *ary_Isstate=_OneAllModel.yiyuan;

    NSDictionary *dic_Isstate=[ary_Isstate objectAtIndex:0];
    lucklooknumberView=[[OneLookLuckNumberView alloc]initWithFrame:[UIScreen mainScreen].bounds andInfo:_OneAllModel.luckblist andinfoDic:dic_Isstate];
    lucklooknumberView.delegate=self;
    [self.navigationController.view addSubview:lucklooknumberView];
}

-(void)quitLookview:(OneLookLuckNumberView *)lookview{
    if (lucklooknumberView) {
        [lucklooknumberView removeFromSuperview];
        lucklooknumberView = nil;
    }
    
}
#pragma mark ---查看计算详情---

-(void)lookJsDetailsWebView{
    NSArray *ary_Isstate=_OneAllModel.yiyuan;
    NSDictionary *dic_Isstate=[ary_Isstate objectAtIndex:0];
   
   NSString *yiyuan_id=[NSString stringWithFormat:@"%@",[dic_Isstate objectForKey:@"id"]];
    
       NSString* str_weid=[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:@"weid"]];
    OneDetailsLookWebView *web_look=[[OneDetailsLookWebView alloc]init];
    web_look.str_to_url=[NSString stringWithFormat:BBG_ONEJSGS,str_weid,yiyuan_id];
    
    web_look.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:web_look animated:YES];
}
#pragma mark ---NewOne---
-(void)getOneNewList{
    NSString *good_id=[NSString stringWithFormat:@"%@",_NewOneModel.id];
    mainScroll.contentOffset=CGPointMake(0, 0);
    self.str_one_yyid=[NSString stringWithFormat:@"%@",good_id];
    
//    for (UIView *subview in mainScroll.subviews) {
//        [subview removeFromSuperview];
//    }
     [mainScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self getOnedollarsData];
   
}
#pragma mark ---bottomWeb---
-(void)bottomProductWeb:(NSString *)str_tag{
    // 1：商品介绍，2：规格参数，3：购买评价
    //#define BBG_ONESPXQ   @"http://postc.bbg.159.net/p1/105.aspx?weid=%@&t=1"
    //往期揭晓
    //#define BBG_ONEWQJX   @"http://postc.bbg.159.net/yyg/yyghistory.aspx?weid=00w6a9yb&proid=91&termid=1"
    //商品评价
    //#define BBG_ONEPJ   @"http://postc.bbg.159.net/p1/105.aspx?weid=%@&t=3"
    
    NSString* str_weid=[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:@"weid"]];
    NSString* str_proid=[NSString stringWithFormat:@"%@",_YiYuanModel.ProductId];
    NSString* str_termid=[NSString stringWithFormat:@"%@",_YiYuanModel.Termid];
    NSString *aw_url;
    if ([str_tag isEqualToString:@"1001"]) {
        aw_url=[NSString stringWithFormat:BBG_ONESPXQ,str_weid,str_proid];
    }else if ([str_tag isEqualToString:@"1002"]){
        aw_url=[NSString stringWithFormat:BBG_ONEWQJX,str_proid,str_termid];
    }else if([str_tag isEqualToString:@"1003"]){
        aw_url=[NSString stringWithFormat:BBG_ONEPJ,str_proid];
    }else{
        aw_url=BBG_ONEXY;
    }
    OneDetailsLookWebView *web_look=[[OneDetailsLookWebView alloc]init];
    //    web_look.str_to_url=[NSString stringWithFormat:BBG_ONEJSGS,@"1","1"];
    web_look.str_to_url=aw_url;
    web_look.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:web_look animated:YES];

    
}

-(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
-(UIButton *)createButton:(NSString*)num WithFrame:(CGRect)frame
{
    //30
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitle:num forState:UIControlStateNormal];
   
    [btn setTitleColor:[GlobalObject colorWithHexString:@"#838383"] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:14*kFloatSize];
    btn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    btn.layer.borderWidth=0.6*kFloatSize;
    btn.backgroundColor=[UIColor whiteColor];
    
    
    
    return btn;
}

-(NSMutableAttributedString *)createLabelText:(NSString*)num
{
    NSString *str_money=@"共";
    NSString *str_money_num=[NSString stringWithFormat:@"%@",num];
    NSString *name_content=[NSString stringWithFormat:@"%@%@.00元",str_money,str_money_num];
    
    NSMutableAttributedString *str_num = [[NSMutableAttributedString alloc] initWithString:name_content];
    NSInteger join_int=str_money.length;
    [str_num addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#989597"] range:NSMakeRange(0,join_int)];
    
    return str_num;
}
//提交订单
-(void)Click_setOrder:(UIButton*)btn
{
    [[JKProgressHuD shareJKProgressHuD] showProgreessHuD:@"加载中" andView:self.view];
    
    NSString* strId=[NSString stringWithFormat:@"%@",_YiYuanModel.id];
    NSString* strCount=[NSString stringWithFormat:@"%@", self.numLab.text];

//    NSString *weid = [UserDefaults objectForKey:@"weid"];
     NSString* weid=@"0ccm07e5";
    NSString *ip = [GlobalObject localIPAddress];
    NSString *sign = [NSString stringWithFormat:@"action=addcartorder&weid=%@&ip=%@&yygid=%@&amount=%@",weid,ip,strId,strCount];
    sign = [self getSignwithsign:sign];
    NSDictionary *dict = @{@"weid":weid,@"ip":ip,@"yygid":strId,@"amount":strCount,@"sign":sign};
    NSString *url = [NSString stringWithFormat:@"%@%@",COMMON_HEAD,addcartorder];
    [[AFAppDotNetAPIClient sharedClient] POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([[responseObject objectForKey:@"code"] integerValue]==200) {
                NSString *sign1 = [NSString stringWithFormat:@"state=%@&totalfee=%@&tradenum=%@",[responseObject objectForKey:@"state"],[responseObject objectForKey:@"totalfee"],[responseObject objectForKey:@"tradenum"]];
                NSInteger state = [[responseObject objectForKey:@"state"] integerValue];
                switch (state) {
                    case 0:
                    {
                        sign1 = [self getSignwithsign:sign1];
                        if ([[responseObject objectForKey:@"sign"] isEqualToString:sign1]) {
                            _payDict = responseObject;
                            [self payWith];
                            //                            [self pushToPaySuccessVC];
                        }
                    }
                        break;
                    case 1:
                    {
                        [GlobalObject showProgresshudInView:self.view withText:@"亲，订单重复提交"];
                    }
                        break;
                    case 2:
                    {
                        [GlobalObject showProgresshudInView:self.view withText:@"亲，该商品已被抢光"];
                    }
                        break;
                        
                    default:
                        [GlobalObject showProgresshudInView:self.view withText:@"数据异常，请稍后再试"];
                        break;
                }
            }else if([[responseObject objectForKey:@"code"] integerValue]==201)
            {
                [GlobalObject showProgresshudInView:self.view withText:@"警告：今日参与一元抢购已超过10000元，请明天再来玩！一元抢购仅供本平台会员间娱乐，切勿沉迷；抢红包仅供娱乐，不用于盈利目的！平台并不分成或收费！"];
            }
            else if([[responseObject objectForKey:@"code"] integerValue]==202)
            {
                [GlobalObject showProgresshudInView:self.view withText:@"您还不是创客，只能参与10次一元购！立即获取创客身份，任性一元购！"];
//                [self go99Page];
            }
            else if([[responseObject objectForKey:@"code"] integerValue]==203)
            {
               [self goAddAddressPage];
                [GlobalObject showProgresshudInView:self.view withText:@"您还没有默认收货地址，不能参与一元抢购。请先设置一个默认收货地址!"];
            }else
            {
                [GlobalObject showProgresshudInView:self.view withText:@"数据异常，请稍后再试"];
            }
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        [GlobalObject showProgresshudInView:self.view withText:@"网络异常,请稍候再试"];
    }];
    NSLog(@"提交订单");
}
-(NSString *)getSignwithsign:(NSString *)sign{
    sign = [NSString stringWithFormat:@"%@&key=%@",sign,BBGSIGNKEY];
    sign = [GlobalObject md5HexDigest:sign];
    sign = [sign uppercaseString];
    return sign;
}
#pragma mark - 支付相关
-(void)payWith{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithPayResult:) name:@"PAY_STATE" object:nil];
    
    /*
     //商品或支付单简要描述
     NSString *body = @"玫瑰养肤精华液";
     //附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据
     NSString *attach = @"postc.bbg.159.net";
     //商户系统内部的订单号,32个字符内、可包含字母,
     NSString *out_trade_no = @"UHIdsaduosdausdao02";
     //接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
     NSString *notify_url = @"http://ceshi.159.net/netpay/wechat/payNotifyUrl6.aspx";
     //交易金额默认为人民币交易，接口中参数支付金额单位为【分】，参数值不能带小数。对账单中的交易金额单位为【元】。
     NSString *total_fee = @"1";
     */
    
    NSString *body = [NSString stringWithFormat:@"%@",_YiYuanModel.ProductName];
    NSString *out_trade_no = [NSString stringWithFormat:@"%@",[_payDict objectForKey:@"tradenum"]];
    NSString *notify_url = [NSString stringWithFormat:NOTIFY_URL_YY,COMMON_ZZCKJ];
    NSString *totalfee = [NSString stringWithFormat:@"%.0f",[[_payDict objectForKey:@"totalfee"] floatValue]*100];
    
    
    NSDictionary *dict = @{@"body":body,
                           @"out_trade_no":out_trade_no,
                           @"notify_url":notify_url,
                           @"total_fee":totalfee
                           };
    [[JKWXPay shareInstance] payWithInfo:dict];
}

-(void)dealWithPayResult:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] removeObserver:@"PAY_STATE"];
    NSString *state = notification.object;
    NSString *resultString;
    if ([state isEqualToString:@"1"]) {
        resultString = @"支付成功";
        [self pushToPaySuccessVC];
        return;
    }else if ([state isEqualToString:@"2"]){
        resultString = @"支付取消";
    }
    else if ([state isEqualToString:@"3"]){
        resultString = @"支付失败";
    }
    else if ([state isEqualToString:@"4"]){
        resultString = @"支付信息异常";
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [GlobalObject showProgresshudInView:window withText:resultString];
    //[self backToUp];
}
-(void)pushToPaySuccessVC{
    JKYYPaySuccessController *paySuccessVC = [[JKYYPaySuccessController alloc]init];
    paySuccessVC.PayOrderCode = [NSString stringWithFormat:@"%@",[_payDict objectForKey:@"tradenum"]];;
    [self.navigationController pushViewController:paySuccessVC animated:YES];
}

//倒计时结束
-(void)toOnetimeView{
    //    for (UIView *subview in mainScroll.subviews) {
    //        [subview removeFromSuperview];
    //    }
    [mainScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self viewWillAppear:YES];
}
//前往添加收获地址页面
-(void)goAddAddressPage{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *weid=[NSString stringWithFormat:@"%@",[user objectForKey:@"weid"]];
    weid=[JKEncrypt returnJiamiStringWithString:[JKEncrypt base64StringFromText:weid]];
    JKCommonWebView *webVC=[[JKCommonWebView alloc]init];
    //    webVC.str_to_url=[NSString stringWithFormat:@"%@/editaddress/0?weid=%@",COMMON_HEAD,weid];
    //http://c.app.zckj.159.net/address?weid=nBcWr11319
    webVC.str_to_url=@"http://c.app.zckj.159.net/address?weid=nBcWr11319";
    
    //    webVC.identifier = @"gooddetail";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:webVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
