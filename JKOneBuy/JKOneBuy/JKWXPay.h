//
//  JKWXPay.h
//  BoBoBuy
//
//  Created by JiKer on 15/12/29.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
#import "WXApi.h"

@interface JKWXPay : NSObject
+(id)shareInstance;
-(void)payWithInfo:(NSDictionary *)infoDict;
@end
