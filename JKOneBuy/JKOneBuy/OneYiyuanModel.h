//
//  OneYiyuanModel.h
//  JKOneBuy
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
@interface OneYiyuanModel : NSObject

@property(retain,nonatomic)NSString * Endtime;
@property(retain,nonatomic)NSString * Isstate;

@property(retain,nonatomic)NSString * LuckyNum;

@property(retain,nonatomic)NSString * ProCount;
@property(retain,nonatomic)NSString * ProductId;
@property(retain,nonatomic)NSString * ProductName;
@property(retain,nonatomic)NSString * ProductPrice;


@property(retain,nonatomic)NSString * ProductTypeId;
@property(retain,nonatomic)NSString * SalerCount;
@property(retain,nonatomic)NSString * ServerTime;
@property(retain,nonatomic)NSString * Starttime;
@property(retain,nonatomic)NSString * State;
@property(retain,nonatomic)NSString * Termid;

@property(retain,nonatomic)NSString * Times;
@property(retain,nonatomic)NSString * id;
@property(retain,nonatomic)NSString * productImage;


/*
 数据库使用添加
 */
@property(retain,nonatomic)NSString * goodCount;
@property(retain,nonatomic)NSString * remainCount;
@property(assign,nonatomic)BOOL isSelect;
@property(retain,nonatomic)NSString * YYGId;
@property(retain,nonatomic)NSString * Buycount;
@end
