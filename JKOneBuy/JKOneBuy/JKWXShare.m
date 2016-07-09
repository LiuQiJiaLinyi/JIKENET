//
//  JKWXShare.m
//  BoBoBuy
//
//  Created by JiKer on 15/10/28.
//  Copyright © 2015年 teaplant. All rights reserved.
//

#import "JKWXShare.h"


@implementation JKWXShare
+(void)WXShareWithTitle:(NSString *)title withDescription:(NSString *)description withImageURL:(NSString *)imageURL withWebURL:(NSString *)webURL withWXScene:(NSWechatShareType)type{
    WXImageObject *imgObj = [WXImageObject object];
    if (imageURL != nil) {
        imgObj.imageUrl = imageURL;
    }
    else{
        UIImage *image = [UIImage imageNamed:@"defaultShare.png"];
        imgObj.imageData = UIImageJPEGRepresentation(image, 0.25);
    }
    
    WXWebpageObject *webObj = [WXWebpageObject object];
    if (webURL != nil) {
        webObj.webpageUrl = webURL;
    }
    

    
    WXMediaMessage *message = [WXMediaMessage message];
    if (title != nil) {
        message.title = title  ;
    }
    if (description != nil) {
        message.description = description;
    }
    
    if (webObj != nil) {
        message.mediaObject = webObj;
    }
    
    if (imageURL != nil) {
        UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
        UIImage *thumbImg = [JKWXShare thumbImageWithImage:desImage limitSize:CGSizeMake(90, 90)];
        message.thumbData = UIImageJPEGRepresentation(thumbImg, 1);
    }
    else{
        UIImage *image = [UIImage imageNamed:@"defaultShare.png"];
        message.thumbData = UIImageJPEGRepresentation(image, 0.25);
    }
    
    //            NSLog(@"%@,%d",thumbImg,message.thumbData.length);
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    if (type == NSWechatShareTypeSceneSession) {
        req.scene = WXSceneSession;
    }
    else if (type == NSWechatShareTypeSceneTimeline){
        req.scene = WXSceneTimeline;
    }
    else{
        req.scene = WXSceneFavorite;
    }
    req.bText = NO;
    req.message = message;
    [WXApi sendReq:req];
}

+(void)WXShareImage:(NSString *)imageURL withWXScene:(NSWechatShareType)type{
   
    NSError *error;
    NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageURL] options:NSDataReadingMappedAlways error:&error];
    if (error != nil) {
        NSLog(@"%@",[error localizedFailureReason]);
    }
    UIImage *desImage = [[UIImage alloc]initWithData:data scale:1];
    UIImage *thumbImg = [JKWXShare thumbImageWithImage:desImage limitSize:CGSizeMake(400, 400)];
     WXImageObject *imgObj = [WXImageObject object];
    imgObj.imageData = data;
    
    WXMediaMessage *message =[WXMediaMessage message];
    message.thumbData = data;
    message.mediaObject = imgObj;
    [message setThumbImage:thumbImg];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.message = message;
    if (type == NSWechatShareTypeSceneSession) {
        req.scene = WXSceneSession;
    }
    else if (type == NSWechatShareTypeSceneTimeline){
        req.scene = WXSceneTimeline;
    }
    else{
        req.scene = WXSceneFavorite;
    }
    [WXApi sendReq:req];
 }
+(void)WXShareWEID:(NSString *)title withDescription:(NSString *)description withImageURL:(NSString *)imageURL withWebURL:(NSString *)webURL withWXScene:(NSWechatShareType)type{
    WXImageObject *imgObj = [WXImageObject object];
    if (imageURL != nil) {
        imgObj.imageUrl = imageURL;
    }else{
        UIImage *imge_view=[UIImage imageNamed:@"AppIcon"];
        NSData *dataImage= UIImageJPEGRepresentation(imge_view, 0.75);;
        imgObj.imageData=dataImage;
    }
    
    WXWebpageObject *webObj = [WXWebpageObject object];
    if (webURL != nil) {
        webObj.webpageUrl = webURL;
    }
    
    
    
    WXMediaMessage *message = [WXMediaMessage message];
    if (title != nil) {
        message.title = title  ;
    }
    if (description != nil) {
        message.description = description;
    }
    
    if (webObj != nil) {
        message.mediaObject = webObj;
    }
    
    if (imageURL != nil) {
        UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
        UIImage *thumbImg = [JKWXShare thumbImageWithImage:desImage limitSize:CGSizeMake(90, 90)];
        message.thumbData = UIImageJPEGRepresentation(thumbImg, 1);
    }else{
        UIImage *desImage = [UIImage imageNamed:@"AppIcon"];
        UIImage *thumbImg = [JKWXShare thumbImageWithImage:desImage limitSize:CGSizeMake(90, 90)];
        message.thumbData = UIImageJPEGRepresentation(thumbImg, 1);

    }
    
    //            NSLog(@"%@,%d",thumbImg,message.thumbData.length);
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    if (type == NSWechatShareTypeSceneSession) {
        req.scene = WXSceneSession;
    }
    else if (type == NSWechatShareTypeSceneTimeline){
        req.scene = WXSceneTimeline;
    }
    else{
        req.scene = WXSceneFavorite;
    }
    req.bText = NO;
    req.message = message;
    [WXApi sendReq:req];
    
}

+ (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize
{
    if (scImg.size.width <= limitSize.width && scImg.size.height <= limitSize.height) {
        return scImg;
    }
    CGSize thumbSize;
    if (scImg.size.width / scImg.size.height > limitSize.width / limitSize.height) {
        thumbSize.width = limitSize.width;
        thumbSize.height = limitSize.width / scImg.size.width * scImg.size.height;
    }
    else {
        thumbSize.height = limitSize.height;
        thumbSize.width = limitSize.height / scImg.size.height * scImg.size.width;
    }
    UIGraphicsBeginImageContext(thumbSize);
    [scImg drawInRect:(CGRect){CGPointZero,thumbSize}];
    UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImg;
}
@end
