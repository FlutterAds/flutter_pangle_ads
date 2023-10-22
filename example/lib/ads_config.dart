import 'dart:io';

/// 广告配置信息
class AdsConfig {
  /// 获取 Logo 资源名称
  static String get logo {
    if (Platform.isAndroid) {
      return 'flutterads_logo';
    } else {
      return 'LaunchImage';
    }
  }

  /// 获取 Logo 资源名称 2
  static String get logo2 {
    if (Platform.isAndroid) {
      return 'flutterads_logo2';
    } else {
      return 'LaunchImage2';
    }
  }

  /// 获取 App id
  static String get appId => '5324024';

  /// 获取开屏广告位id
  static String get splashId => '887870893';

  /// 获取新插屏广告位id
  static String get newInterstitialId => '949641653';

  /// 获取新插屏（半屏）广告位id
  static String get newInterstitialId2 => '949641665';

  /// 获取激励视频广告位id
  static String get rewardVideoId => '949641706';

  /// 获取进阶激励视频广告位id
  static String get rewardInteractVideoId => '949641720';

  /// 获取全屏视频广告位id
  static String get fullScreenVideoId => '946593099';

  /// 获取 Banner 广告位id
  static String get bannerId => '949641731';

  /// 获取 Banner 广告位id 01
  static String get bannerId01 => '949641733';

  /// 获取 Banner 广告位id 02
  static String get bannerId02 => '949641736';

  /// 获取 Feed 信息流广告位id(左右图文 2.4)
  static String get feedId => '949641744';
}
