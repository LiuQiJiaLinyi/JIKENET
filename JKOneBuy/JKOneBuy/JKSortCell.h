//
//  JKSortCell.h
//  JKOneBuy
//
//  Created by teaplant on 16/6/23.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKSortModel.h"
@interface JKSortCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *sortImg;

@property (strong, nonatomic) IBOutlet UILabel *sortName;


-(void)setSortInfo:(JKSortModel *)model;

@end
