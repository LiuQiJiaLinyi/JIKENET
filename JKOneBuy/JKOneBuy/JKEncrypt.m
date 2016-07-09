//
//  JKEncrypt.m
//  
//
//  Created by teaplant on 15/9/21.
//
//

#import "JKEncrypt.h"
//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>

//空字符串
#define     LocalStr_None           @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation JKEncrypt

+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}
/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+(NSString *)returnJiamiStringWithString:(NSString *)string{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[self MEncode]];
    NSMutableString *newstring = [[NSMutableString alloc]init];
    for (int i = 0; i < string.length; i++) {
        NSString *singglestr = [string substringWithRange:NSMakeRange(i,1)];
        NSString *value = [dict objectForKey:singglestr];
        if (value) {
            [newstring appendString:value];
        }
        else{
            if ([singglestr isEqualToString:@"="]) {
                [newstring appendString:@"@"];
                
            }else{
                [newstring appendString:singglestr];}
        }
    }
    return newstring;
}

+(NSString *)returnJiemiStringWithString:(NSString *)string{

    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[self setDic]];
    NSMutableString *newstring = [[NSMutableString alloc]init];
    for (int i = 0; i < string.length; i++) {
        NSString *singglestr = [string substringWithRange:NSMakeRange(i,1)];
        NSString *value = [dict objectForKey:singglestr];
        if (value) {
            [newstring appendString:value];
        }
        else{
            if ([singglestr isEqualToString:@"@"]) {
                [newstring appendString:@"="];

            }else{
                [newstring appendString:singglestr];}
            
        }
    }
    return newstring;
}
+(NSString *)returnStringWithEncodeString:(NSString *)string{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[self setDic]];
    NSMutableString *newstring = [[NSMutableString alloc]init];
    for (int i = 0; i < string.length; i++) {
        NSString *singglestr = [string substringWithRange:NSMakeRange(i,1)];
        NSString *value = [dict objectForKey:singglestr];
        if (value) {
            [newstring appendString:value];
        }
        else{
            [newstring appendString:singglestr];
        }
    }
    
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:newstring options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    //字符串转成字典
    //    NSData *JSONData = [base64Decoded dataUsingEncoding:NSUTF8StringEncoding];
    //    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return base64Decoded;
}

+(NSDictionary *)MEncode{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithObjects:@[@"m",@"n",@"b",@"v",@"c",@"q",@"x",@"z",@"l",@"k",@"j",@"h",@"g",@"f",@"d",@"s",@"a",@"p",@"o",@"i",@"u",@"y",@"t",@"r",@"e",@"w",@"M",@"N",@"B",@"V",@"C",@"Q",@"X",@"Z",@"L",@"K",@"J",@"H",@"G",@"F",@"D",@"S",@"A",@"P",@"O",@"I",@"U",@"Y",@"T",@"R",@"E",@"W"] forKeys:@[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"]];
    return dic;
}

+(NSDictionary*)setDic
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithObjects:@[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"] forKeys:@[@"m",@"n",@"b",@"v",@"c",@"q",@"x",@"z",@"l",@"k",@"j",@"h",@"g",@"f",@"d",@"s",@"a",@"p",@"o",@"i",@"u",@"y",@"t",@"r",@"e",@"w",@"M",@"N",@"B",@"V",@"C",@"Q",@"X",@"Z",@"L",@"K",@"J",@"H",@"G",@"F",@"D",@"S",@"A",@"P",@"O",@"I",@"U",@"Y",@"T",@"R",@"E",@"W"]];
    return dic;
}

+(NSDictionary *)getParams:(NSString *)string{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (string != nil) {
        NSArray *array = [string componentsSeparatedByString:@"&"];
        for (NSString *str in array) {
            NSRange range = [str rangeOfString:@"="];
            NSString *key = [str substringToIndex:range.location];
            NSString *value = [str substringFromIndex:range.length+range.location];
            [dic setObject:value forKey:key];
        }
        NSDictionary *resultDict = [NSDictionary dictionaryWithDictionary:dic];
        return resultDict;
    }
    else{
        return nil;
    }
}

@end
