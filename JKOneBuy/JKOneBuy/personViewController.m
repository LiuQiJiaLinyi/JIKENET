//
//  personViewController.m
//  NewOnePay
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "personViewController.h"
#import "define.h"
#import "PersonalCenter/PsersonalTapV.h"
#import "JKLoginViewController.h"
#import <UIImageView+WebCache.h>

#import "JKLoginViewController.h"

@interface personViewController()
{
    UIView * headView;
    UITapGestureRecognizer * tapIt;
    NSDictionary * userInfor;
    UIImageView * avaterImage;
    
}
@end


@implementation personViewController
-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"个人中心"];
    self.navigationController.navigationBar.barTintColor=[GlobalObject colorWithHexString:@"#ED4D80"];
    

    

    self.view.backgroundColor = [UIColor whiteColor];
    //[self setNav];
    [self buildUI];
    [self gotUserInfor];
    
    [self reciveDataFromInternet];
}

-(void)setNav
{
    self.navigationItem.title = @"个人中心";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:233.0/255.0 green:46.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftbtn addTarget:self action:@selector(backToMessageVC) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"nav_bar_left_new.png"] forState:UIControlStateNormal];
    [leftbtn setFrame:CGRectMake( 0, 0, 12*kFloatSize, 17*kFloatSize)];
    UIBarButtonItem *leftItem  =[[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)backToMessageVC
{

}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    if ([self isLogin]) {

    }else{
        
        JKLoginViewController *loginVC=[[JKLoginViewController alloc]init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
       
        
    }

}

#pragma mark --搭建UI--
-(void)buildUI
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,110*kFloatSize)];
    headView.backgroundColor = [UIColor colorWithRed:0.996 green:0.851 blue:0.910 alpha:1.00];
    headView.userInteractionEnabled = YES;
    headView.tag = 708849;
    
    UITapGestureRecognizer * tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCilked:)];
    [headView addGestureRecognizer:tapgesture];
    tapgesture.numberOfTouchesRequired = 1;
    
    avaterImage = [[UIImageView alloc] initWithFrame:CGRectMake(headView.bounds.size.width/2 - (26 *kFloatSize), 12 * kFloatSize, 52 *kFloatSize, 52 *kFloatSize)];
    avaterImage.layer.cornerRadius = (52 * kFloatSize) /2;
    [avaterImage setImage:[UIImage imageNamed:@"personal_head_image"]];
    
    UILabel * namelabel = [[UILabel alloc] initWithFrame:CGRectMake(avaterImage.frame.origin.x, avaterImage.frame.origin.y + avaterImage.frame.size.height, avaterImage.frame.size.width, 18 *kFloatSize)];
    
    UIImageView * levelImage = [[UIImageView alloc] initWithFrame:CGRectMake(avaterImage.frame.origin.x, avaterImage.frame.origin.y + avaterImage.frame.size.height + namelabel.bounds.size.height, avaterImage.frame.size.width, 18 *kFloatSize)];
    levelImage.backgroundColor =[UIColor clearColor];
    levelImage.alpha =1;
    
    levelImage.layer.cornerRadius = (levelImage.bounds.size.width)/2;
    [levelImage setImage:[UIImage imageNamed:@"level_imVIP"]];
    
    [headView addSubview:avaterImage];
    [headView addSubview:namelabel];
    [headView addSubview:levelImage];
    [self.view addSubview:headView];
    
    
    
    NSArray * name_strAr = @[@"夺宝记录",@"中奖转卖",@"商品评价",@"财务明细"];
    NSArray * RImage_strAr = @[@"personal_prize_record",@"personal_prize_sold",@"personal_goods_commit",@"personal_finance_detail"];
    NSArray * LImage_strAr = @[@"personal_left_image",@"",@"",@""];
    
    for (int i = 0; i <4; i++)
    {
        PsersonalTapV * tapView = [[PsersonalTapV alloc] initWithFrame:CGRectMake(0, headView.bounds.origin.x + (headView.bounds.size.height)+(45 * kFloatSize * i), [UIScreen mainScreen].bounds.size.width, 45 * kFloatSize)];
        tapView.namelabel.text = name_strAr[i];
        [tapView.rightImageView setImage:[UIImage imageNamed:RImage_strAr[i]]];
        [tapView.leftImageView setImage:[UIImage imageNamed:LImage_strAr[0]]];
        
        
        tapView.tag = 708850 +i;
        tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCilked:)];
        tapIt.numberOfTouchesRequired = 1;
        tapView.userInteractionEnabled = YES;
        [tapView addGestureRecognizer:tapIt];
        [self.view addSubview:tapView];
        
    }
    
}

#pragma mark-
#pragma mark --从文件userInformation中解档（储存为字典）
/* IsAgent = 0;
 IsStock = 0;
 IsSupplier = 0;
 WechatCount = 0;
 attach = "\U73ed\U7ea7";
 bossid = www159net;
 city = "\U5eca\U574a\U5e02";
 code = 200;
 confirmbalance = "400.02";
 country = "\U4e2d\U56fd";
 hasProp = 0;
 headimgurl = "http://wx.qlogo.cn/mmopen/ajNVdqHZLLDt4dpBPdyAy6NgXqR37Ku1f972CWx15P8ZfibxdJia2rKUK1gntxqVLicgB9SoGKzliaqB9oSW7DV5Gg/0";
 isblack = 0;
 level = 2;
 mastertime = "2016-06-08 15:49:19";
 mobilephone = 15263986077;
 monitornum = www159net;
 name = "\U6587\U7533";
 nickname = "\U9f99\U4e95\U8336";
 planbalance = "400.02";
 province = "\U6cb3\U5317\U7701";
 stocktime = "0001-01-01 00:00:00";
 userlevel = 1;
 wechat = wenshen;
 weid = nBcWr11319;
 xuehao = 123222;
 */
-(void)gotUserInfor
{
    NSData *_data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithModelKey:@"userInformation"]];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:_data];
    userInfor = [unarchiver decodeObjectForKey:@"userInformation"];
    
    NSString * iamgeUrl = userInfor[@"headimgurl"];
    
    NSURL * imageUrl = [NSURL URLWithString:iamgeUrl];
    
    [avaterImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"personal_head_image"]];
    
    [unarchiver finishDecoding];
}
    //得到Document目录
-(NSString *)getFilePathWithModelKey:(NSString *)modelkey
{
 NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
NSLog(@"%@,%s",[[array objectAtIndex:0] stringByAppendingPathComponent:modelkey],__FUNCTION__);
    
return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
}
/*!
 *  @author zhou, 16-07-07 08:07:23
 *
 *  @brief 点击更改头像,下方点击view
 *
 *  @param gesture 一次点击
 */
-(void)tapCilked:(UIGestureRecognizer *)gesture
{
    //    if (gesture.state != UIGestureRecognizerStateEnded && gesture.state != UIGestureRecognizerStateFailed){
    //        //通过使用 locationInView 这个方法,来获取到手势的坐标不使用gesture.view
    //       CGPoint locationXY= [(UIPanGestureRecognizer*)gesture translationInView:shoppingCarView];
    //
    //       // CGPoint location = [gesture locationInView:gesture.view.superview];
    //        shoppingCarView.center = locationXY;
    //    }
    long tagGes = gesture.view.tag;
    
    switch (tagGes) {
        case 708849:
        {
            //头像更改
            
        }
            break;
        case 708850:
        {
            //夺宝
            
        }
            break;
        case 708851:
        {
            //中奖
            
        }
            break;
        case 708852:
        {
            //评价
        }
            break;
        case 708853:
        {
            //财务明细
            
        }
            break;
            
            
        default:
            break;
    }
    
}

-(void)reciveDataFromInternet
{
    
}

@end
