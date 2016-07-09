//
//  AFJsonAppApiClient.h
//  
//
//  Created by teaplant on 15/9/22.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface AFJsonAppApiClient: AFHTTPSessionManager
+ (instancetype)sharedClient;

@end
