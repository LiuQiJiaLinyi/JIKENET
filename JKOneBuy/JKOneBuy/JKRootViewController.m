//
//  JKRootViewController.m
//  ISayForU
//
//  Created by teaplant on 14-8-31.
//  Copyright (c) 2014年 teaplant. All rights reserved.
//

#import "JKRootViewController.h"
#import "GlobalObject.h"
#import <UIImage+GIF.h>

@interface JKRootViewController ()

@end

@implementation JKRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//
-(void)addTitleViewWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor =[ GlobalObject colorWithHexString:@"#FFFFFF"];
    //根据字体名称和字体大小得到UIFont实例
    [label setFont:[UIFont boldSystemFontOfSize:16]];
    label.text = title;
    self.navigationItem.titleView=label;
}
-(void)addTitleViewWithTitle:(NSString *)title imageName:(NSString *)imageName selectedimageName:(NSString *)selectedimageName selector:(SEL)selector location:(BOOL)isLeft andFrame:(CGRect)frame;{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedimageName] forState:UIControlStateHighlighted];
   [btn setFrame:frame];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    //标题颜色
    [btn setTitleColor:[GlobalObject colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    UIBarButtonItem *item  =[[UIBarButtonItem alloc] initWithCustomView:btn];
    if (isLeft == YES) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
}


@end
