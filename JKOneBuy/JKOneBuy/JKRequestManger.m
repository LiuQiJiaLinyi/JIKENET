//
//  JKRequestManger.m
//  ISayForU
//
//  Created by vic on 14-9-4.
//  Copyright (c) 2014年 teaplant. All rights reserved.
//

#import "JKRequestManger.h"
#import <AFNetworking.h>
#import "AFURLSessionManager.h"


@implementation JKRequestManger
static JKRequestManger *requestManager = nil;

+ (JKRequestManger *)shareInstance//写为单例
{
    @synchronized(self)
    {
        if (nil == requestManager)
        {
            requestManager = [[JKRequestManger alloc] init];
        }
    }
    return requestManager;
}

-(void)sendHttpGetRequest:(NSString *)url addRequsetID:(NSString *)RequsetID {
   
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * operation, id  responseObject){
        
        [self.delegate responseOfHttpRequest:responseObject anderror:nil andRequsetID:RequsetID];
              
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        [self.delegate responseOfHttpRequest:nil anderror:error andRequsetID:RequsetID];
    }];
    
}
/*!
 *     @author teaplant-放牛娃, 14-12-02 13:12:24
 *
 *     @brief  POST 请求 代理返回数据
 *
 *     @param url        url地址
 *     @param dictionary  请求的值
 *     @param RequsetID  请求的ID
 *
 *     @since 
 */
-(void)sendHttpPostRequest:(NSString *)url withParams:(NSMutableDictionary *)dictionary addRequsetID:(NSString *)RequsetID{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
   manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", @"text/json", @"text/jafvascript", nil];

    
    [manager POST:url parameters:dictionary success:^(NSURLSessionDataTask * operation, id  responseObject){
        [self.delegate responseOfHttpRequest:responseObject anderror:nil andRequsetID:RequsetID];
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        [self.delegate responseOfHttpRequest:nil anderror:error andRequsetID:RequsetID];
   }];
    
}

- (void) sendHttpPostJsonRequest:(NSString *)url withParams:(NSMutableDictionary *)dictionary addRequsetID:(NSString *)RequsetID{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  // manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    manager.requestSerializer =[[AFJSONRequestSerializer alloc]init];
    NSDictionary *dic=@{@"json": dictionary};

    [manager POST:url  parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {

        [self.delegate responseOfHttpRequest:responseObject anderror:nil andRequsetID:RequsetID];

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [self.delegate responseOfHttpRequest:nil anderror:error andRequsetID:RequsetID];
    }];

}

//-(void)upLoadImgRequest:(NSString *)url andImg:(UIImage *)image andParams:(NSMutableDictionary *)dictionary  addRequsetID:(NSString *)RequsetID{
//
//   NSURL *baseURL  = [NSURL URLWithString:url ];
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", @"text/json", @"multipart/form-data", nil];
//    manager.requestSerializer =[[AFJSONRequestSerializer alloc]init];
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    [manager POST:url parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:@"myfile" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//      [self.delegate responseOfHttpRequest:responseObject anderror:nil andRequsetID:RequsetID];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.delegate responseOfHttpRequest:nil anderror:error andRequsetID:RequsetID];
//
//        
//    }];
//
//}

- (void) sendHttpJsonFormRequest:(NSString *)url withParams:(NSString *)dictionary addRequsetID:(NSString *)RequsetID{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
    
    
   
    NSDictionary *dic=@{@"json": dictionary};
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [self.delegate responseOfHttpRequest:responseObject anderror:nil andRequsetID:RequsetID];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [self.delegate responseOfHttpRequest:nil anderror:error andRequsetID:RequsetID];
    }];

}


-(void)upLoadImgArrRequest:(NSString *)url andImg:(NSMutableArray *)imageArr andParams:(NSMutableDictionary *)dictionary addRequsetID:(NSString *)RequsetID{
    NSURL *baseURL  = [NSURL URLWithString:url ];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", @"text/json", @"text/jafvascript", nil];

//    for (int i=0; i<[imageArr count]; i++) {
//      imageData = UIImageJPEGRepresentation([imageArr objectAtIndex:i], 0.5);
//    }
    
    NSData *imageData;
    NSData *imageData1;
    NSData *imageData2;
    NSData *imageData3;
    NSData *imageData4;


    switch ([imageArr count]) {
        case 1:
            imageData = UIImageJPEGRepresentation([imageArr objectAtIndex:0], 0.5);
            break;
           case 2:
               imageData = UIImageJPEGRepresentation([imageArr objectAtIndex:0], 0.5);
               imageData1 = UIImageJPEGRepresentation([imageArr objectAtIndex:1], 0.5);
            break;
        case 3:
            imageData = UIImageJPEGRepresentation([imageArr objectAtIndex:0], 0.5);
            imageData1 = UIImageJPEGRepresentation([imageArr objectAtIndex:1], 0.5);
            imageData2 = UIImageJPEGRepresentation([imageArr objectAtIndex:2], 0.5);
            break;
        case 4:
            imageData = UIImageJPEGRepresentation([imageArr objectAtIndex:0], 0.5);
            imageData1 = UIImageJPEGRepresentation([imageArr objectAtIndex:1], 0.5);
            imageData2 = UIImageJPEGRepresentation([imageArr objectAtIndex:2], 0.5);
            imageData3 = UIImageJPEGRepresentation([imageArr objectAtIndex:3], 0.5);

            break;
        case 5:
            imageData = UIImageJPEGRepresentation([imageArr objectAtIndex:0], 0.5);
            imageData1 = UIImageJPEGRepresentation([imageArr objectAtIndex:1], 0.5);
            imageData2 = UIImageJPEGRepresentation([imageArr objectAtIndex:2], 0.5);
            imageData3 = UIImageJPEGRepresentation([imageArr objectAtIndex:3], 0.5);
            imageData4 = UIImageJPEGRepresentation([imageArr objectAtIndex:4], 0.5);
            break;
        default:
            break;
    }

    
    [manager POST:url parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        switch ([imageArr count]) {
            case 1:
                [formData appendPartWithFileData:imageData name:@"image_1" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                break;
             case 2:
                [formData appendPartWithFileData:imageData name:@"image_1" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData1 name:@"image_2" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                break;
            case 3:
                [formData appendPartWithFileData:imageData name:@"image_1" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData1 name:@"image_2" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                 [formData appendPartWithFileData:imageData2 name:@"image_3" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                break;
            case 4:
                [formData appendPartWithFileData:imageData name:@"image_1" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData1 name:@"image_2" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData2 name:@"image_3" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData3 name:@"image_4" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];

                break;
            case 5:
                [formData appendPartWithFileData:imageData name:@"image_1" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData1 name:@"image_2" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData2 name:@"image_3" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData3 name:@"image_4" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:imageData4 name:@"image_5" fileName:@"lg_topbg.png" mimeType:@"image/jpeg"];

                break;

                
            default:
                break;
        }
        
        
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self.delegate responseOfHttpRequest:responseObject anderror:nil andRequsetID:RequsetID];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.delegate responseOfHttpRequest:nil anderror:error andRequsetID:RequsetID];
        
        
    }];
    

}
@end
