//
//  shopCarCell.h
//  BoBoBuy
//
//  Created by Jiker on 15/12/30.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneYiyuanModel.h"
@interface shopCarCell : UITableViewCell

@property(retain,nonatomic)UIButton* selectBtn;
@property(retain,nonatomic)UIImageView* headerView;
@property(retain,nonatomic)UILabel* titleLab;
@property(retain,nonatomic)UILabel* allPerNumLab;
//@property(retain,nonatomic)UILabel* remainPerNumLab;
@property(retain,nonatomic)UILabel* perTitleLab;
@property(retain,nonatomic)UIButton* reduceBtn;
@property(retain,nonatomic)UIButton* addBtn;
@property(retain,nonatomic)UITextField* numTF;

@property(retain,nonatomic)UIButton* deleteBtn;


-(void)setDataWithModel:(OneYiyuanModel*)model WithIsEdit:(BOOL)isEdit;
@end
