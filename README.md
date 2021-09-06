<p align="center">
<a href="https://github.com/FlutterAds"><img src="https://raw.githubusercontent.com/FlutterAds/site/master/logo/flutterads_logo.png" alt="logo" height="180"/></a>
</p>
<h3 align="center">一款优质的 Flutter 广告插件（字节跳动、穿山甲）</h3>

<p align="center">
<a href="https://github.com/FlutterAds/flutter_pangle_ads"><img src=https://img.shields.io/badge/version-v1.2.0-success></a>
<a href="https://github.com/FlutterAds/flutter_pangle_ads"><img src=https://img.shields.io/badge/null_safety-v2.2.0-success></a>
<a href="https://github.com/FlutterAds/flutter_pangle_ads"><img src=https://img.shields.io/badge/platform-iOS%20%7C%20Android-brightgreen></a>
<a href="https://github.com/FlutterAds/flutter_pangle_ads/actions/workflows/flutter.yml"><img src="https://github.com/FlutterAds/flutter_pangle_ads/actions/workflows/flutter.yml/badge.svg?branch=develop"></a>
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
  - ✅ 全屏视频（新插屏）
- ✅ 激励视频
- ✅ 全屏视频
- ✅ Banner
- 🔲 信息流

## 下载体验
<a href="https://www.pgyer.com/app/qrcode/fads"><img src="https://www.pgyer.com/app/qrcode/fads" width='100' height='100'></a>

## 入门使用

### 引入依赖

``` Dart
dependencies:
  flutter_pangle_ads: ^1.2.0 # 非 Null Safety 版本
  flutter_pangle_ads: ^2.2.0 # Null Safety 版本
```
### 初始化广告

``` Dart
// 导包
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
/// [appId] 应用ID
FlutterPangleAds.initAd(appId);
```

### 开屏广告

- 半屏广告 + Logo
- [Logo 设置的最佳实践](https://github.com/FlutterAds/flutter_qq_ads/blob/develop/doc/SETTING_LOGO.md)

``` Dart
/// [posId] 广告位 id
/// [logo] 如果传值则展示底部logo，不传不展示，则全屏展示
/// [timeout] 加载超时时间
FlutterPangleAds.showSplashAd(
  posId,
  logo: 'flutterads_logo',
  timeout: 3.5,
);
```

- 全屏广告

``` Dart
FlutterQqAds.showSplashAd(posId);
```
### 插屏广告
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

### 激励视频
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

### 全屏视频
- 全屏视频
- 新插屏
``` Dart
/// [posId] 广告位 id
FlutterPangleAds.showRewardVideoAd(AdsConfig.fullScreenVideoId);
```


### Banner
``` Dart
/// [posId] 广告位 id
/// [width] 创建 Banner 广告位时选择的宽度，默认值是 300
/// [height] 创建 Banner 广告位时选择的高度，默认值是 150
/// [interval] 广告轮播间隔，0 或[30~120]之间的数字，单位为 s,默认为 0 不轮播
/// [show] 是否显示广告
AdBannerWidget(
  posId: AdsConfig.bannerId,
  width: 300,
  height: 150,
  interval: 30,
  show: true,
);
```

Banner 广告外部需要嵌套一个带有约束布局的 Widget，如：`AspectRatio、SizedBox、Container` 等，示例如下：

- 嵌套 `SizedBox` (推荐)

``` Dart
SizedBox(
  width: 300,
  height: 150,
  child: AdBannerWidget(
    posId: AdsConfig.bannerId,
    width: 300,
    height: 150,
    interval: 30,
    show: true,
  ),
)
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
### 事件列表
|事件|说明|
|-|-|
|onAdLoaded|广告加载成功|
|onAdPresent|广告填充|
|onAdExposure|广告曝光|
|onAdClosed|广告关闭（开屏计时结束或者用户点击关闭）|
|onAdClicked|广告点击|
|onAdSkip|广告跳过|
|onAdComplete|广告播放或计时完毕|
|onAdError|广告错误|
|onAdReward|获得广告激励|

> 这里做了统一的抽象，iOS 和 Android 原生 SDK 名称不同，如果觉得对应不上，可以提 [Issues](https://github.com/FlutterAds/flutter_pangle_ads/issues)（一定要加上 log 截图）

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

## 原生 SDK 版本更新方法
如果是大版本，我会第一时间适配更新，小版本可以自己更新，方法如下：
- Android

  方法1：可以给我提 Issues 提示我更新，此插件版本号 `x.y.z`，会更新 `z` 版本迭代
  
  方法2：可以自己指定版本，方法如下:
```shell
// build.gradle(android.app)
android{
  configurations.all {
      resolutionStrategy {
          force 'com.pangle.cn:ads-sdk:版本号'
      }
  }
}
```
- iOS

  自己手动更新，自己的项目根目录下执行即可
```shell
// 可在 ios/Podfile.lock 中查看 SDK 当前版本
cd ios
rm -rf Podfile.lock
pod repo update
pod install
```

## 分支说明
|分支|说明|
|-|-|
|develop|开发分支，接受 PR|
|master|稳定分支，非 Null Safety|
|2x|稳定分支，Null Safety|

## 更新日志
[查看 Releases 版本日志](https://github.com/FlutterAds/flutter_pangle_ads/releases)

## 遇到问题
如果你遇到问题请提 [Issues](https://github.com/FlutterAds/flutter_pangle_ads/issues) 给我（提问前建议先搜索尝试，没有再提问）

## 支持开源

支持开源项目最好的方式就是点个免费的 [Star](https://github.com/FlutterAds/flutter_pangle_ads)

## FlutterAds 广告插件系列
|插件|描述|
|-|-|
|[flutter_qq_ads](https://github.com/FlutterAds/flutter_qq_ads)|腾讯广告、广点通、优量汇 Flutter 广告插件|
|[flutter_pangle_ads](https://github.com/FlutterAds/flutter_pangle_ads)|字节跳动、穿山甲 Flutter 广告插件|
|flutter_baidu_ads|百度、百青藤 Flutter 广告插件（开发中）|


