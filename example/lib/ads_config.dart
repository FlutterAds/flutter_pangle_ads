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
  static String get appId => '5195673';

  /// 获取开屏广告位id
  static String get splashId => '887516177';

  /// 获取插屏广告位id
  static String get interstitialId => '946584889';

  /// 获取新插屏广告位id
  static String get newInterstitialId => '946584893';

  /// 获取新插屏（半屏）广告位id
  static String get newInterstitialId2 => '946601932';

  /// 获取激励视频广告位id
  static String get rewardVideoId => '946584890';

  /// 获取全屏视频广告位id
  static String get fullScreenVideoId => '946593099';

  /// 获取 Banner 广告位id
  static String get bannerId => '946651948';

  /// 获取 Banner 广告位id 01
  static String get bannerId01 => '946651966';

  /// 获取 Banner 广告位id 02
  static String get bannerId02 => '946651971';

  /// 获取 Feed 信息流列表
  static List<String> get feedIdList =>
      [feedId01, feedId02, feedId03, feedId04, feedId05];

  /// 获取 Feed 信息流广告位id(左右图文 2.4)
  static String get feedId01 => '947186177';

  /// 获取 Feed 信息流广告位id(上下文图0.9)
  static String get feedId02 => '947186943';

  /// 获取 Feed 信息流广告位id(三图2)
  static String get feedId03 => '947186944';

  /// 获取 Feed 信息流广告位id(文字悬浮1)
  static String get feedId04 => '947186945';

  /// 获取 Feed 信息流广告位id(竖版0.5)
  static String get feedId05 => '947186946';
}
