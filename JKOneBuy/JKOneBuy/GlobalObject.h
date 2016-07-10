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

/*!
 *  @author LQJ, 16-07-10 15:07:38
 *
 *  @brief 判断是否为纯数字
 *
 *  @param string 任意字符串
 *
 *  @return 返回bool值YES是纯字符串，NO不是
 */
+(BOOL)isPureNumandCharacters:(NSString *)string;
@end
