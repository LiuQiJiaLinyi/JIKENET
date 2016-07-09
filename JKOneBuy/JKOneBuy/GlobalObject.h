//
//  GlobalObject.h
//  JikerCloudAssistantV2
//
//  Created by JiKer on 15-6-5.
//  Copyright (c) 2015年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import <UIKit/UIColor.h>
@interface GlobalObject : NSObject
+(UIColor *) colorWithHexString: (NSString *)color;

+(NSString *)nsstringZhuanUTF8:(NSString *)string;

+(BOOL)check:(NSString*)text predicate:(NSString*)predicate;
+(NSString *)getCurrentTime;

+(NSString *)md5HexDigest:(NSString*)input;


+(void)showProgresshudInView:(UIView *)view withText:(NSString *)text;
//获取本机ip
+(NSString *)localIPAddress;
@end
