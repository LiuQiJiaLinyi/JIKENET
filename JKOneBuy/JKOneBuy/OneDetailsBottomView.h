//
//  OneDetailsBottomView.h
//  JKOneBuy
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BottomWebBlock)(NSString *str_tag);




@interface OneDetailsBottomView : UIView


@property(strong,nonatomic) BottomWebBlock bottomWebBlock;
@end
