//
//  JKRequestManger.h
//  ISayForU
//
//  Created by vic on 14-9-4.
//  Copyright (c) 2014年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JKRequestMangerDelegate <NSObject>

@optional
-(void)responseOfHttpRequest:( id)respString anderror:(NSError *)error andRequsetID:(NSString *)RequsetID;
-(void)changeProgress:(long long)writen withTotal:(long long)total;

@end

@interface JKRequestManger : NSObject
@property(nonatomic,assign)id <JKRequestMangerDelegate> delegate;

//单例
+(JKRequestManger *)shareInstance;


//发送get请求
-(void) sendHttpGetRequest:(NSString *) url addRequsetID:(NSString *) RequsetID;

//发送post请求
- (void) sendHttpPostRequest:(NSString *)url withParams:(NSMutableDictionary *)dictionary addRequsetID:(NSString *)RequsetID ;

//发送post请求(请求数据是json格式)
- (void) sendHttpPostJsonRequest:(NSString *)url withParams:(NSMutableDictionary *)dictionary addRequsetID:(NSString *)RequsetID;

- (void) sendHttpJsonFormRequest:(NSString *)url withParams:(NSString *)dictionary addRequsetID:(NSString *)RequsetID;

//-(void)upLoadImgRequest:(NSString *)url andImg:(UIImage *)image andParams:(NSMutableDictionary *)dictionary  addRequsetID:(NSString *)RequsetID;

-(void)upLoadImgArrRequest:(NSString *)url andImg :(NSMutableArray *)imageArr andParams:(NSMutableDictionary *)dictionary   addRequsetID:(NSString *)RequsetID;


//上传音乐
-(void)upLoadMusicRequest:(NSString *)url andPath:(NSString *)path andParams:(NSMutableDictionary *)dictionary  addRequsetID:(NSString *)RequsetID;

@end
