//
//  ShareHelper.h
//  FrameWord
//
//  Created by apple on 2018/3/19.
//  Copyright © 2018年 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^LWShareComplete)(BOOL success);


@interface ShareHelper : NSObject


+(instancetype)sharedInstance;

/**
 分享完成的回调 
 */
@property (nonatomic,copy)LWShareComplete  copletion;


/**
 分享平台

 @param type   1分享到微信好友 2.分享到微信朋友圈 3.QQ好友 4.QQ空间
 @param title <#title description#>
 @param content <#content description#>
 @param url <#url description#>
 @param image 截图分享的截图 image 有值 url为空
 */
-(void)shareWithType:(NSInteger)type
       title:(NSString *)title
     content:(NSString * )content
                 url:(NSString *)url
               image:(UIImage * )image;



- (BOOL)wechatHandleOpenUrl:(NSURL *)url;





@end
