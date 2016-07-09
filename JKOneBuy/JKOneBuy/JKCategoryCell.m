//
//  JKCategoryCell.m
//  JKOneBuy
//
//  Created by Jiker on 16/7/5.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "JKCategoryCell.h"
#import <UIImageView+WebCache.h>

#define kFloatWidthScale  [UIScreen mainScreen].bounds.size.width/320.f
#define kFloatHeightScale [UIScreen mainScreen].bounds.size.height/608.f

@interface JKCategoryCell()
{
    UIImageView * imageView;
    UILabel * name_label;
    UILabel * sum_label;
    UILabel * left_label;
    
    UIView * progressView;
    UIButton * add_shoppingCartBut;
    UIButton * one_buyBut;
    
    
}
@end

@implementation JKCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    imageView = [[UIImageView alloc] init];
    
    name_label = [[UILabel alloc] init];
    sum_label = [[UILabel alloc] init];
    left_label = [[UILabel alloc] init];
    add_shoppingCartBut = [[UIButton alloc] init];
    add_shoppingCartBut.tag = 172700;
    
    one_buyBut = [[UIButton alloc] init];
    one_buyBut.tag =172701;
    
    progressView = [[UIView alloc] init];
    
    [self addSubview:imageView];
    [self addSubview:name_label];
    [self addSubview:sum_label];
    [self addSubview:left_label];
    [self addSubview:progressView];
    progressView.backgroundColor = [UIColor orangeColor];
    progressView.layer.cornerRadius = (5 * kFloatHeightScale)/2;
    [self addSubview:add_shoppingCartBut];
    [self addSubview:one_buyBut];
}


-(void)setName_str:(NSString *)name_str
{
    _name_str = name_str;
    name_label.frame = CGRectMake(70*kFloatWidthScale,18*kFloatHeightScale, 174 * kFloatWidthScale,31 * kFloatHeightScale);
    name_label.text = name_str;
    name_label.textColor = [UIColor grayColor];
    
}

-(void)setSum_str:(NSString *)sum_str
{
    _sum_str = sum_str;
    sum_label.frame = CGRectMake(name_label.frame.origin.x, 56 * kFloatWidthScale,55 * kFloatWidthScale,15 * kFloatHeightScale);
    sum_label.text = [NSString stringWithFormat:@"总需%@",sum_str];
}

-(void)setLeft_str:(NSString *)left_str
{
    _left_str = left_str;
    NSString * str_left = [NSString stringWithFormat:@"剩余%@",left_str];
    left_label.frame = CGRectMake(sum_label.frame.origin.x + sum_label.frame.size.width + 35 * kFloatWidthScale,56 * kFloatWidthScale, 55 * kFloatWidthScale,15 * kFloatHeightScale);
    NSRange range = [str_left rangeOfString:@"余"];
    
    NSRange rangeFinal = {range.location +1,(left_str.length - range.location+1)};
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:str_left];
    
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:rangeFinal];
    
    left_label.attributedText = attri;
    
    
    add_shoppingCartBut.frame = CGRectMake(name_label.frame.origin.x + name_label.frame.size.width,14 * kFloatWidthScale,72 * kFloatWidthScale,22 * kFloatWidthScale);
    add_shoppingCartBut.tintColor = [UIColor blueColor];
    [add_shoppingCartBut setTitle:@"加入购物车" forState:UIControlStateNormal];
    add_shoppingCartBut.layer.borderWidth = 1;
    add_shoppingCartBut.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
    add_shoppingCartBut.layer.masksToBounds = YES;
    
    add_shoppingCartBut.layer.cornerRadius = 5;
    
    one_buyBut.frame = CGRectMake(name_label.frame.origin.x + name_label.frame.size.width,40 * kFloatWidthScale,72 * kFloatWidthScale,22 * kFloatWidthScale);
    [one_buyBut setTitle:@"一元抢购" forState:UIControlStateNormal];
    one_buyBut.backgroundColor = [UIColor redColor];
    one_buyBut.layer.cornerRadius = 5;
    
    [self setprogressViewWidth];
  
}

-(void)setImage_str:(NSString *)image_str
{
    _image_str = image_str;
    imageView.frame = CGRectMake(12*kFloatWidthScale, 18*kFloatHeightScale, 56*kFloatWidthScale, 56*kFloatWidthScale);
    [imageView sd_setImageWithURL:[NSURL URLWithString:image_str] placeholderImage:[UIImage imageNamed:@""]];
}

-(void)setprogressViewWidth
{
    float sum = [_sum_str floatValue];
    float left = [_left_str floatValue];
    float width = (sum - left)/sum;
    
    
    if (left !=0)
    {
    progressView.frame = CGRectMake(name_label.frame.origin.x, name_label.frame.size.height + name_label.frame.origin.y, width*(name_label.bounds.size.width), 5 * kFloatHeightScale);
        progressView.alpha = 0.8;
     }
    else
    {
 
    }
}

-(void)setWeak_tableview:(UITableView *)weak_tableview
{
    _weak_tableview = weak_tableview;
    
}

/*!
 *  @author LQJ, 16-07-05 16:07:33
 *
 *  @brief 需要先查询然后判断是否已经存在，如果没存在就存储该字段及值
 *
 *  @param button 一共两个按钮需要设置Tag，switch分别处理172700是加入购物车 172701 是一元抢购
 */
-(void)buttonClicked:(UIButton *)button
{
    NSLog( @"%s",__FUNCTION__);
    UITableViewCell * cellTemp = (UITableViewCell*)[[imageView superview] superview];
    
    NSIndexPath *indexPath = [_weak_tableview indexPathForCell:cellTemp];
    
    NSDictionary * divb = @{@"cellRow":[NSNumber numberWithInteger:indexPath.row], @"buttontag":[NSString stringWithFormat:@"%ld",(long)button.tag]};
    NSNotification *notification =[NSNotification notificationWithName:@"JKCategoryCell" object:divb userInfo:nil];
    
   [[NSNotificationCenter defaultCenter] postNotification:notification];
   
    switch (button.tag) {
        case 172700:
        {
    

        }
            break;
        case 172701:
        {
        
        }
            break;
            
        default:
            break;
    }
    
    
}


@end
