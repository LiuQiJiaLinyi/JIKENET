//
//  JKWXShare.h
//  BoBoBuy
//
//  Created by JiKer on 15/10/28.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <SDWebImage/UIImageView+WebCache.h>

//WXSceneSession  = 0,        /**< 聊天界面    */
//WXSceneTimeline = 1,        /**< 朋友圈      */
//WXSceneFavorite = 2,        /**< 收藏       */
typedef NS_ENUM(NSInteger,NSWechatShareType) {
    NSWechatShareTypeSceneSession,   /**< 聊天界面    */
    NSWechatShareTypeSceneTimeline,  /**< 朋友圈      */
    NSWechatShareTypeSceneFavorate,  /**< 收藏       */
};

@interface JKWXShare : NSObject
+(void)WXShareWithTitle:(NSString *)title withDescription:(NSString *)description withImageURL:(NSString *)imageURL withWebURL:(NSString *)webURL withWXScene:(NSWechatShareType)type;
+(void)WXShareImage:(NSString *)imageURL withWXScene:(NSWechatShareType)type;
+(void)WXShareWEID:(NSString *)title withDescription:(NSString *)description withImageURL:(NSString *)imageURL withWebURL:(NSString *)webURL withWXScene:(NSWechatShareType)type;
@end
