//
//  AFJsonAppApiClient.m
//  
//
//  Created by teaplant on 15/9/22.
//
//

#import "AFJsonAppApiClient.h"
static NSString * const AFAppDotNetAPIBaseURLString = @"http://bo.159.net/";

@implementation AFJsonAppApiClient

+ (instancetype)sharedClient {
    static AFJsonAppApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFJsonAppApiClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer =[AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", @"text/json", @"text/jafvascript", nil];
    });
    return _sharedClient;
}

@end

