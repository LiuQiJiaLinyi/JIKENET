//
//  UserModel.h
//  BoBoBuy
//
//  Created by teaplant on 15/12/16.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(assign,nonatomic)NSString * nickname;
@property(assign,nonatomic)NSString * name;

@property(retain,nonatomic)NSString * headimgurl;
@property(strong,nonatomic)NSString * xuehao;
@property(assign,nonatomic)NSString * level;
@property(retain,nonatomic)NSString * attach;
@property(assign,nonatomic)NSString * monitornum;
@property(assign,nonatomic)NSString * planbalance;
@property(assign,nonatomic)NSString * confirmbalance;
@property(assign,nonatomic)NSString * userlevel;

@property(assign,nonatomic)BOOL IsSupplier;
@property(assign,nonatomic)BOOL IsStock;
@property(assign,nonatomic)BOOL isblack;
@property(assign,nonatomic)BOOL hasProp;
@property(assign,nonatomic)BOOL IsAgent;

@end
