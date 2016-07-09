//
//  OneDetailsBottomView.m
//  JKOneBuy
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "OneDetailsBottomView.h"
#import "define.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "GlobalObject.h"

@implementation OneDetailsBottomView
-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self CreateView];
        
    }
    return self;
    
}

-(void)CreateView{
//    UIImageView *bac_image=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, 210*kFloatSize)];
//    
//    bac_image.userInteractionEnabled=YES;
//    [self addSubview:bac_image];

    // 商品详情
    UIButton *btn_details = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_details.tag=1001;
    [btn_details addTarget:self action:@selector(seleToWebVC:) forControlEvents:UIControlEventTouchUpInside];
   
    [btn_details setFrame:CGRectMake(0,0, self.frame.size.width, 55*kFloatSize)];
    
    [self addSubview:btn_details];
    
    UILabel *lbl_details=[[UILabel alloc]initWithFrame:CGRectMake(15*kFloatSize,20*kFloatSize, 60*kFloatSize, 15*kFloatSize)];
    lbl_details.text=@"商品详情";
    [lbl_details setFont:[UIFont systemFontOfSize:14*kFloatSize]];
    lbl_details.textColor=[GlobalObject colorWithHexString:@"#4D4D4D"];
    [btn_details addSubview:lbl_details];
    
    UIImageView *image_details=[[UIImageView alloc]initWithFrame:CGRectMake(290*kFloatSize, 20*kFloatSize, 10*kFloatSize, 15*kFloatSize)];
    [image_details setImage:[UIImage imageNamed:@"one_pingjia"]];
    
    [btn_details addSubview:image_details];
    
    CGRect lb_next_frameA=CGRectMake(10*kFloatSize, 54*kFloatSize,btn_details.frame.size.width-20*kFloatSize, 1*kFloatSize);
    UILabel *lb_nextA=[[UILabel alloc]initWithFrame:lb_next_frameA];
    
    [lb_nextA setBackgroundColor:[GlobalObject colorWithHexString:@"#E5E5E5"]];
    [btn_details addSubview:lb_nextA];
    
    //往期揭晓
    
    UIButton *btn_previous = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_previous.tag=1002;
    [btn_previous addTarget:self action:@selector(seleToWebVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_previous setFrame:CGRectMake(0, CGRectGetMaxY(btn_details.frame), self.frame.size.width-20*kFloatSize, 55*kFloatSize)];
    
    
    [self addSubview:btn_previous];
    
    UILabel *lbl_previous=[[UILabel alloc]initWithFrame:CGRectMake(15*kFloatSize,20*kFloatSize, 60*kFloatSize, 15*kFloatSize)];
    lbl_previous.text=@"往期揭晓";
    [lbl_previous setFont:[UIFont systemFontOfSize:14*kFloatSize]];
    lbl_previous.textColor=[GlobalObject colorWithHexString:@"#4D4D4D"];
    [btn_previous addSubview:lbl_previous];
    
    UIImageView *image_previous=[[UIImageView alloc]initWithFrame:CGRectMake(290*kFloatSize, 20*kFloatSize, 10*kFloatSize, 15*kFloatSize)];
    [image_previous setImage:[UIImage imageNamed:@"one_pingjia"]];
    
    [btn_previous addSubview:image_previous];
    
    CGRect lb_next_frameB=CGRectMake(10*kFloatSize, 54*kFloatSize,btn_previous.frame.size.width-20*kFloatSize, 1*kFloatSize);
    UILabel *lb_nextB=[[UILabel alloc]initWithFrame:lb_next_frameB];
    
    [lb_nextB setBackgroundColor:[GlobalObject colorWithHexString:@"#E5E5E5"]];
    [btn_previous addSubview:lb_nextB];
    //商品评价
    
    UIButton *btn_estimate = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_estimate.tag=1003;
    [btn_estimate addTarget:self action:@selector(seleToWebVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_estimate setFrame:CGRectMake(0, CGRectGetMaxY(btn_previous.frame), self.frame.size.width, 55*kFloatSize)];
    
    [self addSubview:btn_estimate];
    
    UILabel *lbl_estimate=[[UILabel alloc]initWithFrame:CGRectMake(15*kFloatSize,20*kFloatSize, 60*kFloatSize, 15*kFloatSize)];
    lbl_estimate.text=@"商品评价";
    [lbl_estimate setFont:[UIFont systemFontOfSize:14*kFloatSize]];
    lbl_estimate.textColor=[GlobalObject colorWithHexString:@"#4D4D4D"];
    [btn_estimate addSubview:lbl_estimate];

    
    

    
    UIImageView *image_estimate=[[UIImageView alloc]initWithFrame:CGRectMake(290*kFloatSize, 20*kFloatSize, 10*kFloatSize, 15*kFloatSize)];
    [image_estimate setImage:[UIImage imageNamed:@"one_pingjia"]];
    
    [btn_estimate addSubview:image_estimate];
    
    
    CGRect lb_next_frameC=CGRectMake(10*kFloatSize,54*kFloatSize,self.frame.size.width-20*kFloatSize, 1*kFloatSize);
    UILabel *lb_nextC=[[UILabel alloc]initWithFrame:lb_next_frameC];
    
    [lb_nextC setBackgroundColor:[GlobalObject colorWithHexString:@"#E5E5E5"]];
    [btn_estimate addSubview:lb_nextC];
    
    
    //一元抢购活动协议
    UIButton *btn_protocol = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_protocol.tag=1004;
    [btn_protocol addTarget:self action:@selector(seleToWebVC:) forControlEvents:UIControlEventTouchUpInside];
        [btn_protocol setFrame:CGRectMake(0, CGRectGetMaxY(btn_estimate.frame), self.frame.size.width, 55*kFloatSize)];
    [self addSubview:btn_protocol];
    
    UILabel *lbl_protoco=[[UILabel alloc]initWithFrame:CGRectMake(15*kFloatSize,20*kFloatSize, 112*kFloatSize, 15*kFloatSize)];
    lbl_protoco.text=@"一元抢购活动协议";
    [lbl_protoco setFont:[UIFont systemFontOfSize:14*kFloatSize]];
    lbl_protoco.textColor=[GlobalObject colorWithHexString:@"#4D4D4D"];
    [btn_protocol addSubview:lbl_protoco];
    
    UIImageView *image_protocol=[[UIImageView alloc]initWithFrame:CGRectMake(290*kFloatSize, 20*kFloatSize, 10*kFloatSize, 15*kFloatSize)];
    [image_protocol setImage:[UIImage imageNamed:@"one_pingjia"]];
    
    [btn_protocol addSubview:image_protocol];
    
    
    CGRect lb_next_frameD=CGRectMake(10*kFloatSize,54*kFloatSize,self.frame.size.width-20*kFloatSize, 1*kFloatSize);
    UILabel *lb_nextD=[[UILabel alloc]initWithFrame:lb_next_frameD];
    
    [lb_nextD setBackgroundColor:[GlobalObject colorWithHexString:@"#E5E5E5"]];
    [btn_protocol addSubview:lb_nextD];
    
   
    
}
-(void)seleToWebVC:(UIButton *)btn{
    NSString *str_tag=[NSString stringWithFormat:@"%ld",btn.tag];
    if (self.bottomWebBlock !=nil) {
        self.bottomWebBlock(str_tag);
    }
}


@end
