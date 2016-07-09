//
//  JKEncrypt.h
//  
//
//  Created by teaplant on 15/9/21.
//
//

#import <Foundation/Foundation.h>

@interface JKEncrypt : NSObject


/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;


//加密
+(NSString *)returnJiamiStringWithString:(NSString *)string;



//解密
+(NSString *)returnJiemiStringWithString:(NSString *)string;


+(NSString *)returnStringWithEncodeString:(NSString *)string;

//把a=b&c=d形式的字符串转换成a为键b为值的键值对形式的字典
+(NSDictionary *)getParams:(NSString *)string;

@end
