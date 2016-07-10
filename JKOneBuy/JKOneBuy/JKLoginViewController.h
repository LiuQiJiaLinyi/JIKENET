//
//  JKLoginViewController.h
//  BoBoBuy
//
//  Created by teaplant on 16/3/1.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "JKRootViewController.h"
@class ShoppingCartViewController;


@interface JKLoginViewController : JKRootViewController

@property (nonatomic ,weak)UITabBarController*mainTabbar;
@property (nonatomic,weak)ShoppingCartViewController * weakShoppingCart;
@end
