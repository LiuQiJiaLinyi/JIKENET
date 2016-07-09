//
//  JKAlertView.h
//  IFinance
//
//  Created by JiKer on 15/12/18.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JKAlertView;

typedef NS_ENUM(NSInteger,NSAlertStyle) {
    NSAlertStyleAction = 1,
    NSAlertStyleAlert = 0
};

@protocol JKAlertDelegate <NSObject>

-(void)alertView:(JKAlertView *)alertView clickBtnTitle:(NSString *)title;

@end

@interface JKAlertView : NSObject
@property (nonatomic, copy) NSString *identifier;
+(id)shareInstance;
-(void)showWithInfo:(NSDictionary *)dict withAlertStyle:(NSAlertStyle)style WithDelegate:(id<JKAlertDelegate>)delegate;
@end
