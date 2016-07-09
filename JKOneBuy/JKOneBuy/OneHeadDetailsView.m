//
//  OneHeadDetailsView.m
//  JKOneBuy
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "OneHeadDetailsView.h"
#import "define.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "GlobalObject.h"
@implementation OneHeadDetailsView
-(id)initWithFrame:(CGRect)frame withType:(NSString *)type withTitleHight:(CGFloat)hight{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self CreateView:hight withtype:type];
        
    }
    return self;
    
}
-(void)CreateView:(CGFloat)higth withtype:(NSString *)type{
    _product_image=[[UIImageView alloc]initWithFrame:CGRectMake(12*kFloatSize,10*kFloatSize, 295*kFloatSize,275*kFloatSize)];
    [self addSubview:_product_image];
    
    UIImageView *image_Termid=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75*kFloatSize, 20*kFloatSize)];
    [image_Termid setImage:[UIImage imageNamed:@"details_Termid"]];
    [_product_image addSubview:image_Termid];
    
    _product_termid=[[UILabel alloc]initWithFrame:CGRectMake(0,  0, 75*kFloatSize, 20*kFloatSize)];
    
    [_product_termid setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _product_termid.textAlignment=NSTextAlignmentCenter;
    _product_termid.textColor=[UIColor whiteColor];
    [image_Termid addSubview:_product_termid];

    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize, 10*kFloatSize+275*kFloatSize+8*kFloatSize, 295*kFloatSize, 1*kFloatSize)];
    line.backgroundColor=[GlobalObject colorWithHexString:@"#F0F0F0"];
    [self addSubview:line];
    
    _product_name=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize,  10*kFloatSize+275*kFloatSize+9*kFloatSize+5*kFloatSize, 295*kFloatSize, higth)];
    _product_name.numberOfLines=0;
    [_product_name setFont:[UIFont systemFontOfSize:14*kFloatSize]];
    _product_name.textColor=[GlobalObject colorWithHexString:@"#1F1F1F"];
    [self addSubview:_product_name];
    
    _product_price=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize, 295*kFloatSize+5*kFloatSize+higth+15*kFloatSize, 150*kFloatSize, 15*kFloatSize)];
    [_product_price setFont:[UIFont systemFontOfSize:13*kFloatSize]];
    [_product_price setTextColor:[GlobalObject colorWithHexString:@"#ED482F"]];
    _product_price.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_product_price];
    
    //状态，1、普通状态; 2、揭晓已完成;3、倒计时中
    NSString *str_State=[NSString stringWithFormat:@"%@",type];
    
    if ([str_State isEqualToString:@"1"]) {
        
        [self creatOrdinaryView:CGRectGetMaxY(_product_price.frame)];
    }else if ([str_State isEqualToString:@"3"]){
        [self creatCountdownView:CGRectGetMaxY(_product_price.frame)];
    }else if ([str_State isEqualToString:@"2"]){
        [self creatPublishedView:CGRectGetMaxY(_product_price.frame)];
    }

    
    
    
}
//普通状态
-(void)creatOrdinaryView:(CGFloat)higth{
    
    _product_allNeed=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize, higth+15*kFloatSize, 200*kFloatSize, 12*kFloatSize)];
    _product_allNeed.textColor=[GlobalObject colorWithHexString:@"#CACACA"];
    [_product_allNeed setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _product_allNeed.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_product_allNeed];
    
    
    self.progressView = [[UIProgressView alloc]init];
    self.progressView.frame = CGRectMake(12*kFloatSize, CGRectGetMaxY(_product_allNeed.frame)+5*kFloatSize,295*kFloatSize, 6*kFloatSize);
    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    self.progressView.progress = 0;
    self.progressView.trackTintColor=[GlobalObject colorWithHexString:@"#EFEDEE"];
    self.progressView.progressTintColor=[GlobalObject colorWithHexString:@"#FEAB39"];
    [self addSubview:self.progressView];
    self.progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);
    
    _product_join=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize, CGRectGetMaxY(self.progressView.frame)+5*kFloatSize, 148*kFloatSize, 12*kFloatSize)];
    _product_join.textColor=[GlobalObject colorWithHexString:@"#CACACA"];
    [_product_join setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _product_join.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_product_join];
    
    //剩余人次
    _product_remaining=[[UILabel alloc]initWithFrame:CGRectMake(160*kFloatSize,CGRectGetMaxY(self.progressView.frame)+5*kFloatSize, 148*kFloatSize, 12*kFloatSize)];
    [_product_remaining setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _product_remaining.textAlignment=NSTextAlignmentRight;
    
    [_product_remaining setTextColor:[GlobalObject colorWithHexString:@"#ED5573"]];
    
    [self addSubview:_product_remaining];
    
}
//倒计时状态下
-(void)creatCountdownView:(CGFloat)higth{
    _product_allNeed=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize, higth+12*kFloatSize, 200*kFloatSize, 12*kFloatSize)];
    _product_allNeed.textColor=[GlobalObject colorWithHexString:@"#4D4D4D"];
    [_product_allNeed setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _product_allNeed.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_product_allNeed];
    //295 50
    UIImageView *back_countdown=[[UIImageView alloc]initWithFrame:CGRectMake(12*kFloatSize,CGRectGetMaxY(_product_allNeed.frame)+12*kFloatSize, 295*kFloatSize, 50*kFloatSize)];
    [back_countdown setBackgroundColor:[GlobalObject colorWithHexString:@"#ED4C79"]];
    back_countdown.userInteractionEnabled=YES;
    [self addSubview:back_countdown];
    
    UILabel *lbl_luck_number=[[UILabel alloc]initWithFrame:CGRectMake(17*kFloatSize, 17*kFloatSize,57*kFloatSize, 12*kFloatSize)];
    [lbl_luck_number setFont:[UIFont systemFontOfSize:11*kFloatSize]];
    
    [lbl_luck_number setTextColor:[UIColor whiteColor]];
    lbl_luck_number.text=@"揭晓倒计时:";
    
    [back_countdown addSubview:lbl_luck_number];
    
    self.lbl_countdown_number=[[UILabel alloc]initWithFrame:CGRectMake(80*kFloatSize, 15*kFloatSize,68*kFloatSize, 18*kFloatSize)];
    [self.lbl_countdown_number setFont:[UIFont systemFontOfSize:13*kFloatSize]];
    
    [self.lbl_countdown_number setTextColor:[UIColor whiteColor]];
    
    [back_countdown addSubview:self.lbl_countdown_number];
    
    UIButton *luck_btn_look=[[UIButton alloc]initWithFrame:CGRectMake(157*kFloatSize, 15*kFloatSize, 76*kFloatSize, 18*kFloatSize)];
    [luck_btn_look setBackgroundColor:[UIColor whiteColor]];
    [luck_btn_look setTitleColor:[GlobalObject colorWithHexString:@"#ED4C7B"] forState:UIControlStateNormal];
    [luck_btn_look.layer setMasksToBounds:YES];
    [luck_btn_look.layer setCornerRadius:8.0*kFloatSize];
    [luck_btn_look.layer setBorderWidth:1.0*kFloatSize];
    
    [luck_btn_look.layer setBorderColor:[GlobalObject colorWithHexString:@"#ED4C7B"].CGColor];
    luck_btn_look.titleLabel.font=[UIFont systemFontOfSize:10*kFloatSize];
    [luck_btn_look setTitle:@"查看计算详情" forState:UIControlStateNormal];
    [luck_btn_look addTarget:self action:@selector(lookjsDetailes) forControlEvents:UIControlEventTouchUpInside];
    [back_countdown addSubview:luck_btn_look];

    
}
//揭晓
-(void)creatPublishedView:(CGFloat)higth{
    _product_allNeed=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize, higth+12*kFloatSize, 200*kFloatSize, 12*kFloatSize)];
    _product_allNeed.textColor=[GlobalObject colorWithHexString:@"#4D4D4D"];
    [_product_allNeed setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _product_allNeed.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_product_allNeed];
    //295 50
    UIImageView *back_countdown=[[UIImageView alloc]initWithFrame:CGRectMake(12*kFloatSize,CGRectGetMaxY(_product_allNeed.frame)+15*kFloatSize, 295*kFloatSize, 128*kFloatSize)];
    [back_countdown setBackgroundColor:[UIColor whiteColor]];
    [back_countdown.layer setBorderWidth:1];
    [back_countdown.layer setBorderColor:[GlobalObject colorWithHexString:@"#E5E5E5"].CGColor];
    back_countdown.userInteractionEnabled=YES;
    [self addSubview:back_countdown];
    
    //头像
    self.person_image=[[UIImageView alloc]initWithFrame:CGRectMake(10*kFloatSize,12*kFloatSize, 40*kFloatSize,40*kFloatSize)];
    
    [back_countdown addSubview:self.person_image];
    
    UIImageView *winner_image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35*kFloatSize, 35*kFloatSize)];
    [winner_image setImage:[UIImage imageNamed:@"details_winner"]];
    [winner_image setBackgroundColor:[UIColor clearColor]];
    [back_countdown addSubview:winner_image];

    
    //获奖者
    _person_name=[[UILabel alloc]initWithFrame:CGRectMake(60*kFloatSize,12*kFloatSize, 212*kFloatSize, 12*kFloatSize)];
    [_person_name setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _person_name.textAlignment=NSTextAlignmentLeft;
    
    [_person_name setTextColor:[GlobalObject colorWithHexString:@"#67A2F8"]];
    
    [back_countdown addSubview:_person_name];
    
    //用户ID
    _person_ID=[[UILabel alloc]initWithFrame:CGRectMake(60*kFloatSize,CGRectGetMidY(_person_name.frame)+10*kFloatSize, 212*kFloatSize, 12*kFloatSize)];
    [_person_ID setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _person_ID.textAlignment=NSTextAlignmentLeft;
    
    [_person_ID setTextColor:[GlobalObject colorWithHexString:@"#BABABA"]];
    
    [back_countdown addSubview:_person_ID];
    
    //本期参与
    _person_join=[[UILabel alloc]initWithFrame:CGRectMake(60*kFloatSize,CGRectGetMidY(_person_ID.frame)+7*kFloatSize, 100*kFloatSize, 12*kFloatSize)];
    [_person_join setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _person_join.textAlignment=NSTextAlignmentLeft;
    
    [_person_join setTextColor:[GlobalObject colorWithHexString:@"#BABABA"]];
    
    [back_countdown addSubview:_person_join];
    
    UIButton *_btn_look_num = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_look_num setFrame:CGRectMake(CGRectGetMaxX(_person_join.frame),CGRectGetMidY(_person_ID.frame)+7*kFloatSize, 100*kFloatSize, 12*kFloatSize)];
    [_btn_look_num setTitleColor:[GlobalObject colorWithHexString:@"#3D8CF3"] forState:UIControlStateNormal];
    [_btn_look_num setTitle:@"查看Ta的号码" forState:UIControlStateNormal];
    _btn_look_num.titleLabel.font=[UIFont systemFontOfSize:12*kFloatSize];
    [_btn_look_num addTarget:self action:@selector(lookMyNumber) forControlEvents:UIControlEventTouchUpInside];
   
    [back_countdown addSubview:_btn_look_num];
    
    //揭晓时间
    _person_time=[[UILabel alloc]initWithFrame:CGRectMake(60*kFloatSize,CGRectGetMidY(_person_join.frame)+7*kFloatSize, 212*kFloatSize, 12*kFloatSize)];
    [_person_time setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    _person_time.textAlignment=NSTextAlignmentLeft;
    
    [_person_time setTextColor:[GlobalObject colorWithHexString:@"#BABABA"]];
    
    [back_countdown addSubview:_person_time];
    
    //红色背景75 160
    UIImageView *back_red=[[UIImageView alloc]initWithFrame:CGRectMake(0,92*kFloatSize, back_countdown.frame.size.width, 35*kFloatSize)];
    [back_red setBackgroundColor:[GlobalObject colorWithHexString:@"#ED4C7B"]];
    back_red.userInteractionEnabled=YES;
    [back_countdown addSubview:back_red];
    
    UILabel *lbl_luck_number=[[UILabel alloc]initWithFrame:CGRectMake(18*kFloatSize, 12*kFloatSize, 56*kFloatSize, 12*kFloatSize)];
    lbl_luck_number.textColor=[UIColor whiteColor];
    lbl_luck_number.text=@"幸运号码:";
    lbl_luck_number.font=[UIFont systemFontOfSize:12*kFloatSize];
    [back_red addSubview:lbl_luck_number];
    
    //幸运号码
    _luck_number=[[UILabel alloc]initWithFrame:CGRectMake(75*kFloatSize,10*kFloatSize, 80*kFloatSize, 15*kFloatSize)];
    [_luck_number setFont:[UIFont systemFontOfSize:14*kFloatSize]];
    
    
    [_luck_number setTextColor:[UIColor whiteColor]];
    
    [back_red addSubview:_luck_number];
    
    UIButton *luck_btn_look=[[UIButton alloc]initWithFrame:CGRectMake(160*kFloatSize, 9*kFloatSize, 76*kFloatSize, 20*kFloatSize)];
    [luck_btn_look setBackgroundColor:[UIColor whiteColor]];
    [luck_btn_look setTitleColor:[GlobalObject colorWithHexString:@"#ED4C7B"] forState:UIControlStateNormal];
    [luck_btn_look.layer setMasksToBounds:YES];
    [luck_btn_look.layer setCornerRadius:10.0*kFloatSize];
    [luck_btn_look.layer setBorderWidth:1.0*kFloatSize];
    
    [luck_btn_look.layer setBorderColor:[GlobalObject colorWithHexString:@"#ED4C7B"].CGColor];
    luck_btn_look.titleLabel.font=[UIFont systemFontOfSize:10*kFloatSize];
    [luck_btn_look setTitle:@"查看计算详情" forState:UIControlStateNormal];
    [luck_btn_look addTarget:self action:@selector(lookjsDetailes) forControlEvents:UIControlEventTouchUpInside];
    [back_red addSubview:luck_btn_look];


    
}
-(void)setOneDollarModel:(OneYiyuanModel *)model withAllmodel:(OneAllModel *)allmodel withLuckUserMosel:(OneLuckuserModel *)luckModel{
    
    NSString *str_image=[NSString stringWithFormat:@"%@",allmodel.productimgurl];
    [_product_image sd_setImageWithURL:[NSURL URLWithString:str_image] placeholderImage:[UIImage imageNamed:@""]];
    _product_termid.text=[NSString stringWithFormat:@"%@期",model.Termid];
    
    NSString *str_ProductName=[NSString stringWithFormat:@"%@",allmodel.productname];
    _product_name.text=str_ProductName;
    
    NSString *str_pice=@"价格:";
    NSString *_pice_str=[NSString stringWithFormat:@"¥%@.00",model.ProductPrice];
    
    NSString *name_content=[NSString stringWithFormat:@"%@ %@",str_pice,_pice_str];
    
    NSMutableAttributedString *str_num = [[NSMutableAttributedString alloc] initWithString:name_content];
    
    [str_num addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#1F1F1F"] range:NSMakeRange(0,str_pice.length)];
    
    self.product_price.attributedText=str_num;
    
    //状态，1、普通状态; 2、揭晓已完成;3、倒计时中
    NSString *str_State=[NSString stringWithFormat:@"%@",model.State];
    
    if ([str_State isEqualToString:@"1"]) {
        _product_allNeed.text=[NSString stringWithFormat:@"总需：%@人次",model.ProCount];
        [self.progressView setProgress:model.SalerCount.floatValue/model.ProCount.floatValue animated:YES];
        _product_join.text=[NSString stringWithFormat:@"%@人已参与",model.SalerCount];
        NSString *str_remaining=@"剩余";
        NSString *remaining_str=[NSString stringWithFormat:@"%d",model.ProCount.intValue-model.SalerCount.intValue];
        
        NSString *name_content=[NSString stringWithFormat:@"%@ %@",str_remaining,remaining_str];
        
        NSMutableAttributedString *str_num = [[NSMutableAttributedString alloc] initWithString:name_content];
        
        [str_num addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#7D7D7D"] range:NSMakeRange(0,str_remaining.length)];
        
        _product_remaining.attributedText=str_num;

       
    }else if ([str_State isEqualToString:@"3"]){
        NSString* Starttime = [NSString stringWithFormat:@"%@",model.Starttime];
        
         _product_allNeed.text=[NSString stringWithFormat:@"总需：%@人次",model.ProCount];
        NSString* Endtime = [NSString stringWithFormat:@"%@",model.Endtime];
        NSString* ServerTime = [NSString stringWithFormat:@"%@",model.ServerTime];
        NSString *str_Times=[NSString stringWithFormat:@"%@",model.Times];
        NSInteger Int_Times=[str_Times integerValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *datatime_Endtime=[formatter dateFromString:Endtime];
        double int_time_Endtime=[datatime_Endtime timeIntervalSince1970];
        
        NSDate *datatime_Server=[formatter dateFromString:ServerTime];
        double int_time_Server=[datatime_Server timeIntervalSince1970];
        //NSLog(@"%.f",([time doubleValue] - [savedTime doubleValue]) * 1000);
        NSLog(@"%.3lf",(int_time_Endtime+Int_Times-int_time_Server));
        time_number=(int_time_Endtime+Int_Times-int_time_Server);
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
    }else if ([str_State isEqualToString:@"2"]){
         _product_allNeed.text=[NSString stringWithFormat:@"总需：%@人次",model.ProCount];
        
        NSString *str_luck_image=[NSString stringWithFormat:@"%@",luckModel.headimgurl];
        [_person_image sd_setImageWithURL:[NSURL URLWithString:str_luck_image] placeholderImage:[UIImage imageNamed:@"details_default"]];
        
        NSString *person_name=@"获奖者:";
        NSString *name_content=[NSString stringWithFormat:@"%@ %@",person_name,luckModel.name];
        
        NSMutableAttributedString *str_num = [[NSMutableAttributedString alloc] initWithString:name_content];
        
        [str_num addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#BABABA"] range:NSMakeRange(0,person_name.length)];
        
        _person_name.attributedText=str_num;
        
        
        _person_ID.text=[NSString stringWithFormat:@"用户ID: %@(唯一不变标识)",luckModel.weid];
        _person_join.text=[NSString stringWithFormat:@"本期参与: %lu人次",allmodel.luckblist.count];
        
        _person_time.text=[NSString stringWithFormat:@"揭晓时间: %@",model.Endtime];
        
        _luck_number.text=[NSString stringWithFormat:@"%@",model.LuckyNum];
        
           }

    
}
- (void)timerFireMethod:(NSTimer *)timer
{
    time_number-=1/60.0;
    
    if(time_number > 0) {
        //计时尚未结束，do_something
        //        [_longtime setText:[NSString stringWithFormat:@"%@:%@:%@",d,fen,miao]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.lbl_countdown_number.text = [NSString stringWithFormat:@"00:%.3lf",time_number];
        }];
    } else if(time_number == 0) {
        //计时结束 do_something
        
        
        
    } else{
        //计时器失效
        [timer invalidate];
        
        if (self.headTimeShowEnd) {
            self.headTimeShowEnd();
        }
        
    }
    
    
}
-(void)lookMyNumber{
    if (self.headLookTaNumberBlock) {
        self.headLookTaNumberBlock();
    }
}
//查看计算详情
-(void)lookjsDetailes{
    if (self.lookJsDetailsBlock) {
        self.lookJsDetailsBlock();
    }
}
-(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
@end
