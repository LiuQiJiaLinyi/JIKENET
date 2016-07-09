//
//  OneDollarBuyViewCell.h
//  BoBoBuy
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneDollarBuyViewCell : UITableViewCell
@property(retain,nonatomic)UIButton* leftBottomBtn;
@property(retain,nonatomic)UIButton* rightBottomBtn;



@property(nonatomic,strong)UIProgressView *left_progressView;
@property(nonatomic,strong)UIImageView *left_imgVC;
@property(nonatomic,strong)UILabel *left_lbl_qishu;
@property(nonatomic,strong)UILabel *left_lbl_title;
@property(nonatomic,strong)UILabel *left_lbl_Count;
@property(nonatomic,strong)UILabel *left_lbl_join;
@property(nonatomic,strong)UILabel *left_lbl_remain;


@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)UIImageView *imgVC;
@property(nonatomic,strong)UILabel *right_lbl_qishu;
@property(nonatomic,strong)UILabel *right_lbl_title;
@property(nonatomic,strong)UILabel *lbl_Count;
@property(nonatomic,strong)UILabel *right_lbl_join;
@property(nonatomic,strong)UILabel *lbl_remain;
-(void)CreateViewArray:(NSArray*)array WihtTarget:(SEL)action WithSelf:(id)del WithTag:(NSInteger)btnTag;
@end
