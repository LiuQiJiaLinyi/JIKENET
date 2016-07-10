//
//  JKWeixinLoginRequest.m
//  ASPharmacy
//
//  Created by JiKer on 14/11/27.
//  Copyright (c) 2014年 JiKer. All rights reserved.
//

#import "JKWeixinLoginRequest.h"

@implementation JKWeixinLoginRequest
static  JKWeixinLoginRequest *weixinRequestManager = nil;

+ (JKWeixinLoginRequest *)shareInstance
{
    @synchronized(self) //保持线程同步
    {
        if (weixinRequestManager == nil)
        {
            weixinRequestManager = [[JKWeixinLoginRequest alloc] init];
        }
    }
    return weixinRequestManager;
}

-(void)responseOfHttpRequest:(id)respString anderror:(NSError *)error andRequsetID:(NSString *)RequsetID{
    if (respString != nil) {
         if ([RequsetID isEqualToString:@"weixinLogin"]) {
            if ([respString isKindOfClass:[NSDictionary class]]) {
                //                NSString *access_token = [respString objectForKey:@"access_token"] ;
                NSLog(@"respString %@",respString);
                NSArray *arr = [respString allKeys];
                if ([arr containsObject:@"access_token"]) {
                    [self.delegate weixinLoginSuccess:respString];
                    NSLog(@"成功");
                }else{
                    [self.delegate weixinLoginFail:respString];
                    NSLog(@"失败");
                }
            }
            
        }else if ([RequsetID isEqualToString:@"weixinUserInfo"]) {
            if ([respString isKindOfClass:[NSDictionary class]]) {
               NSLog(@"respString %@",respString);
                
                
                if (respString) {
                    [self.delegate getWeixinUserInfoSuccess:respString];
                    NSLog(@"成功");
                }else{
                    [self.delegate getWeixinUserInfoFail:respString];
                    NSLog(@"失败");
                }
            }
        }else if ([RequsetID isEqualToString:@"LoginWeixin"]) {
            if ([respString isKindOfClass:[NSDictionary class]]) {
                NSLog(@"respString %@",respString);
                
                if (respString) {
                   
//                    
//                    NSData *jsonData=[respString dataUsingEncoding:respString];
//                    NSError *err;
//                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                        options:NSJSONReadingMutableContainers
//                                                                          error:&err];
                    [self.delegate LoginWeixinSuccess:respString];
                    

                }
                
                
            }
            
        }
        
        
    }
}

-(void)sendWeixinLoginRequestURL:(NSString *)url{
    [JKRequestManger shareInstance].delegate = self;
    [[JKRequestManger shareInstance] sendHttpGetRequest:url addRequsetID:@"weixinLogin"];
}
-(void)sendGetWeixinInfoRequest:(NSString *)url{
    [JKRequestManger shareInstance].delegate = self;
    [[JKRequestManger shareInstance] sendHttpGetRequest:url addRequsetID:@"weixinUserInfo"];
}

-(void)sendLoginURL:(NSString *)url{
    [JKRequestManger shareInstance].delegate = self;
    [[JKRequestManger shareInstance] sendHttpGetRequest:url addRequsetID:@"LoginWeixin"];
   
}


@end
