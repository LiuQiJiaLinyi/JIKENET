//
//  OneCentreView.h
//  JKOneBuy
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneAllModel.h"

typedef void(^LookMyNumberBlock)();
typedef void(^BuyNewsOneBlock)();

@interface OneCentreView : UIView

@property(nonatomic,strong)UILabel        *person_name;
@property(nonatomic,strong)UILabel        *lbl_new_number;
@property(nonatomic,strong)UIButton       *btn_look_num;
@property(strong,nonatomic) LookMyNumberBlock lookMyNumberBlock;
@property(strong,nonatomic) BuyNewsOneBlock buyNewsOneBlock;

-(id)initWithFrame:(CGRect)frame withType:(NSString *)type;

-(void)setOneDollarModel:(OneAllModel *)allmodel withModelTyple:(NSString *)typle;
@end
