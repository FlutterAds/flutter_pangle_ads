package com.zero.flutter_pangle_ads.page;

import android.util.Log;

import androidx.annotation.NonNull;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTFullScreenVideoAd;
import com.zero.flutter_pangle_ads.event.AdEventAction;

import io.flutter.plugin.common.MethodCall;

/**
 * 全屏视频页面
 */
public class FullScreenVideoPage extends BaseAdPage implements TTAdNative.FullScreenVideoAdListener, TTFullScreenVideoAd.FullScreenVideoAdInteractionListener {
    private static final String TAG = FullScreenVideoPage.class.getSimpleName();

    @Override
    public void loadAd(@NonNull MethodCall call) {
        // 配置广告
        adSlot = new AdSlot.Builder()
                .setCodeId(posId)
                .setExpressViewAcceptedSize(500, 500)
                .setSupportDeepLink(true)
                .build();
        // 加载广告
        ad.loadFullScreenVideoAd(adSlot, this);
    }

    @Override
    public void onError(int i, String s) {
        Log.e(TAG, "onError code:" + i + " msg:" + s);
        // 添加广告错误事件
        sendErrorEvent(i, s);
    }

    @Override
    public void onFullScreenVideoAdLoad(TTFullScreenVideoAd ttFullScreenVideoAd) {
        Log.i(TAG, "onFullScreenVideoAdLoad");
        ttFullScreenVideoAd.setFullScreenVideoAdInteractionListener(this);
        // 添加广告事件
        sendEvent(AdEventAction.onAdLoaded);
    }

    @Override
    public void onFullScreenVideoCached() {
        Log.i(TAG, "onFullScreenVideoCached");
    }

    @Override
    public void onFullScreenVideoCached(TTFullScreenVideoAd ttFullScreenVideoAd) {
        Log.i(TAG, "onFullScreenVideoCached ttFullScreenVideoAd");
        ttFullScreenVideoAd.showFullScreenVideoAd(activity);
        // 添加广告事件
        sendEvent(AdEventAction.onAdPresent);
    }

    @Override
    public void onAdShow() {
        Log.i(TAG, "onAdShow");
        // 添加广告事件
        sendEvent(AdEventAction.onAdExposure);
    }

    @Override
    public void onAdVideoBarClick() {
        Log.i(TAG, "onAdVideoBarClick");
        // 添加广告事件
        sendEvent(AdEventAction.onAdClicked);
    }

    @Override
    public void onAdClose() {
        Log.i(TAG, "onAdClose");
        // 添加广告事件
        sendEvent(AdEventAction.onAdClosed);
    }

    @Override
    public void onVideoComplete() {
        Log.i(TAG, "onVideoComplete");
        // 添加广告事件
        sendEvent(AdEventAction.onAdComplete);
    }

    @Override
    public void onSkippedVideo() {
        Log.i(TAG, "onSkippedVideo");
        // 添加广告事件
        sendEvent(AdEventAction.onAdSkip);
    }
}
