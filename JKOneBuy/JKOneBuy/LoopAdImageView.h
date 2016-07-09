//
//  LoopAdImageView.h
//  YZJOB-2
//
//  Created by 梁飞 on 15/9/25.
//  Copyright © 2015年 lfh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADModel.h"

@interface LoopAdImageView : UIView

+(instancetype)viewWithFrame:(CGRect)frame WithDataArray:(NSMutableArray *)dataArray;

-(void)refreshData:(NSMutableArray*)dataArr;

@property(copy,nonatomic)void(^selectADModel)(ADModel * model);

@end
