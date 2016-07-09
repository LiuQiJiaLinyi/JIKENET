//
//  GlobalObject.m
//  JikerCloudAssistantV2
//
//  Created by JiKer on 15-6-5.
//  Copyright (c) 2015年 teaplant. All rights reserved.
//

#import "GlobalObject.h"
#import <CommonCrypto/CommonDigest.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation GlobalObject
#pragma mark 颜色码制转Uicolor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark NSString --->UTF-8
+(NSString *)nsstringZhuanUTF8:(NSString *)string
{
    NSString *urlString= [NSString stringWithFormat:@"%@",string];
    
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)urlString,                                                                                            NULL,                                                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return outputStr;
}

#pragma  mark 正则验证
+(BOOL)check:(NSString*)text predicate:(NSString*)predicate
{
    NSString *regex = predicate;
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [p evaluateWithObject:text];
}

+(NSString *)getCurrentTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * str = [formatter stringFromDate:date];
    return str;
}
+(NSString *)getYestodayTime
{
    int day = 60*60*24;
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:-day];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * str = [formatter stringFromDate:date];
    return str;
    
}
+(NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

+(void)showProgresshudInView:(UIView *)view withText:(NSString *)text{
    MBProgressHUD *progressHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHud.mode = MBProgressHUDModeText;
//    progressHud.cornerRadius = 5;
    progressHud.labelFont = [UIFont systemFontOfSize:14];
    progressHud.opacity = 0.7;
    progressHud.margin = 7;
    progressHud.labelText = text;
    progressHud.removeFromSuperViewOnHide = YES;
    [progressHud hide:YES afterDelay:1.5];
}
//获取本机ip
+ (NSString *)localIPAddress
{
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                //NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                //if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return localIP;
}

@end
