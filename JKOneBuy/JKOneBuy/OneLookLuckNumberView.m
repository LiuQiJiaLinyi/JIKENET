//
//  OneLookLuckNumberView.m
//  BoBoBuy
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "OneLookLuckNumberView.h"
#import "define.h"
#import "GlobalObject.h"

@implementation OneLookLuckNumberView
-(id)initWithFrame:(CGRect)frame andInfo:(NSArray *)infoAry andinfoDic:(NSDictionary *)yydic{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self creatView:frame andinfo:infoAry andyyDic:yydic];
        
    }
    return self;
}
-(void)creatView:(CGRect)frame andinfo:(NSArray *)infoAry andyyDic:(NSDictionary *)yydic{
    
    UIView *vc_appointment=[[UIView alloc]initWithFrame:frame];
    vc_appointment.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    vc_appointment.userInteractionEnabled=YES;
    [self addSubview:vc_appointment];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitshare)];
    [vc_appointment addGestureRecognizer:tap];
    
    
    
    
    //标题
    CGRect vc_look_frame=CGRectMake(10*kFloatSize,125*kFloatSize, 300*kFloatSize ,(210*kFloatSize+(infoAry.count+3-1)/3*25*kFloatSize)*kFloatSize);
    UIView *vc_look=[[UIView alloc]initWithFrame:vc_look_frame];
    vc_look.backgroundColor = [UIColor whiteColor];
    [vc_look.layer setMasksToBounds:YES];
    [vc_look.layer setCornerRadius:12.0*kFloatSize];
    [vc_look.layer setBorderWidth:1.0*kFloatSize];
      [vc_look.layer setBorderColor:[GlobalObject colorWithHexString:@"#DDDDDD"].CGColor];
    vc_look.userInteractionEnabled=YES;
    [vc_appointment addSubview:vc_look];
   
    UILabel *lbl_title=[[UILabel alloc]init];
    lbl_title.text=[NSString stringWithFormat:@"第%@期%@",[yydic objectForKey:@"Termid"],[yydic objectForKey:@"ProductName"]];
    lbl_title.backgroundColor=[UIColor clearColor];

    [lbl_title setTextColor:[GlobalObject colorWithHexString:@"#5D5D5D"]];
    [lbl_title setFont:[UIFont systemFontOfSize:17*kFloatSize]];
    lbl_title.numberOfLines = 0;
    CGSize titleSize = [lbl_title sizeThatFits:CGSizeMake(vc_look.frame.size.width-20*kFloatSize, MAXFLOAT)];
//    CGRect rect=[lbl_title.text boundingRectWithSize:CGSizeMake(vc_look.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lbl_title.font} context:nil];
    lbl_title.frame=CGRectMake(20*kFloatSize, 25*kFloatSize, 260*kFloatSize, titleSize.height);
    [vc_look addSubview:lbl_title];
    
    
    UIButton *btn_esc=[[UIButton alloc]initWithFrame:CGRectMake(vc_look.frame.size.width-40*kFloatSize, 0, 25*kFloatSize, 25*kFloatSize)];
    btn_esc.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn_esc setTitle:@"×" forState:UIControlStateNormal];
    [btn_esc setBackgroundColor:[UIColor clearColor]];
    [btn_esc setTitleColor:[UIColor colorWithRed:105/255.0 green:136/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
    [btn_esc addTarget:self action:@selector(exitshare) forControlEvents:UIControlEventTouchUpInside];
    [vc_look addSubview:btn_esc];
    
    UILabel *lbl_join=[[UILabel alloc]initWithFrame:CGRectMake(lbl_title.frame.origin.x, CGRectGetMaxY(lbl_title.frame)+5*kFloatSize, 32*kFloatSize, 30*kFloatSize)];
    lbl_join.text=@"参与";
    [lbl_join setFont:[UIFont systemFontOfSize:16]];
    lbl_join.textColor=[GlobalObject colorWithHexString:@"#767676"];

     [vc_look addSubview:lbl_join];
    
    NSString *remainStr=[NSString stringWithFormat:@"%@人次,夺宝号码:",[NSString  stringWithFormat:@"%ld",infoAry.count]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:remainStr];
    
    [str addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#D9456E"] range:NSMakeRange(0,[NSString  stringWithFormat:@"%ld",infoAry.count].length)];
    UILabel *lbl_join_number=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lbl_join.frame), CGRectGetMaxY(lbl_title.frame)+5*kFloatSize, 160*kFloatSize, 30*kFloatSize)];
    lbl_join_number.textColor=[GlobalObject colorWithHexString:@"#767676"];
    [vc_look addSubview:lbl_join];
    lbl_join_number.attributedText=str;
    [vc_look addSubview:lbl_join_number];
    
    
    UIScrollView *vc_look_btn = [[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(lbl_join_number.frame)+5*kFloatSize, 300*kFloatSize ,100*kFloatSize)];
    vc_look_btn.contentSize = CGSizeMake(0,(infoAry.count+2)/3*25*kFloatSize);
    vc_look_btn.backgroundColor = [UIColor whiteColor];
    
    vc_look_btn.pagingEnabled = YES;
    
    //    scrollV.delegate = self;
    [vc_look addSubview:vc_look_btn];
   
    
    CGRect jiuframe=CGRectMake(20*kFloatSize, 0, (vc_look.frame.size.width-20*2*kFloatSize)/3, 25*kFloatSize);
    NSDictionary *dic_number=[[NSDictionary alloc]init];
    for (int i=0; i<infoAry.count; i++) {
       dic_number=[infoAry objectAtIndex:i];
        UIButton* quanbtn;
        jiuframe.origin.x=(i%3)*(vc_look.frame.size.width-20*2*kFloatSize)/3+(i%3)*2*kFloatSize+20*kFloatSize;
        jiuframe.origin.y=25*(i/3)*kFloatSize;
        quanbtn=[self createBtn:dic_number WithFrame:jiuframe];
        [vc_look_btn addSubview:quanbtn];
    }
    
    CGFloat totalHeight = titleSize.height + 115*kFloatSize + vc_look_btn.frame.size.height ;
    vc_look.frame = CGRectMake(10*kFloatSize,125*kFloatSize, 300*kFloatSize ,totalHeight);

    UIView *HTlineView = [[UIView alloc]init];
    HTlineView.frame = CGRectMake(0, vc_look.frame.size.height-50*kFloatSize, vc_look.frame.size.width, 1);
    HTlineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    [vc_look addSubview:HTlineView];
    
    CGRect luck_btn_look_f=CGRectMake(vc_look.frame.size.width/2, CGRectGetMaxY(HTlineView.frame)+10*kFloatSize, 100*kFloatSize, 30*kFloatSize);
    UIButton *luck_btn_look=[[UIButton alloc]initWithFrame:CGRectMake(luck_btn_look_f.origin.x-luck_btn_look_f.size.width/2, luck_btn_look_f.origin.y, luck_btn_look_f.size.width, luck_btn_look_f.size.height)];
    [luck_btn_look setBackgroundColor:[GlobalObject colorWithHexString:@"#ED4C7B"]];
    [luck_btn_look setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [luck_btn_look.layer setMasksToBounds:YES];
    [luck_btn_look.layer setCornerRadius:10.0*kFloatSize];
    [luck_btn_look.layer setBorderWidth:1.0*kFloatSize];
    
    [luck_btn_look.layer setBorderColor:[GlobalObject colorWithHexString:@"#ED4C7B"].CGColor];
    [luck_btn_look setTitle:@"确定" forState:UIControlStateNormal];
    [luck_btn_look addTarget:self action:@selector(exitshare) forControlEvents:UIControlEventTouchUpInside];
    [vc_look addSubview:luck_btn_look];
    
    

    
}
-(UIButton *)createBtn:(NSDictionary *)dic WithFrame:(CGRect)frame
{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[GlobalObject colorWithHexString:@"#717171"] forState:UIControlStateNormal];
    [btn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"LuckyNum"]] forState:UIControlStateNormal];
    //        UIImageView* iView=[[UIImageView alloc]init];
    //        iView.frame=CGRectMake((frame.size.width-60)/2, (frame.size.height-80)/2, self.view.frame.size.width/3, 60);
    //        iView.backgroundColor=[UIColor grayColor];
    //        [btn addSubview:iView];
    //
    //        UILabel* titleLab=[[UILabel alloc]init];
    //        titleLab.frame=CGRectMake(0, frame.size.height-20, frame.size.width, 20);
    //        titleLab.text=titleName;
    //        titleLab.textColor=[UIColor grayColor];
    //        titleLab.font=[UIFont systemFontOfSize:16];
    //        titleLab.textAlignment=NSTextAlignmentCenter;
    //        [btn addSubview:titleLab];
    
    return btn;
}

-(void)exitshare{
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(quitLookview:)]) {
        [self.delegate quitLookview:self];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
