/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

#import "RNUMConfigure.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>


//#ifdef FB_SONARKIT_ENABLED
//#import <FlipperKit/FlipperClient.h>
//#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
//#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
//#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
//#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
//#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>
//static void InitializeFlipper(UIApplication *application) {
//  FlipperClient *client = [FlipperClient sharedClient];
//  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
//  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
//  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
//  [client addPlugin:[FlipperKitReactPlugin new]];
//  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
//  [client start];
//}
//#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //  #ifdef FB_SONARKIT_ENABLED
  //    InitializeFlipper(application);
  //  #endif
  
  
  //打开调试模式
  [UMConfigure setLogEnabled:YES];
  //初始化umeng，会自动读取info.plist中的参数
  [RNUMConfigure initWithAppkey:@"61824e1ae014255fcb68c38a" channel:@"App Store"];
  [self confitUShareSettings];
  [self configUSharePlatforms];
  
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"UmengSdkExample"
                                            initialProperties:nil];
  
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  
  
  return YES;
}
-(void)confitUShareSettings{
  // 微信、QQ、微博完整版会校验合法的universalLink，不设置会在初始化平台失败
  //配置微信Universal Link需注意 universalLinkDic的key是rawInt类型，不是枚举类型 ，即为 UMSocialPlatformType.wechatSession.rawInt
  [UMSocialGlobal shareInstance].universalLinkDic =@{@(UMSocialPlatformType_WechatSession):@"https://t.jqzhipin.com/app/",
                                                     @(UMSocialPlatformType_QQ):@"",
                                                     @(UMSocialPlatformType_Sina):@""};

}

-(void)configUSharePlatforms{
  
  
  
  /* 设置微信的appKey和appSecret */
  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx8dbb1a539e7e4527" appSecret:@"1a849eb0800bbf7e8ed9852f497deda3" redirectURL:@"https://t.jqzhipin.com/app/"];
  /*设置小程序回调app的回调*/
  [[UMSocialManager defaultManager] setLauchFromPlatform:(UMSocialPlatformType_WechatSession) completion:^(id userInfoResponse,NSError*error){
    NSLog(@"setLauchFromPlatform:userInfoResponse:%@",userInfoResponse);
  }];
  /*
   * 移除相应平台的分享，如微信收藏
   */
  //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
  
  /* 设置分享到QQ互联的appID
   * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
   */
  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
  
  /* 设置新浪的appKey和appSecret */
  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
  
  
  
  
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}


-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url
{
  BOOL result =[[UMSocialManager defaultManager] handleOpenURL:url];
  if(!result){
    // 其他如支付等SDK的回调
  }
  return result;
}
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
//  BOOL result =[[UMSocialManager defaultManager] handleOpenURL:url];
//  if(!result){
//    // 其他如支付等SDK的回调
//  }
//  return result;
//}


@end
