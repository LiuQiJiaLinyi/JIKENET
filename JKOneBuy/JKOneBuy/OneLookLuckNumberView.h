//
//  OneLookLuckNumberView.h
//  BoBoBuy
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OneLookLuckNumberView;
@protocol OneLookLuckNumberViewDelegate <NSObject>


@optional
-(void)quitLookview:(OneLookLuckNumberView *)lookview;

@end

@interface OneLookLuckNumberView : UIView


@property (nonatomic, assign) id<OneLookLuckNumberViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame andInfo:(NSArray *)infoAry andinfoDic:(NSDictionary *)yydic;
@end
