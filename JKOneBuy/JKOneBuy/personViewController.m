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


@interface personViewController()
{
    UIView * headView;
    UITapGestureRecognizer * tapIt;
    BOOL userIsLogIn;//记录用户是否已经登录
}
@end


@implementation personViewController
-(void)viewDidLoad
{
    [self gotTheUserState];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self judgeLogIn];
    //[self setNav];
    [self reciveDataFromInternet];
    
}
-(void)gotTheUserState
{
    NSString * logState = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLogState"];
    
    if ([logState isEqualToString:@"1"]) {
        userIsLogIn = YES;
    }
    else
    {
        userIsLogIn = NO;
    }
}


-(void)judgeLogIn
{
    if (userIsLogIn)
    {
        JKLoginViewController * login = [[JKLoginViewController alloc] init];
        [self.view addSubview:login.view];
        userIsLogIn = YES;
        [[NSUserDefaults standardUserDefaults] setObject:(id)@"1" forKey:@"userLogState"];
    }
    else
    {
        // [self buildUI];
    }
    
    
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
-(void)viewWillAppear:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.extendedLayoutIncludesOpaqueBars = NO;
        
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
    }
}
-(void)buildUI
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,110*kFloatSize)];
    headView.backgroundColor = [UIColor colorWithRed:0.996 green:0.851 blue:0.910 alpha:1.00];
    headView.userInteractionEnabled = YES;
    headView.tag = 708849;
    
    UITapGestureRecognizer * tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCilked:)];
    [headView addGestureRecognizer:tapgesture];
    tapgesture.numberOfTouchesRequired = 1;
    
    UIImageView * avaterImage = [[UIImageView alloc] initWithFrame:CGRectMake(headView.bounds.size.width/2 - (26 *kFloatSize), 12 * kFloatSize, 52 *kFloatSize, 52 *kFloatSize)];
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
    
    NSLog(@"%s,%@",__FUNCTION__,@"点击tapview触发");
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
