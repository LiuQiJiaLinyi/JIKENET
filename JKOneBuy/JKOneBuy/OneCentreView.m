//
//  OneCentreView.m
//  JKOneBuy
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "OneCentreView.h"
#import "define.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "GlobalObject.h"

@implementation OneCentreView

-(id)initWithFrame:(CGRect)frame withType:(NSString *)type{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self CreateViewType:type];
 
        
    }
    return self;
    
}
-(void)CreateViewType:(NSString *)type{
    int bac_hight_int;
    if ([type isEqualToString:@"1"]) {
        bac_hight_int=40*kFloatSize;
    }else{
        bac_hight_int=35*kFloatSize;
    }
    
    UIImageView *back_countdown=[[UIImageView alloc]initWithFrame:CGRectMake(5*kFloatSize,5*kFloatSize, self.frame.size.width-10*kFloatSize, bac_hight_int)];
    [back_countdown setBackgroundColor:[UIColor whiteColor]];
    back_countdown.userInteractionEnabled=YES;
    [self addSubview:back_countdown];
    
    _person_name=[[UILabel alloc]initWithFrame:CGRectMake(57*kFloatSize, 11*kFloatSize, 195*kFloatSize, 15*kFloatSize)];
    _person_name.textColor=[GlobalObject colorWithHexString:@"#4A4B4C"];
    _person_name.textAlignment=NSTextAlignmentCenter;
    [_person_name setFont:[UIFont systemFontOfSize:14*kFloatSize]];
    [back_countdown addSubview:_person_name];
    //253
    
    _btn_look_num = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_look_num setFrame:CGRectMake(246*kFloatSize,3*kFloatSize, 60*kFloatSize, 30*kFloatSize)];
    [_btn_look_num setTitleColor:[GlobalObject colorWithHexString:@"#F62F7A"] forState:UIControlStateNormal];
    [_btn_look_num setTitle:@"查看我的号码" forState:UIControlStateNormal];
    _btn_look_num.titleLabel.font=[UIFont systemFontOfSize:10*kFloatSize];
    [_btn_look_num addTarget:self action:@selector(lookMyNumber) forControlEvents:UIControlEventTouchUpInside];
    _btn_look_num.hidden=YES;
    [back_countdown addSubview:_btn_look_num];
    
    if (![type isEqualToString:@"1"]) {
        [self creatNewNumberview];
    }
}
-(void)creatNewNumberview{
    UIImageView *back_countdown=[[UIImageView alloc]initWithFrame:CGRectMake(0,50*kFloatSize, self.frame.size.width, 25*kFloatSize)];
    [back_countdown setBackgroundColor:[GlobalObject colorWithHexString:@"#B3B3B4"]];
    back_countdown.userInteractionEnabled=YES;
    [self addSubview:back_countdown];
    
    _lbl_new_number=[[UILabel alloc]initWithFrame:CGRectMake(10*kFloatSize, 7*kFloatSize, 175*kFloatSize, 10*kFloatSize)];
    _lbl_new_number.textColor=[UIColor whiteColor];
    _lbl_new_number.textAlignment=NSTextAlignmentLeft;
    [_lbl_new_number setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    [back_countdown addSubview:_lbl_new_number];
    
    
    UIButton *newbtn_foot = [[UIButton alloc]init];
    [newbtn_foot setFrame:CGRectMake(253*kFloatSize,5*kFloatSize, 51*kFloatSize, 17*kFloatSize)];
    [newbtn_foot setBackgroundColor:[GlobalObject colorWithHexString:@"#ED4C77"]];
    
    [newbtn_foot.layer setMasksToBounds:YES];
    [newbtn_foot.layer setCornerRadius:8.0*kFloatSize];
    [newbtn_foot.layer setBorderWidth:1.0*kFloatSize];
    [newbtn_foot setTitle:@"一元抢购" forState:UIControlStateNormal];
    newbtn_foot.titleLabel.font=[UIFont systemFontOfSize:10*kFloatSize];
    [newbtn_foot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [newbtn_foot.layer setBorderColor:[GlobalObject colorWithHexString:@"#ED4C77"].CGColor];
    
    [newbtn_foot addTarget:self action:@selector(pushNewOne) forControlEvents:UIControlEventTouchUpInside];
    [back_countdown addSubview:newbtn_foot];

    
}
-(void)setOneDollarModel:(OneAllModel *)allmodel withModelTyple:(NSString *)typle{
    if (allmodel.userblist.count==0) {
        _person_name.textColor=[GlobalObject colorWithHexString:@"#A4A5A6"];
        _person_name.text=@"您没有参与本次抢单";
         _btn_look_num.hidden=YES;
    }else{
         _btn_look_num.hidden=NO;
        NSString *str_join=@"本期参与:";
        NSString *str_join_num=[NSString stringWithFormat:@"%lu",allmodel.userblist.count];
        NSString *join_str=@"人次";
        NSString *name_content=[NSString stringWithFormat:@"%@%@%@",str_join,str_join_num,join_str];
        
        NSMutableAttributedString *str_num = [[NSMutableAttributedString alloc] initWithString:name_content];
        NSInteger join_int=str_join_num.length;
        [str_num addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#EB5289"] range:NSMakeRange(5,join_int)];
        
        _person_name.attributedText=str_num;
    }
   
    if (![typle isEqualToString:@"1"]) {
        _lbl_new_number.text=[NSString stringWithFormat:@"第%@期正在火热进行...",[allmodel.yygnew objectForKey:@"Termid"]];
    }
}
-(void)lookMyNumber{
    if (self.lookMyNumberBlock) {
        self.lookMyNumberBlock();
    }
}
//一元抢购
-(void)pushNewOne{
    if (self.buyNewsOneBlock) {
        self.buyNewsOneBlock();
    }
}
@end
