//
//  JKRootViewController.h
//  ISayForU
//
//  Created by teaplant on 14-8-31.
//  Copyright (c) 2014年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalObject.h"
#import "define.h"

#define  MainSize [UIScreen mainScreen].bounds.size.width/(float)320

@class MBProgressHUD;
@interface JKRootViewController : UIViewController{


}


//设置标题
-(void)addTitleViewWithTitle:(NSString *)title;

//设置按钮

-(void)addTitleViewWithTitle:(NSString *)title imageName:(NSString *)imageName selectedimageName:(NSString *)selectedimageName selector:(SEL)selector location:(BOOL)isLeft andFrame:(CGRect)frame;







@end
