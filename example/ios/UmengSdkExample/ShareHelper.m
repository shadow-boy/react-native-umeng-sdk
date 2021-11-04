//
//  ShareHelper.m
//  FrameWord
//
//  Created by apple on 2018/3/19.
//  Copyright © 2018年 none. All rights reserved.
//

#define  WECHAT_SHARE_NOTIFICATION @"WECHAT_SHARE_NOTIFICATION"

#import "ShareHelper.h"
#import "WXApi.h"
#import "MBProgressHUD+MJ.h"
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>

static ShareHelper  * shareobj = nil;

@interface ShareHelper()<WXApiDelegate>

/**
 分享完毕回调
 */

@end

@implementation ShareHelper
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareobj = [[self alloc] init];
    });
    return shareobj;
}

-(void)shareWithType:(NSInteger)type
               title:(NSString *)title
             content:(NSString * )content
                 url:(NSString *)url
               image:(UIImage * )image{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShareNoti:) name:WECHAT_SHARE_NOTIFICATION object:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        if (type == 1 || type  == 2){
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = title;
            message.description =  content;
            [message setThumbImage:[UIImage imageNamed:@"icon_share"]];
            if (image){
                WXImageObject * imageObj = [WXImageObject object];
                imageObj.imageData = UIImageJPEGRepresentation(image, 1.0);
                message.mediaObject =  imageObj;
            }
            else{
                WXWebpageObject * webobj  = [WXWebpageObject object];
                webobj.webpageUrl = url;
                message.mediaObject =  webobj;
            }
            
            SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            if (type == 1){
                req.scene = WXSceneSession;
            }
            else{
                req.scene = WXSceneTimeline;
            }
            [WXApi sendReq:req completion:^(BOOL success) {
                            
            }];
            
        }
        else if (type == 3 || type == 4){
            

//            TencentOAuth  * _tencentOAuth =  [[TencentOAuth alloc]initWithAppId:@"1106716327" andDelegate:self];
//
//
//            QQApiObject * obj_qq;
//            if (image){
//
//                obj_qq = [[QQApiImageObject alloc]initWithData:UIImageJPEGRepresentation(image, 1.0) previewImageData:UIImageJPEGRepresentation(image, 0.1) title:title description:content];
//            }
//            else{
//              UIImage *  image_share = [UIImage imageNamed:@"share_icon"];
//                obj_qq = [QQApiNewsObject
//                          objectWithURL:[NSURL URLWithString:url]
//                          title:title
//                          description:content
//                          previewImageData:UIImageJPEGRepresentation(image_share,0.1)];
//            }
//
//            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj_qq];
//
//            QQApiSendResultCode  sent;
//            if (type == 3){
//                //将内容分享到qq
//                sent = [QQApiInterface sendReq:req];
//            }
//            else{
//                //将内容分享到qzone
//                sent = [QQApiInterface SendReqToQZone:req];
//            }
//
            
            
        }
        
    });
    
    
  

    
}



- (BOOL)wechatHandleOpenUrl:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}


-(void)receiveShareNoti:(NSNotification * )noti{
    BaseResp* res = [noti.object objectForKey:@"resp"];
    if (res){
        [self onResp:res];
    }
}


#pragma mark ----统一处理微信qq分享消息的回调
- (void)onResp:(BaseResp * )resp_id {
    //微信返回的消息
    if ([resp_id isKindOfClass:[BaseResp class]]){
        BaseResp * resp = (BaseResp *)resp_id;
        if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
            switch (resp.errCode) {
                case WXSuccess:
                {
                  [MBProgressHUD showSuccess:@"分享成功"];
                          
                    if (_copletion) {
                        self.copletion(YES);
                    }
                }
                break;
                case WXErrCodeUserCancel:
                { //用户点击取消并返回
                    [MBProgressHUD showError:@"用户取消"];
                    
                    if (_copletion) {
                        self.copletion(NO);
                    }
                }
                break;
                case WXErrCodeSentFail:
                { //发送失败
                    [MBProgressHUD showError:@"发送失败"];
                    
                    if (_copletion) {
                        self.copletion(NO);
                    }
                }
                break;
                case WXErrCodeUnsupport:
                { //微信不支持
                    [MBProgressHUD showError:@"微信不支持"];
                    if (_copletion) {
                        self.copletion(NO);
                    }
                }
                break;
                case WXErrCodeAuthDeny:
                { //授权失败
                    [MBProgressHUD showError:@"授权失败"];
                    
                    if (_copletion) {
                        self.copletion(NO);
                    }
                }
                break;
                
                default:
                [MBProgressHUD showError:@"操作失败"];
                
                NSLog(@"微信分享失败, errCode = %d, retstr = %@", resp.errCode, resp.errStr);
                if (_copletion) {
                    self.copletion(NO);
                }
                break;
            }
        }
    }
//    else if ([resp_id isKindOfClass:[QQBaseResp class]]){//来自qq的消息
//        QQBaseResp * resp = (QQBaseResp *)resp_id;
//
//        if ([resp_id isKindOfClass:[SendMessageToQQResp class]]){
//            if (resp.errorDescription){
////                [MBProgressHUD showError:resp.errorDescription];
//                if (_copletion){
//                    self.copletion(NO);
//                }
//                return;
//            }
//
//            if (_copletion){
//                self.copletion(YES);
//            }
//
//
//
//        }
//
//    }
   
    
}


@end
