//
//  homeOneHeaderView.m
//  JKOneBuy
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "homeOneHeaderView.h"
#import "define.h"
#import "GlobalObject.h"
#import "SDWebImage/UIImageView+WebCache.h"
@implementation homeOneHeaderView
-(id)initWithFrame:(CGRect)frame withmodel:(homeModel*)homemodel withSortArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self creatADDView:homemodel];
        [self creatClassifyView:homemodel withsortArray:array];
    }
    return self;
    
}

//广告页面
-(void)creatADDView:(homeModel*)homeModel{
    
        NSMutableArray* slideLoopArray=[[NSMutableArray alloc]initWithArray:homeModel.ad];
        CGRect loopViewFrame=CGRectMake(0, 0, self.frame.size.width, 130*kFloatSize);
        LoopAdImageView* loopView=[LoopAdImageView viewWithFrame:loopViewFrame WithDataArray:slideLoopArray];
        [self addSubview:loopView];
        loopView.selectADModel=^(ADModel * model){
            [self Click_Slider:model];
        };
    
}
//点击广告页面
-(void)Click_Slider:(ADModel*)model
{
    //    [self.navigationController.navigationBar setHidden:NO];
    
        if ([self.delegate respondsToSelector:@selector(headOneDollarADtotypleview:)]) {
            [self.delegate headOneDollarADtotypleview:model];
        }
    
}
//分类
-(void)creatClassifyView:(homeModel *)homemodel withsortArray:(NSArray*)arysort{
    
    
    [self creatSortView:arysort];
    
    
    
    CGRect newframe=CGRectMake(0, 179*kFloatSize, self.frame.size.width,150*kFloatSize);
    [self creatAnnounceAndRecommendView:newframe withtitle:@"最新揭晓" withImageName:@"home_new.png" withArray:homemodel.finish];
     CGRect recommendframe=CGRectMake(0, 336*kFloatSize, self.frame.size.width,150*kFloatSize);
    [self creatAnnounceAndRecommendView:recommendframe withtitle:@"热门商品推荐" withImageName:@"home_recommend.png" withArray:homemodel.sell];
    
    UIButton* btn_hot=[UIButton buttonWithType:UIButtonTypeCustom];
    btn_hot.frame=CGRectMake(6*kFloatSize, 495*kFloatSize, 15*kFloatSize, 15*kFloatSize);
    [btn_hot setBackgroundImage:[UIImage imageNamed:@"home_hot.png"] forState:UIControlStateNormal];
    [self addSubview:btn_hot];
    
    UILabel *lab_hot_title=[[UILabel alloc]initWithFrame:CGRectMake(25*kFloatSize,495*kFloatSize, 110*kFloatSize, 15*kFloatSize)];
    lab_hot_title.text=@"今日热门商品";
    [lab_hot_title setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    [lab_hot_title setTextColor:[GlobalObject colorWithHexString:@"#9D9D9D"]];
    lab_hot_title.textAlignment=NSTextAlignmentLeft;
    
    [self addSubview:lab_hot_title];
    
    
}
-(void)creatSortView:(NSArray *)arySort{
    UIButton *btn_classify= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn_classify addTarget:self action:@selector(click_Allclassify:) forControlEvents:UIControlEventTouchUpInside];
    [btn_classify setBackgroundImage:[UIImage imageNamed:@"home_ classify.png"] forState:UIControlStateNormal];
    [btn_classify setFrame:CGRectMake(28*kFloatSize, 135*kFloatSize, 20*kFloatSize, 20*kFloatSize)];
    [self addSubview:btn_classify];
    
    UILabel *lbl_classify=[[UILabel alloc]initWithFrame:CGRectMake(18*kFloatSize, 160*kFloatSize, 40*kFloatSize, 10*kFloatSize)];
    lbl_classify.textColor=[GlobalObject colorWithHexString:@"#858687"];
    lbl_classify.font=[UIFont systemFontOfSize:10*kFloatSize];
    lbl_classify.textAlignment=NSTextAlignmentCenter;
    
    lbl_classify.text=[NSString stringWithFormat:@"全部分类"];
    [self addSubview:lbl_classify];
    
    
    scr_classify=[[UIScrollView alloc] initWithFrame:CGRectMake(60*kFloatSize, 130*kFloatSize, 320.0f*kFloatSize, 50.0f*kFloatSize)];
    scr_classify.pagingEnabled=NO;
    scr_classify.showsHorizontalScrollIndicator=NO;
    
    [scr_classify setBackgroundColor:[UIColor clearColor]];
    [self addSubview:scr_classify];
    
    NSInteger scr_num=arySort.count*60*kFloatSize+10*kFloatSize+80*kFloatSize;
    scr_classify.contentSize =  CGSizeMake(scr_num, 0);
    
    CGRect frameA=CGRectMake(10*kFloatSize, 5*kFloatSize, 40*kFloatSize, 40*kFloatSize);
    for (int i=0; i<arySort.count; i++) {
        
        
        UIButton * btn;
        
        
        
        frameA.origin.x=i*60*kFloatSize+10*kFloatSize;
        
        
        
        if (arySort.count>0) {
            if ([[arySort objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
                btn=[self createSort:[arySort objectAtIndex:i]  WithFrame:frameA];
            }
        }
        
        
        
        [btn addTarget:self action:@selector(Click_sortBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        
        [scr_classify addSubview:btn];
    }

}
//点击全部分类
-(void)click_Allclassify:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(headOneAllSortbtn:)]) {
        [self.delegate headOneAllSortbtn:btn];
    }
    
    
}
//最新公布与热门推荐
-(void)creatAnnounceAndRecommendView:(CGRect)frame withtitle:(NSString *)title withImageName:(NSString *)imagename withArray:(NSArray *)array{
    
    UIView *cview=[[UIView alloc]initWithFrame:frame];
    [cview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:cview];
   
    [cview addSubview:[self creatLable:CGRectMake(0, 0, self.frame.size.width,1*kFloatSize)]];
    [cview addSubview:[self creatLable:CGRectMake(0, 149*kFloatSize, self.frame.size.width,1*kFloatSize)]];
    [cview addSubview:[self creatLable:CGRectMake(106*kFloatSize, 30*kFloatSize, 1*kFloatSize,110*kFloatSize)]];
    [cview addSubview: [self creatLable:CGRectMake(212*kFloatSize, 30*kFloatSize, 1*kFloatSize,110*kFloatSize)]];
    
    
    
   
     NSMutableArray* ary_new=[[NSMutableArray alloc]initWithArray:array];
    
     UIButton* btn_new=[UIButton buttonWithType:UIButtonTypeCustom];
     btn_new.frame=CGRectMake(6*kFloatSize, 9*kFloatSize, 15*kFloatSize, 15*kFloatSize);
    [btn_new setBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    [cview addSubview:btn_new];
    
    UILabel *lab_head_title=[[UILabel alloc]initWithFrame:CGRectMake(25*kFloatSize,9*kFloatSize, 110*kFloatSize, 15*kFloatSize)];
    lab_head_title.text=title;
    [lab_head_title setFont:[UIFont systemFontOfSize:12*kFloatSize]];
    [lab_head_title setTextColor:[GlobalObject colorWithHexString:@"#9D9D9D"]];
    lab_head_title.textAlignment=NSTextAlignmentLeft;
    
    [cview addSubview:lab_head_title];
    
    
    
    CGRect frameA=CGRectMake(10*kFloatSize, 30*kFloatSize, 80*kFloatSize, 105*kFloatSize);
    for (int i=0; i<3; i++) {
        
        
        UIButton * btn;
        
        
        
        frameA.origin.x=i*106*kFloatSize+13*kFloatSize;
        
        
        
        if (ary_new.count>0) {
            if ([[ary_new objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
                btn=[self createdic:[ary_new objectAtIndex:i] WithFrame:frameA];
            }
        }
        
        
        
        [btn addTarget:self action:@selector(Click_AnnounceAndRecommend:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        
        [cview addSubview:btn];
    }
    
    
  
}
-(void)Click_AnnounceAndRecommend:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
    if ([self.delegate respondsToSelector:@selector(headOneDollarbtnDetails:)]) {
        [self.delegate headOneDollarbtnDetails:btn];
    }
}
-(void)Click_sortBtn:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(headAloneSortbtn:)]) {
        [self.delegate headAloneSortbtn:btn];
    }
    
}
-(UILabel *)creatLable:(CGRect)frame{
    UILabel *lable=[[UILabel alloc]initWithFrame:frame];
    [lable setBackgroundColor:[GlobalObject colorWithHexString:@"#E5E5E5"]];
    return lable;
}
-(UIView *)creatView:(CGRect)frame{
    UIView *cview=[[UIView alloc]initWithFrame:frame];
    [cview setBackgroundColor:[UIColor whiteColor]];
   
    return cview;
}
-(UIButton *)createdic:(NSDictionary*)dic WithFrame:(CGRect)frame
{
    //30
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    
    
    NSString *str_imag_url=[NSString stringWithFormat:@"%@",[dic objectForKey:@"productImage"]];
    UIImageView* iView=[[UIImageView alloc]init];
    iView.frame=CGRectMake(0, 0,frame.size.width, 80*kFloatSize);
    [iView sd_setImageWithURL:[NSURL URLWithString:str_imag_url] placeholderImage:nil];
   
    [btn addSubview:iView];
    
    UIImageView* iView_qishu=[[UIImageView alloc]init];
    iView_qishu.frame=CGRectMake(12*kFloatSize, 0,frame.size.width-12*kFloatSize, 12*kFloatSize);
    [iView_qishu setBackgroundColor:[UIColor clearColor]];
    [iView_qishu setImage:[UIImage imageNamed:@"one_qishu"]];
    [btn addSubview:iView_qishu];
    

    UILabel *lbl_gx_qishu=[[UILabel alloc]initWithFrame:CGRectMake(12*kFloatSize,0,iView_qishu.frame.size.width-12*kFloatSize, 10*kFloatSize)];
    NSString *qishu_str=[NSString stringWithFormat:@"%@",[dic objectForKey:@"termid"]];
    if (qishu_str==nil || [qishu_str isEqualToString:@"(null)"]) {
        qishu_str=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Termid"]];
    }
    lbl_gx_qishu.text=[NSString stringWithFormat:@"%@期",qishu_str];
    lbl_gx_qishu.textColor=[UIColor whiteColor];
    lbl_gx_qishu.font=[UIFont systemFontOfSize:9];
    lbl_gx_qishu.textAlignment=NSTextAlignmentCenter;
    [iView_qishu addSubview:lbl_gx_qishu];
    
    
    //
    UILabel *lbl_gx=[[UILabel alloc]initWithFrame:CGRectMake(0, 87*kFloatSize, frame.size.width, 10*kFloatSize)];
    
    lbl_gx.font=[UIFont systemFontOfSize:10*kFloatSize];
    lbl_gx.textAlignment=NSTextAlignmentCenter;
    NSString *name_str=[NSString stringWithFormat:@"恭喜"];
    
    NSString *str_name;
    NSString *luckyUserName=[NSString stringWithFormat:@"luckyUserName"];
    if ([[dic allKeys]containsObject:luckyUserName]) {
        lbl_gx.textColor=[GlobalObject colorWithHexString:@"#599AFC"];
        
        str_name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"luckyUserName"]];
        
        NSString *name_content=[NSString stringWithFormat:@"%@ %@",name_str,str_name];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:name_content];
        
        [str addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#7D7D7D"] range:NSMakeRange(0,name_str.length)];
        
        lbl_gx.attributedText=str;
       
    }else{
        lbl_gx.textColor=[GlobalObject colorWithHexString:@"#7D7D7D"];
        str_name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ProductName"]];
        lbl_gx.text=str_name;
    }
    
    
   
    
    [btn addSubview:lbl_gx];
    
    return btn;
}
-(UIButton *)createSort:(NSDictionary*)dic WithFrame:(CGRect)frame
{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    
    NSString *str_imag_url=[NSString stringWithFormat:@"%@",[dic objectForKey:@"pro_icon"]];
    UIImageView* iView=[[UIImageView alloc]init];
    iView.frame=CGRectMake(10*kFloatSize,0, 20*kFloatSize, 20*kFloatSize);
    [iView sd_setImageWithURL:[NSURL URLWithString:str_imag_url] placeholderImage:nil];
    
    [btn addSubview:iView];
    
    
    UILabel *lbl_classify=[[UILabel alloc]initWithFrame:CGRectMake(0, 22*kFloatSize, 40*kFloatSize, 16*kFloatSize)];
    lbl_classify.textColor=[GlobalObject colorWithHexString:@"#858687"];
    lbl_classify.font=[UIFont systemFontOfSize:10*kFloatSize];
    lbl_classify.textAlignment=NSTextAlignmentCenter;
    
    lbl_classify.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"pro_name"]];
    [btn addSubview:lbl_classify];
    
    
    return btn;
}
@end
