//
//  homeModel.h
//  NewOnePay
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADModel.h"
#import "FinishModel.h"
#import "RecomModel.h"
#import <MJExtension/MJExtension.h>
@interface homeModel : NSObject


@property(retain,nonatomic)NSArray * ad;//广告
@property(retain,nonatomic)NSArray * finish;//最新揭晓
@property(strong,nonatomic)NSArray * sell;//热门商品推荐
@property(strong,nonatomic)NSArray * rec;//热门商品推荐



@end
