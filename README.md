<p align="center">
<a href="https://github.com/FlutterAds"><img src="https://raw.githubusercontent.com/FlutterAds/site/master/logo/flutterads_logo.png" alt="logo" height="180"/></a>
</p>
<h3 align="center">一款优质的 Flutter 广告插件（字节跳动、穿山甲）</h3>

<p align="center">
<a href="https://github.com/FlutterAds/flutter_pangle_ads"><img src=https://img.shields.io/badge/version-v1.0.0-success></a>
<a href="https://github.com/FlutterAds/flutter_pangle_ads"><img src=https://img.shields.io/badge/null_safety-v2.0.0-success></a>
<a href="https://github.com/FlutterAds/flutter_pangle_ads"><img src=https://img.shields.io/badge/platform-iOS%20%7C%20Android-brightgreen></a>
<a href="https://github.com/FlutterAds/flutter_pangle_ads"><img src=https://img.shields.io/github/stars/FlutterAds/flutter_pangle_ads?color=brightgreen></a>
<a href="https://github.com/FlutterAds/flutter_pangle_ads/blob/develop/LICENSE"><img src=https://img.shields.io/badge/license-MIT-brightgreen></a>
</p>

## 插件特点
- 🔨 接入简单快速（封装原生端配置，仅需引入即可开始）
- 📡 事件统一返回（将原生端各种重要回调事件统一返回，方便业务处理和埋点统计等需求）
- 🎁 注重优化体验（无闪烁 Logo 开屏、权限申请、隐私跟踪申请等）
- 🏆 极客代码封装（原生端代码不凑合，两端统一基础框架、广告事件封装抽象、易扩展新广告形式、方便开发个性化需求）

## 支持功能
- ✅ 开屏广告
- ✅ 插屏广告
  - ✅ 半插屏
  - 🔲 全屏视频（新插屏）
- ✅ 激励视频
- 🔲 Banner
- 🔲 信息流
- 🔲 全屏视频

## 入门使用

### 引入依赖

- 版本约定
  * 1.x.x 是非 Null Safety 版本，对应 master 分支
  * 2.x.x 是 Null Safety 版本，对应 2x 分支

  > 现在阶段会同时维护这 2 个版本，再往后可能仅维护一个空安全版本

- Pub 引入

``` Dart
dependencies:
  flutter_pangle_ads: ^1.0.0 # 非 Null Safety 版本
  flutter_pangle_ads: ^2.0.0 # Null Safety 版本
```

- Git 引入

``` Dart
flutter_pangle_ads:
  git: 
    url: git@github.com:FlutterAds/flutter_pangle_ads.git
    ref: master
```

- 克隆后本地引入

``` Dart
flutter_pangle_ads:
  path: [与主项目的相对路径 | 插件的绝对路径]
```

### 初始化广告

``` Dart
/// [appId] 应用ID
FlutterPangleAds.initAd(appId);
```
### 设置广告事件监听

``` Dart
FlutterPangleAds.onEventListener((event) {
  // 普通广告事件
  String _adEvent = 'adId:${event.adId} action:${event.action}';
  if (event is AdErrorEvent) {
    // 错误事件
    _adEvent += ' errCode:${event.errCode} errMsg:${event.errMsg}';
  } else if (event is AdRewardEvent) {
    // 激励事件
        _adEvent +=
            ' rewardVerify:${event.rewardVerify} rewardAmount:${event.rewardAmount} rewardName:${event.rewardName} errCode:${event.errCode} errMsg:${event.errMsg} customData:${event.customData} userId:${event.userId}';
  }
  print('onEventListener:$_adEvent');
});
```
### 开屏广告

- 半屏广告 + Logo

``` Dart
/// [posId] 广告位 id
/// [logo] 展示如果传递则展示底部logo，不传递不展示，则全屏
FlutterPangleAds.showSplashAd(posId, 'flutterads_logo');
```
- [Logo 设置的最佳实践](https://github.com/FlutterAds/flutter_qq_ads/blob/develop/doc/SETTING_LOGO.md)

- 全屏广告

``` Dart
FlutterQqAds.showSplashAd(posId);
```
### 显示插屏广告
``` Dart
/// [posId] 广告位 id
/// [width] 请求模板广告素材的尺寸宽度（对应 expressViewWidth 参数）
/// [height] 请求模板广告素材的尺寸高度（对应 expressViewWidth 参数）
FlutterPangleAds.showInterstitialAd(
    AdsConfig.interstitialId,
    width: 300,
    height: 300,
);
```

### 显示激励视频
``` Dart
/// [posId] 广告位 id
/// [customData] 设置服务端验证的自定义信息
/// [userId] 设置服务端验证的用户信息
FlutterPangleAds.showRewardVideoAd(
    AdsConfig.rewardVideoId,
    customData: 'customData',
    userId: 'userId',
);
```

## 其他配置
### 信任HTTP请求（仅 iOS）
苹果公司在iOS9中升级了应用网络通信安全策略，默认推荐开发者使用HTTPS协议来进行网络通信，并限制HTTP协议的请求。为了避免出现无法拉取到广告的情况，我们推荐开发者在info.plist文件中增加如下配置来实现广告的网络访问
- 修改 `info.plist`
``` xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```
![信任HTTP请求](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/02_AppTransportSecurity.png)

### 请求应用跟踪透明度授权（仅 iOS）
此步骤必须要做，不然上架审核时候会被拒绝
``` Dart
bool result = await FlutterPangleAds.requestIDFA;
```
- 修改 `info.plist`
``` xml
<key>NSUserTrackingUsageDescription</key>
<string>为了向您提供更优质、安全的个性化服务及内容，需要您允许使用相关权限</string>
```
![请求应用跟踪透明度授权](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/01_TrackingUsageDescription.png)

- 效果

![预览效果](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/03_RequestTracking.png)

- [官方参考链接 - 用户隐私和数据使用](https://developer.apple.com/cn/app-store/user-privacy-and-data-use/)

### 动态请求权限（仅 Android）

``` Dart
bool result = await FlutterPangleAds.requestPermissionIfNecessary;
```

## 分支说明
|分支|说明|
|-|-|
|develop|开发分支，接受 PR|
|master|稳定分支，非 Null Safety|
|2x|稳定分支，Null Safety|

## 遇到问题
如果你遇到问题请提 [Issues](https://github.com/FlutterAds/flutter_pangle_ads/issues) 给我（提问前建议先搜索尝试，没有再提问）

## 支持开源

支持开源项目最好的方式就是用 1 秒点个免费的 [Star](https://github.com/FlutterAds/flutter_pangle_ads)

## FlutterAds 系列插件

- [flutter_qq_ads 「腾讯广告、广点通、优量汇广告插件」](https://github.com/FlutterAds/flutter_qq_ads)
- [flutter_pangle_ads 「字节跳动、穿山甲广告插件」](https://github.com/FlutterAds/flutter_pangle_ads)
- flutter_baidu_ads 「百度、百青藤广告插件（开发中）」


