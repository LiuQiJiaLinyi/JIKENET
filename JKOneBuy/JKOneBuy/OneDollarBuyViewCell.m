//
//  OneDollarBuyViewCell.m
//  BoBoBuy
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import "OneDollarBuyViewCell.h"
#import "UIButton+WebCache.h"
#import "GlobalObject.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "define.h"
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define ROATWIDTH [[UIScreen mainScreen] bounds].size.width/320

#define  MainSize self.frame.size.width/(float)106.6
@implementation OneDollarBuyViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreatLeftView];
        [self CreatRightView];
    }
    return self;
}
-(void)CreatLeftView
{
    self.leftBottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBottomBtn.frame=CGRectMake(8*kFloatSize, 5*kFloatSize, 147*kFloatSize, 210*kFloatSize);
    [self.leftBottomBtn.layer setBorderWidth:1*kFloatSize];
    [self.leftBottomBtn.layer setBorderColor:[GlobalObject colorWithHexString:@"#E5E6E7"].CGColor];
    [self.leftBottomBtn setBackgroundColor:[UIColor whiteColor]];
    //商品图片
    self.left_imgVC=[[UIImageView alloc]initWithFrame:CGRectMake(5*kFloatSize,5*kFloatSize, 137*kFloatSize, 137*kFloatSize)];
    
    [self.leftBottomBtn addSubview:self.left_imgVC];
    
    //期数背景图
    UIImageView *left_imgVC_qishu=[[UIImageView alloc]initWithFrame:CGRectMake(73*kFloatSize,0, 72*kFloatSize, 14*ROATWIDTH)];
    [left_imgVC_qishu setBackgroundColor:[UIColor clearColor]];
    [left_imgVC_qishu setImage:[UIImage imageNamed:@"one_qishu"]];
    [self.leftBottomBtn addSubview:left_imgVC_qishu];
    
    //商品期数
    self.left_lbl_qishu=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize,0, 60*kFloatSize, 14*kFloatSize)];
    [self.left_lbl_qishu setTextColor:[UIColor whiteColor]];
    [self.left_lbl_qishu setFont:[UIFont systemFontOfSize:9*kFloatSize]];
    
    [left_imgVC_qishu addSubview:self.left_lbl_qishu];
    //商品标题
    self.left_lbl_title=[[UILabel alloc]initWithFrame:CGRectMake(5*kFloatSize,150*kFloatSize, 135*kFloatSize, 12*kFloatSize)];
    [self.left_lbl_title setTextColor:[GlobalObject colorWithHexString:@"#6E6F70"]];
    [self.left_lbl_title setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    
    [self.leftBottomBtn addSubview:self.left_lbl_title];
    
    
    //进度
    self.left_progressView = [[UIProgressView alloc]init];
    self.left_progressView.frame = CGRectMake(5*kFloatSize,175*kFloatSize,self.left_imgVC.frame.size.width, 3*kFloatSize);
    self.left_progressView.progressViewStyle = UIProgressViewStyleBar;
    self.left_progressView.progress = 0;
    self.left_progressView.trackTintColor=[GlobalObject colorWithHexString:@"#EFEDEE"];
    self.left_progressView.progressTintColor=[GlobalObject colorWithHexString:@"#FEAB39"];
    [self.leftBottomBtn addSubview:self.left_progressView];
    self.left_progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);
    
    
    //已参与
    
    self.left_lbl_join=[[UILabel alloc]initWithFrame:CGRectMake(5*kFloatSize,185*kFloatSize, 65*kFloatSize, 10*kFloatSize)];
    [self.left_lbl_join setTextColor:[GlobalObject colorWithHexString:@"#A4A5A6"]];
    [self.left_lbl_join setFont:[UIFont systemFontOfSize:11*kFloatSize]];
    
    [self.leftBottomBtn addSubview:self.left_lbl_join];

    
    //剩余人次
    self.left_lbl_remain=[[UILabel alloc]initWithFrame:CGRectMake(80*kFloatSize, 185*kFloatSize, 62*kFloatSize, 10*kFloatSize)];
    [self.left_lbl_remain setFont:[UIFont systemFontOfSize:11*kFloatSize]];
    self.left_lbl_remain.textAlignment=NSTextAlignmentRight;
    
    [self.left_lbl_remain setTextColor:[GlobalObject colorWithHexString:@"#70A3FC"]];
    
    [self.leftBottomBtn addSubview:self.left_lbl_remain];
    
   
    
}

-(void)CreatRightView
{
    
    self.rightBottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBottomBtn.frame=CGRectMake(163*kFloatSize, 5*kFloatSize, 147*kFloatSize, 210*kFloatSize);
    [self.rightBottomBtn.layer setBorderWidth:1*kFloatSize];
    [self.rightBottomBtn.layer setBorderColor:[GlobalObject colorWithHexString:@"#E5E6E7"].CGColor];
    [self.rightBottomBtn setBackgroundColor:[UIColor whiteColor]];
    
    self.imgVC=[[UIImageView alloc]initWithFrame:CGRectMake(5*kFloatSize,5*kFloatSize, 137*kFloatSize, 137*kFloatSize)];
    
    [self.rightBottomBtn addSubview:self.imgVC];
    
    //期数背景
    UIImageView *right_imgVC_qishu=[[UIImageView alloc]initWithFrame:CGRectMake(73*kFloatSize,0, 72*kFloatSize, 14*ROATWIDTH)];
    [right_imgVC_qishu setBackgroundColor:[UIColor clearColor]];
    [right_imgVC_qishu setImage:[UIImage imageNamed:@"one_qishu"]];
    
    [self.rightBottomBtn addSubview:right_imgVC_qishu];
    
    //商品期数
    self.right_lbl_qishu=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize,0, 60*kFloatSize, 14*kFloatSize)];
    [self.right_lbl_qishu setTextColor:[UIColor whiteColor]];
    [self.right_lbl_qishu setFont:[UIFont systemFontOfSize:9*kFloatSize]];
    
    [right_imgVC_qishu addSubview:self.right_lbl_qishu];
    
    
    //商品标题
    self.right_lbl_title=[[UILabel alloc]initWithFrame:CGRectMake(5*kFloatSize,150*kFloatSize, 135*kFloatSize, 12*kFloatSize)];
    [self.right_lbl_title setTextColor:[GlobalObject colorWithHexString:@"#6E6F70"]];
    [self.right_lbl_title setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    
    [self.rightBottomBtn addSubview:self.right_lbl_title];
    
   

    //进度
    
    self.progressView = [[UIProgressView alloc]init];
    self.progressView.frame = CGRectMake(5*kFloatSize,175*kFloatSize,self.left_imgVC.frame.size.width, 3*kFloatSize);
    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    self.progressView.progress = 0;
    self.progressView.trackTintColor=[GlobalObject colorWithHexString:@"#EFEDEE"];
    self.progressView.progressTintColor=[GlobalObject colorWithHexString:@"#FEAB39"];
    [self.rightBottomBtn addSubview:self.progressView];
    self.progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);
    
    //已参与
    
    self.right_lbl_join=[[UILabel alloc]initWithFrame:CGRectMake(5*kFloatSize,185*kFloatSize, 65*kFloatSize, 10*kFloatSize)];
    [self.right_lbl_join setTextColor:[GlobalObject colorWithHexString:@"#A4A5A6"]];
    [self.right_lbl_join setFont:[UIFont systemFontOfSize:11*kFloatSize]];
    
    [self.rightBottomBtn addSubview:self.right_lbl_join];
    
    
    //剩余人次
    self.lbl_remain=[[UILabel alloc]initWithFrame:CGRectMake(80*kFloatSize, 185*kFloatSize, 62*kFloatSize, 10*kFloatSize)];
    [self.lbl_remain setFont:[UIFont systemFontOfSize:11*kFloatSize]];
    self.lbl_remain.textAlignment=NSTextAlignmentRight;
    
    [self.lbl_remain setTextColor:[GlobalObject colorWithHexString:@"#70A3FC"]];
    
    [self.rightBottomBtn addSubview:self.lbl_remain];

    
}
-(void)CreateViewArray:(NSArray*)array WihtTarget:(SEL)action WithSelf:(id)del WithTag:(NSInteger)btnTag
{
   
    if (array.count==1) {
        [self.rightBottomBtn removeFromSuperview];
    }
    for (int i=0; i<array.count; i++) {
        if (i==0) {
            
            self.left_lbl_qishu.text=[NSString stringWithFormat:@"%@期",[[array objectAtIndex:i] objectForKey:@"Termid"]];
            [self.left_imgVC sd_setImageWithURL:[NSURL URLWithString:[[array objectAtIndex:i] objectForKey:@"productImage"]]];
            self.left_lbl_title.text=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"ProductName"]];
           
            
            self.left_lbl_join.text=[NSString stringWithFormat:@"%@人已参与",[[array objectAtIndex:i] objectForKey:@"SalerCount"]];
            
            
             NSString *SalerCount=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"SalerCount"] ];
             NSString *ProCount=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"ProCount"] ];
             [self.left_progressView setProgress:SalerCount.floatValue/ProCount.floatValue animated:YES];
            
            NSString *str_surplus=@"剩余";
            NSString *remainStr=[NSString stringWithFormat:@"%@",[NSString  stringWithFormat:@"%d",ProCount.intValue-SalerCount.intValue]];
            
            //
            NSString *name_content=[NSString stringWithFormat:@"%@ %@",str_surplus,remainStr];
            
            NSMutableAttributedString *str_num = [[NSMutableAttributedString alloc] initWithString:name_content];
            
            [str_num addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#7D7D7D"] range:NSMakeRange(0,str_surplus.length)];
            
            self.left_lbl_remain.attributedText=str_num;
            
            //

            [self.leftBottomBtn addTarget:del action:action forControlEvents:UIControlEventTouchUpInside];
            self.leftBottomBtn.tag=btnTag*1000+i;
            [self addSubview:self.leftBottomBtn];

                    }
        if (i==1) {
            
            self.right_lbl_qishu.text=[NSString stringWithFormat:@"%@期",[[array objectAtIndex:i] objectForKey:@"Termid"]];
            
            [self.imgVC sd_setImageWithURL:[NSURL URLWithString:[[array objectAtIndex:i] objectForKey:@"productImage"]]];
            self.right_lbl_title.text=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"ProductName"]];
            
             self.right_lbl_join.text=[NSString stringWithFormat:@"%@人已参与",[[array objectAtIndex:i] objectForKey:@"SalerCount"]];
            
            NSString *SalerCount=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"SalerCount"] ];
            NSString *ProCount=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"ProCount"] ];
            [self.progressView setProgress:SalerCount.floatValue/ProCount.floatValue animated:YES];
            
            
            NSString *str_surplus=@"剩余";
            NSString *remainStr=[NSString stringWithFormat:@"%@",[NSString  stringWithFormat:@"%d",ProCount.intValue-SalerCount.intValue]];
            //
            NSString *name_content=[NSString stringWithFormat:@"%@ %@",str_surplus,remainStr];
            
            NSMutableAttributedString *str_num = [[NSMutableAttributedString alloc] initWithString:name_content];
            
            [str_num addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#7D7D7D"] range:NSMakeRange(0,str_surplus.length)];

            self.lbl_remain.attributedText=str_num;
            
            
            [self.rightBottomBtn addTarget:del action:action forControlEvents:UIControlEventTouchUpInside];
            self.rightBottomBtn.tag=btnTag*1000+i;
            [self addSubview:self.rightBottomBtn];
        }
        
        
    }
    
}

@end
