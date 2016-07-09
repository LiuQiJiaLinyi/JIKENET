//
//  shopCarCell.m
//  BoBoBuy
//
//  Created by Jiker on 15/12/30.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import "shopCarCell.h"
#import "UIImageView+WebCache.h"
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
@implementation shopCarCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreateView];
    }
    return self;
}
-(void)CreateView
{
    self.selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame=CGRectMake(10, (125-25)/2, 25, 25);
    [self.selectBtn setImage:[UIImage imageNamed:@"shopcar_noselect.png"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"shopcar_select.png"] forState:UIControlStateSelected];
    [self addSubview:self.selectBtn];
    
    self.headerView=[[UIImageView alloc]init];
    self.headerView.frame=CGRectMake(self.selectBtn.frame.origin.x+self.selectBtn.frame.size.width+10, 20, 60, 60);
    self.headerView.backgroundColor=[UIColor purpleColor];
    [self addSubview:self.headerView];
    
    self.titleLab=[[UILabel alloc]init];
    self.titleLab.frame=CGRectMake(self.headerView.frame.origin.x+self.headerView.frame.size.width+10, self.headerView.frame.origin.y+3, SCREENWIDTH-(self.headerView.frame.origin.x+self.headerView.frame.size.width+10)-10, 36);
    self.titleLab.font=[UIFont systemFontOfSize:13];
    self.titleLab.numberOfLines=0;
    self.titleLab.textColor=[UIColor grayColor];
    [self addSubview:self.titleLab];
    
    self.allPerNumLab=[[UILabel alloc]init];
    self.allPerNumLab.frame=CGRectMake(self.titleLab.frame.origin.x, self.headerView.frame.origin.y+self.headerView.frame.size.height-12, self.titleLab.frame.size.width,15);
    self.allPerNumLab.font=[UIFont systemFontOfSize:12];
    self.allPerNumLab.textColor=[UIColor colorWithWhite:166.0/255.0 alpha:1.0];
    [self addSubview:self.allPerNumLab];
    
    self.perTitleLab=[[UILabel alloc]init];
    self.perTitleLab.frame=CGRectMake(self.titleLab.frame.origin.x, self.headerView.frame.origin.y+self.headerView.frame.size.height+10, 48, 30);
    self.perTitleLab.font=[UIFont systemFontOfSize:12];
    self.perTitleLab.textColor=[UIColor colorWithWhite:166.0/255.0 alpha:1.0];
    self.perTitleLab.text=@"参与人次";
    [self addSubview:self.perTitleLab];
    
    self.reduceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceBtn.frame=CGRectMake(self.perTitleLab.frame.origin.x+self.perTitleLab.frame.size.width+2, self.perTitleLab.frame.origin.y, 28, self.perTitleLab.frame.size.height);
    [self.reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.reduceBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    self.reduceBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.reduceBtn.layer.borderWidth=0.6;
    self.reduceBtn.backgroundColor=[UIColor whiteColor];
    
    self.numTF=[[UITextField alloc]init];
    self.numTF.frame=CGRectMake(self.reduceBtn.frame.origin.x+self.reduceBtn.frame.size.width-1, self.reduceBtn.frame.origin.y, 44, self.reduceBtn.frame.size.height);
    self.numTF.textAlignment=NSTextAlignmentCenter;
    self.numTF.font=[UIFont systemFontOfSize:12];
    self.numTF.textColor=[UIColor blackColor];
    self.numTF.keyboardType=UIKeyboardTypeNumberPad;
    //self.numLab.text=@"5";
    self.numTF.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.numTF.layer.borderWidth=0.6;
    [self addSubview:self.numTF];
    //后加这个button
    [self addSubview:self.reduceBtn];
    
    self.addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame=CGRectMake(self.numTF.frame.origin.x+self.numTF.frame.size.width-1, self.perTitleLab.frame.origin.y, 28, self.perTitleLab.frame.size.height);
    [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    self.addBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.addBtn.layer.borderWidth=0.6;
    self.addBtn.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.addBtn];
    
    self.deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame=CGRectMake(self.addBtn.frame.origin.x+self.addBtn.frame.size.width+10, self.addBtn.frame.origin.y-8, 20, 20);
    [self.deleteBtn setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
    
}
-(void)setDataWithModel:(OneYiyuanModel*)model WithIsEdit:(BOOL)isEdit
{
    if (isEdit) {
        [self addSubview:self.deleteBtn];
    }else
    {
        [self.deleteBtn removeFromSuperview];
    }
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.productImage] completed:nil];
    self.titleLab.text=model.ProductName;
    self.allPerNumLab.text=[NSString stringWithFormat:@"总需：%@人次，剩余%@人次",model.ProCount,model.remainCount];
    self.numTF.text=[NSString stringWithFormat:@"%@",model.goodCount];
    if (model.isSelect) {
        self.selectBtn.selected=YES;
    }else
    {
        self.selectBtn.selected=NO;
    }
    
}
@end
