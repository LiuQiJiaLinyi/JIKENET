//
//  define.h
//  JKOneBuy
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#ifndef define_h
#define define_h

#define kScreenSize [UIScreen mainScreen].bounds.size
#define kFloatSize [UIScreen mainScreen].bounds.size.width/320.f

#define kFloatSizeHeight [UIScreen mainScreen].bounds.size.height/608.f

#define UserDefaults [NSUserDefaults standardUserDefaults]



#define APP_ID          @"wx33db30b8ad0ae71a"
#define APP_SECRET      @"a20021c94d0959fa2d19d442507f4471"
//商户号，填写商户对应参数
#define MCH_ID          @"1307845701"
//商户API密钥，填写相应参数
#define API_KEY         @"bo159netbo159netbo159netbo159net"

#define MainUrl  @"http://c.app.zckj.159.net/API/Api.ashx?"
#define COMMON_HEAD @"http://postc.bbg.159.net"
#define COMMON_ZZCKJ @"http://zckj.159.net"

#define URL_Userlogin  @"action=log_telp"
#define URL_GetSmsCode  @"action=up_telp"



//home
#define BBG_ONEDOLLAR @"http://postc.bbg.159.net/service/Api.ashx?action=get_yiyuanist"
//#define BBG_ONEDOLLAR @"http://c.app.zckj.159.net/API/Api.ashx?action=get_yiyuanist"

#define BBG_ONEDOLLARCELL @"http://postc.bbg.159.net/service/Api.ashx?action=mall_yyg"
//最新揭晓
#define BBG_YYGRESULTS @"http://c.app.zckj.159.net/Pages/yygResults.aspx"

//分类
#define BBG_SORT @"http://c.app.zckj.159.net/API/Api.ashx?action=get_prosortlist"

//一元抢购详情

#define BBG_ONEDETAILS @"http://postc.bbg.159.net/service/Api.ashx?action=getyyginfo"

// 1：商品详情，2：规格参数，3：购买评价
#define BBG_ONESPXQ   @"http://c.app.zckj.159.net/p2/89311.aspx?weid=%@&yygid=%@"
//往期揭晓
#define BBG_ONEWQJX   @"http://c.app.zckj.159.net/pages/yyghistory.aspx?proid=%@&weid=%@"
//商品评价
#define BBG_ONEPJ   @"http://c.app.zckj.159.net/Pages/ProductComments.aspx?proid=%@"

//一元购协议
#define BBG_ONEXY   @"http://postc.bbg.159.net/yygagreement.html"

//计算公式
#define BBG_ONEJSGS   @"http://postc.bbg.159.net/yyg/Calculate.aspx?weid=%@&yygid=%@"


//购物车提交订单http://c.app.zckj.159.net/API/Api.ashx?action=addcartorder
#define addcartorder @"/service/Api.ashx?action=addcartorder"

//一元购买
#define NOTIFY_URL_YY     @"%@/netpay/wechat/AppYYGNotifyUrl.aspx"

//普通订单详情 一元抢购订单详情
#define getorderinfo @"/service/Api.ashx?action=getorderinfo"

//一元抢购夺宝号详情
#define get_buyinfo  @"/service/Api.ashx?action=get_buyinfo"

//用户购物车商品列表

#define BBG_shopCarList @"http://c.app.zckj.159.net/API/Api.ashx?action=yyg_cart_list&weid=nBcWr11319"

//购物车提交订单接口
#define BBG_AddCartOrder @"http://c.app.zckj.159.net/API/Api.ashx?action=addcartorder"
//删除购物车记录
#define BBG_Deleat_CART @"http://c.app.zckj.159.net/API/Api.ashx?action=delete_cart"

#endif /* define_h */
