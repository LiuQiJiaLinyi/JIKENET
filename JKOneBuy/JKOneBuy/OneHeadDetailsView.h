//
//  OneHeadDetailsView.h
//  JKOneBuy
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneYiyuanModel.h"
#import "OneAllModel.h"
#import "OneLuckuserModel.h"

typedef void(^LookJsDetailsBlock)();
typedef void(^HeadLookTaNumberBlock)();
typedef void(^HeadTimeShowEnd)();


@interface OneHeadDetailsView : UIView
{
    float time_number;

}

@property(nonatomic,strong)UIImageView    *product_image;
@property(nonatomic,strong)UILabel        *product_termid;

@property(nonatomic,strong)UILabel        *product_name;
@property(nonatomic,strong)UILabel        *product_price;

@property(nonatomic,strong)UILabel        *product_allNeed;//总需要
@property(nonatomic,strong)UILabel        *product_join;//已参与
@property(nonatomic,strong)UILabel        *product_remaining;//已参与
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)UILabel        *lbl_countdown_number;//倒计时
@property(nonatomic,strong)NSTimer        *timer;

@property(nonatomic,strong)UIImageView    *person_image;//头像
@property(nonatomic,strong)UILabel        *person_name;//获奖者
@property(nonatomic,strong)UILabel        *person_ID;//用户ID
@property(nonatomic,strong)UILabel        *person_join;//本期参与
@property(nonatomic,strong)UILabel        *person_time;//揭晓时间
@property(nonatomic,strong)UILabel        *luck_number;//幸运号码

@property(strong,nonatomic)HeadLookTaNumberBlock headLookTaNumberBlock;
@property(strong,nonatomic)LookJsDetailsBlock lookJsDetailsBlock;
@property(strong,nonatomic)HeadTimeShowEnd headTimeShowEnd;


-(id)initWithFrame:(CGRect)frame withType:(NSString *)type withTitleHight:(CGFloat)hight;
-(void)setOneDollarModel:(OneYiyuanModel *)model withAllmodel:(OneAllModel *)allmodel withLuckUserMosel:(OneLuckuserModel *)luckModel;
@end
