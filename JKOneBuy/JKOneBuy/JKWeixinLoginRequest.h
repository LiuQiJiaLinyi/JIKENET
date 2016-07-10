//
//  JKWeixinLoginRequest.h
//  ASPharmacy
//
//  Created by JiKer on 14/11/27.
//  Copyright (c) 2014年 JiKer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRequestManger.h"

@protocol JKWeixinRequestDelegate <NSObject>

@optional

-(void)weixinLoginSuccess:(NSMutableDictionary *)dic;
-(void)weixinLoginFail:(NSMutableDictionary *)dic;

-(void)getWeixinUserInfoSuccess:(NSMutableDictionary *)dic;
-(void)getWeixinUserInfoFail:(NSMutableDictionary *)dic;

-(void)LoginWeixinSuccess:(NSDictionary *)dict;
-(void)LoginWeixinfail:(NSDictionary *)dict;


@end

@interface JKWeixinLoginRequest : NSObject<JKRequestMangerDelegate>

@property (assign,nonatomic) id<JKWeixinRequestDelegate>delegate;
+ (JKWeixinLoginRequest *)shareInstance;

//微信
-(void)sendWeixinLoginRequestURL:(NSString *)url;
-(void)sendGetWeixinInfoRequest:(NSString *)url;
-(void)sendLoginURL:(NSString *)url;
@end
