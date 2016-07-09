//
//  JKCategoryCell.h
//  JKOneBuy
//
//  Created by Jiker on 16/7/5.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKCategoryCell : UITableViewCell

@property (nonatomic ,copy)NSString * name_str;
@property (nonatomic ,copy)NSString * sum_str;
@property (nonatomic ,copy)NSString * left_str;


@property (nonatomic ,copy)UIButton * add_shoppingCartBut;
@property (nonatomic ,copy)UIButton * one_buyBut;
@property (nonatomic ,copy)NSString * image_str;
@property (nonatomic ,copy)UITableView * weak_tableview;
-(void)resetButtonStates:(BOOL)states;
@end
