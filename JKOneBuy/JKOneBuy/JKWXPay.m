//
//  JKWXPay.m
//  BoBoBuy
//
//  Created by JiKer on 15/12/29.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import "JKWXPay.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WXUtil.h"
#import "ApiXml.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>

@interface JKWXPay ()

@end

@implementation JKWXPay

+(id)shareInstance{
    static JKWXPay *wxpay = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        wxpay = [[JKWXPay alloc]init];
    });
    return wxpay;
}

-(void)payWithInfo:(NSDictionary *)infoDict{
    
    //商品或支付单简要描述
    NSString *body = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"body"]];
////    附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据
    NSString *attach = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"attach"]];
    //商户系统内部的订单号,32个字符内、可包含字母,
    NSString *out_trade_no = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"out_trade_no"]];
    //接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
    NSString *notify_url = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"notify_url"]];
    //交易金额默认为人民币交易，接口中参数支付金额单位为【分】，参数值不能带小数。对账单中的交易金额单位为【元】。
    NSString *total_fee = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"total_fee"]];
    //APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP。
    NSString *spbill_create_ip = [self localIPAddress];
    
    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
    time_t now;
    time(&now);
    NSString *time_stamp = [NSString stringWithFormat:@"%ld", now];
    //================================
    //预付单参数订单设置
    //================================
    srand( (unsigned)time(0) );
    //NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    
    [packageParams setObject: APP_ID             forKey:@"appid"];       //开放平台appid
    [packageParams setObject: MCH_ID             forKey:@"mch_id"];      //商户号
    //[packageParams setObject: @"APP-001"        forKey:@"device_info"]; //支付设备号或门店号
    [packageParams setObject: noncestr          forKey:@"nonce_str"];   //随机串
    [packageParams setObject: @"APP"            forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: body        forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: notify_url        forKey:@"notify_url"];  //支付结果异步通知
    [packageParams setObject: out_trade_no           forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject:spbill_create_ip forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject:total_fee forKey:@"total_fee"];//订单金额，单位为分
    [packageParams setObject:attach  forKey:@"attach"];
    
    //获取prepayId（预支付交易会话标识）
    
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = MCH_ID;
    //获取prepayId（预支付交易会话标识）
    request.prepayId= [self getPrePayId:packageParams];
    request.package = @"Sign=WXPay";
    request.nonceStr= noncestr;
    request.timeStamp= time_stamp.intValue;
    if (request.prepayId.length <= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PAY_STATE" object:@"4"];
        return;
    }
    
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject: APP_ID forKey:@"appid"];
    [signParams setObject: noncestr forKey:@"noncestr"];
    [signParams setObject: @"Sign=WXPay" forKey:@"package"];
    [signParams setObject: MCH_ID forKey:@"partnerid"];
    [signParams setObject: time_stamp forKey:@"timestamp"];
    [signParams setObject: request.prepayId forKey:@"prepayid"];
    
    request.sign= [self createMd5Sign:signParams];
    [WXApi sendReq:request];

}

#pragma mark 支付回调
-(void)payStateData:(NSNotification*)noti
{
    
}

//提交预支付
-(NSString *)sendPrepay:(NSMutableDictionary *)prePayParams
{
    NSString *prepayid = nil;
    
    //获取提交支付
    NSString *send      = [self genPackage:prePayParams];
    
    
    //发送请求post xml数据
    NSData *res = [WXUtil httpSend:@"https://api.mch.weixin.qq.com/pay/unifiedorder" method:@"POST" data:send];
    
    
    XMLHelper *xml  = [[XMLHelper alloc] init];
    
    //开始解析
    [xml startParse:res];
    
    NSMutableDictionary *resParams = [xml getDict];
    
    //判断返回
    NSString *return_code   = [resParams objectForKey:@"return_code"];
    NSString *result_code   = [resParams objectForKey:@"result_code"];
    if ( [return_code isEqualToString:@"SUCCESS"] )
    {
        //生成返回数据的签名
        NSString *sign = [self createMd5Sign:resParams ];
        NSString *send_sign =[resParams objectForKey:@"sign"] ;
        
        //验证签名正确性
        if( [sign isEqualToString:send_sign]){
            if( [result_code isEqualToString:@"SUCCESS"]) {
                //验证业务处理状态
                prepayid = [resParams objectForKey:@"prepay_id"];
                return_code = 0;
            }
        }else{
            NSLog(@"%@",resParams);
        }
    }else{
        NSLog(@"%@",resParams);
    }
    
    return prepayid;
}
//获取package带参数的签名包
-(NSString *)genPackage:(NSMutableDictionary*)packageParams
{
    NSMutableString *reqPars=[NSMutableString string];
    //生成签名
    NSString* signStr        = [self createMd5Sign:packageParams];
    //生成xml的package
    NSArray *keys = [packageParams allKeys];
    [reqPars appendString:@"<xml>\n"];
    for (NSString *categoryId in keys) {
        [reqPars appendFormat:@"<%@>%@</%@>\n", categoryId, [packageParams objectForKey:categoryId],categoryId];
    }
    [reqPars appendFormat:@"<sign>%@</sign>\n</xml>", signStr];
    
    return [NSString stringWithString:reqPars];
}
-(NSString* )getPrePayId:(NSDictionary*)packageParams
{
    NSString *prePayid;
    prePayid = [self sendPrepay:[NSMutableDictionary dictionaryWithDictionary:packageParams]];
    return prePayid;
}
//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", API_KEY];
    //得到MD5 sign签名
    NSString *md5Sign =[WXUtil md5:contentString];
    
    //输出Debug Info
    
    return md5Sign;
}

//获取本机ip
- (NSString *)localIPAddress
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
