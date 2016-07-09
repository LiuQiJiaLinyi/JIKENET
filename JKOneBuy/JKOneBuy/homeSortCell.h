//
//  homeSortCell.h
//  JKOneBuy
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeSortCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imgVC;
@property(nonatomic,strong)UILabel     *Lab_name;



-(void)CreateViewDict:(NSDictionary*)dic;
@end
