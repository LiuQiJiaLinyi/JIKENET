//
//  homeSortCell.m
//  JKOneBuy
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "homeSortCell.h"
#import "define.h"
#import "GlobalObject.h"
#import "SDWebImage/UIImageView+WebCache.h"
@implementation homeSortCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreatView];
       
    }
    return self;
}
-(void)CreatView{
//    UILabel *head_line=[[UILabel alloc]initWithFrame:CGRectMake(50*kFloatSize, 0, self.frame.size.width-50*kFloatSize, 1*kFloatSize)];
//    [head_line setBackgroundColor:[GlobalObject colorWithHexString:@"#F1F1F1"]];
//    [self addSubview:head_line];
    UILabel *bottom_line=[[UILabel alloc]initWithFrame:CGRectMake(50*kFloatSize,self.frame.size.height-1*kFloatSize, self.frame.size.width-50*kFloatSize, 1*kFloatSize)];
    [bottom_line setBackgroundColor:[GlobalObject colorWithHexString:@"#F1F1F1"]];
    [self addSubview:bottom_line];
    
    _imgVC=[[UIImageView alloc]initWithFrame:CGRectMake(15*kFloatSize, 12*kFloatSize, 22*kFloatSize, 22*kFloatSize)];
    [_imgVC setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_imgVC];
    
    _Lab_name=[[UILabel alloc]initWithFrame:CGRectMake(52*kFloatSize,16*kFloatSize, 220*kFloatSize, 15*kFloatSize)];
    [_Lab_name setTextColor:[GlobalObject colorWithHexString:@"#5C5C5C"]];
    [_Lab_name setFont:[UIFont systemFontOfSize:13*kFloatSize]];
    _Lab_name.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_Lab_name];


}
-(void)CreateViewDict:(NSDictionary*)dic{
    [self.imgVC sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"pro_icon"]]];
    self.Lab_name.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"pro_name"]];
    
}
@end
