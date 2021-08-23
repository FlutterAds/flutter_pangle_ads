package com.zero.flutter_pangle_ads.event;

/**
 * 广告事件操作
 */
public class AdEventAction {
    // 广告错误
    public static final String onAdError="onAdError";
    // 广告加载成功
    public static final String onAdLoaded="onAdLoaded";
    // 广告填充
    public static final String onAdPresent="onAdPresent";
    // 广告曝光
    public static final String onAdExposure="onAdExposure";
    // 广告关闭（计时结束或者用户点击关闭）
    public static final String onAdClosed="onAdClosed";
    // 广告点击
    public static final String onAdClicked="onAdClicked";
    // 广告跳过
    public static final String onAdSkip="onAdSkip";
    // 广告播放或计时完毕
    public static final String onAdComplete="onAdComplete";
    // 获得广告激励
    public static final String onAdReward="onAdReward";
}
