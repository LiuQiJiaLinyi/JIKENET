//
//  homeOneHeaderView.h
//  JKOneBuy
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADModel.h"
#import "homeModel.h"
#import "LoopAdImageView.h"


@class homeOneHeaderView;
@protocol homeOneHeaderViewDelegate <NSObject>


@optional
-(void) headOneDollarADtotypleview:(ADModel *)model;
-(void) headOneDollarbtnDetails:(UIButton *)btn;
-(void) headOneAllSortbtn:(UIButton *)btn;
-(void) headAloneSortbtn:(UIButton *)btn;
@end
@interface homeOneHeaderView : UIView
{
   
    UIScrollView  *scr_classify;
}
@property (nonatomic,assign) id<homeOneHeaderViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withmodel:(homeModel*)homemodel withSortArray:(NSArray *)array;
@end
