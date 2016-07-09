//
//  PsersonalTapV.m
//  JKOneBuy
//
//  Created by Jiker on 16/7/7.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "PsersonalTapV.h"
#import "define.h"


@interface PsersonalTapV()

@end

@implementation PsersonalTapV

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    _rightImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(15 * kFloatSize, 8*kFloatSize, self.frame.size.height-16,self.frame.size.height-16)];
    
    _namelabel  = [[UILabel alloc] initWithFrame:CGRectMake(_rightImageView.frame.origin.x + _rightImageView.frame.size.width,8*kFloatSize,[UIScreen mainScreen].bounds.size.width - (_rightImageView.frame.size.width *2) ,self.frame.size.height-16)];
    [_namelabel setTextColor:[UIColor colorWithRed:0.706 green:0.706 blue:0.706 alpha:1.00]];
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_namelabel.frame.origin.x + _namelabel.frame.size.width, 10 * kFloatSize, 8* kFloatSize, 14 * kFloatSize)];
    
    [self addSubview:_rightImageView];
    [self addSubview:_namelabel];
    [self addSubview:_leftImageView];
}

@end