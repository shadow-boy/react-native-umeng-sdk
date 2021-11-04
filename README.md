
# react-native-umeng-sdk
#### 基于 [react-native-umeng-sdk](https://npmjs.org/package/react-native-umeng-sdk) 修改部分原生依赖和原生代码

umeng for react-native,支持统计、分享、授权

## 安装

> `$ npm install react-native-umeng-sdk --save`

* react-native <0.60

> `$ react-native link react-native-umeng-sdk`

* react-native >=0.60

新版RN会自动link,不需要执行link命令

---
不管是哪个版本的react-native，ios端都需要在`ios`文件夹下执行
```shell
$ cd ios
$ pod install
```


## 配置
[配置.md](./配置.md)
## 使用

### 统计
```javascript
import {UAnalyticsModule, UShareModule} from 'react-native-umeng-sdk';

//必须要初始化，必须要初始化，必须要初始化
//建议在用户同意隐私协议后才进行初始化
//https://developer.umeng.com/docs/119267/detail/182050
//ios未实现，但是不用区分平台调用(会被直接忽略)
UAnalyticsModule.init();

//统计
UAnalyticsModule.onPageStart("HomeIndex");
...
```
---

### 分享
分享支持的平台(在[ShareMedias](./lib/UShareModule.ts)枚举中)

|值|平台名|
|---|---|
|QQ|QQ|
|SINA|新浪微博|
|WEIXIN|微信|
|WEIXIN_CIRCLE|微信朋友圈|
|WEIXIN_CIRCLE|微信朋友圈|
|QZONE|QQ空间|
|...|...|

分享支持的方式(在[ShareStyles](./lib/UShareModule.ts)枚举中)

|值|解释|对应ts定义 |
|---|---|---|
|LINK|网页链接（网页H5链接）|UMWeb|
|WEIXIN_MINI_PROGRAM|微信小程序|UMMini|
|QQ_MINI_PROGRAM|QQ小程序|UMMini|
|IMAGE|单图| UMImage|
|TEXT|纯文本|UMText|
|MULITI_IMAGE|多图（多图要包含文字描述）只支持android平台(ios没发现相关的api)的新浪微博和QQ空间，都是最多上传9张图片新浪微博超过9张不会上传,QQ控件超过9张会上传QQ控件相册|UMImage|
|VIDEO|视频|UMVideo|
|MUSIC|音乐|UMMusic|
|Emotion|表情（GIF图片，即Emotion类型，只有微信支持）(<font color=red>暂未实现</font>)|UMEmoji|


```javascript
import {UAnalyticsModule, UShareModule, ShareStyles, UMWeb} from 'react-native-umeng-sdk';

//分享(链接)
UShareModule.share(ShareStyles.LINK, {
  thumb: 'https://xxxxx.jpg',  //卡片图片链接地址
  title: '这是标题',  //标题
  description: '这是描述',  //描述
  shareMedias: [ShareMedias.WEIXIN],  //需要分享的平台,注意，是一个数组，只传一个，调用固定的平台，传多个，则调用分享面板
  //如果shareMedias大于1个平台，可以自定义分享面板
  shareBoardConfig: {
      
  }
} as UMWeb);  //如果使用typescript,第二个参数可以指定具体的类型

//分享(QQ小程序)
UShareModule.share(ShareStyles.QQ_MINI_PROGRAM, {
  thumb: 'https://xxxxx.jpg',  //小程序卡片的缩略图 
  miniAppId: 'gh_xxxxxxxxxxxx',  //小程序原始id,在微信平台查询
  url: '',  //若客户端版本低于6.5.6或在iPad客户端接收，小程序类型分享将自动转成网页类型分享。
  path: '/xxx/xxx/xxx',  //小程序页面路径
} as UMMini);  //如果使用typescript,第二个参数可以指定具体的类型
...
```
---

### 授权
```javascript
import {UAnalyticsModule, UShareModule, UMWeb} from 'react-native-umeng-sdk';

//授权
try {
    let response = await UShareModule.auth(ShareMedias.WEIXIN);
} catch (e) {
    
}
...
```
response的返回值可以在[UmengAuthResponse](./types/index.d.ts)

---

具体所有方法定义请查看: [index.d.ts](./types/index.d.ts)

## 注意事项&&疑问

