//
//  JKAlertView.m
//  IFinance
//
//  Created by JiKer on 15/12/18.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import "JKAlertView.h"

@interface JKAlertView ()<UIActionSheetDelegate,UIAlertViewDelegate>
{
    NSString *_title;
    NSString *_message;
    NSString *_cancelBtnTitle;
    NSArray *_otherTitles;
    
    NSAlertStyle _style;
}
@property (nonatomic, assign) id<JKAlertDelegate> delegate;
@end

@implementation JKAlertView

+(id)shareInstance{
    static JKAlertView *alertView = nil;
    static dispatch_once_t onceToken;
    if (alertView == nil) {
        dispatch_once(&onceToken, ^{
            alertView = [[JKAlertView alloc]init];
        });
    }
    return alertView;
}

-(void)showWithInfo:(NSDictionary *)dict withAlertStyle:(NSAlertStyle)style WithDelegate:(id<JKAlertDelegate>)delegate{
    self.delegate=delegate;
    _style = style;
    NSString *title = [dict objectForKey:@"title"];
    _title =  title.length > 0?title:nil;
    NSString *message = [dict objectForKey:@"message"];
    _message =  message.length > 0?message:nil;
    NSString *cancelBtnTitle = [dict objectForKey:@"cancelBtnTitle"];
    _cancelBtnTitle =  cancelBtnTitle.length > 0?cancelBtnTitle:nil;
    NSArray *otherTitles = [NSArray arrayWithArray:[dict objectForKey:@"otherTitles"]];
    _otherTitles =  otherTitles.count > 0?otherTitles:nil;
    [self loadAlert];
}

-(void)loadAlert{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [self addAlertController];
    }
    else{
        [self addAlertView];
    }
}

-(void)addAlertController{
    UIAlertControllerStyle style;
    if (_style == NSAlertStyleAction) {
        style = UIAlertControllerStyleActionSheet;
    }
    else{
        style= UIAlertControllerStyleAlert;
    }
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:style];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:_cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if ([self.delegate respondsToSelector:@selector(alertView:clickBtnTitle:)]) {
            [self.delegate alertView:self clickBtnTitle:_cancelBtnTitle];
        }
    }];
    [controller addAction:cancelAction];
    
    __weak typeof (self)weakSelf = self;
    for (NSString *title in _otherTitles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([weakSelf.delegate respondsToSelector:@selector(alertView:clickBtnTitle:)]) {
                [weakSelf.delegate alertView:self clickBtnTitle:title];
            }
        }];
        [controller addAction:action];
    }
    
    UIViewController *VC = (UIViewController *)self.delegate;
    [VC presentViewController:controller animated:YES completion:^{
        NSLog(@"完成");
    }];
}

-(void)addAlertView{
    if (_style==NSAlertStyleAction) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:_title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        for (NSString * btnTitle in _otherTitles) {
            [actionSheet addButtonWithTitle:btnTitle];
        }
        [actionSheet addButtonWithTitle:_cancelBtnTitle];
        actionSheet.cancelButtonIndex = _otherTitles.count;
        UIViewController *VC = (UIViewController*)self.delegate;
        [actionSheet showInView:VC.view];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:_title message:_message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        for (NSString *btnTitle in _otherTitles) {
            [alertView addButtonWithTitle:btnTitle];
        }
        [alertView addButtonWithTitle:_cancelBtnTitle];
        alertView.cancelButtonIndex = _otherTitles.count;
        [alertView show];
    }
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"self:%@",self);
    if ([self.delegate respondsToSelector:@selector(alertView:clickBtnTitle:)]) {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        [self.delegate alertView:self clickBtnTitle:title];
    }
}
#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([self.delegate respondsToSelector:@selector(alertView:clickBtnTitle:)]) {
        NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
        [self.delegate alertView:self clickBtnTitle:title];
    }
}

@end
