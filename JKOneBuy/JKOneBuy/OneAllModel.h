//
//  OneAllModel.h
//  JKOneBuy
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@interface OneAllModel : NSObject

@property(retain,nonatomic)NSString * Isstate;
@property(retain,nonatomic)NSDictionary * luckuser;
@property(retain,nonatomic)NSString * productdesc;
@property(retain,nonatomic)NSString * productimgurl;
@property(retain,nonatomic)NSString * productname;
@property(retain,nonatomic)NSString * sharedesc;
@property(retain,nonatomic)NSString * shareimg;
@property(retain,nonatomic)NSString * sharelinkurl;
@property(retain,nonatomic)NSString * sharetitle;

@property(retain,nonatomic)NSArray * favourate;
@property(retain,nonatomic)NSArray * luckblist;
@property(retain,nonatomic)NSArray * protype;
@property(retain,nonatomic)NSArray * userblist;
@property(strong,nonatomic)NSArray * yiyuan;
@property(strong,nonatomic)NSDictionary * yygnew;

@end
