package com.zero.flutter_pangle_ads.page;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.qq.e.ads.cfg.VideoOption;
import com.qq.e.ads.interstitial2.UnifiedInterstitialAD;
import com.qq.e.ads.interstitial2.UnifiedInterstitialADListener;
import com.qq.e.comm.util.AdError;
import com.zero.flutter_pangle_ads.event.AdErrorEvent;
import com.zero.flutter_pangle_ads.event.AdEvent;
import com.zero.flutter_pangle_ads.event.AdEventAction;
import com.zero.flutter_pangle_ads.event.AdEventHandler;

import java.util.Locale;

import io.flutter.plugin.common.MethodCall;

/**
 * 插屏广告
 */
public class InterstitialPage extends BaseAdPage implements UnifiedInterstitialADListener {
    private final String TAG = InterstitialPage.class.getSimpleName();
    // 插屏广告
    private UnifiedInterstitialAD iad;
    // popup 形式展示
    private boolean showPopup = false;

    @Override
    public void loadAd(Activity activity, @NonNull MethodCall call) {
        showPopup = call.argument("showPopup");
        iad = new UnifiedInterstitialAD(activity, posId, this);
        setVideoOption(call);
        iad.loadAD();
    }


    /**
     * 设置视频参数
     */
    private void setVideoOption(@NonNull MethodCall call) {
        boolean autoPlayOnWifi = call.argument("autoPlayOnWifi");
        boolean autoPlayMuted = call.argument("autoPlayMuted");
        boolean detailPageMuted = call.argument("detailPageMuted");
        VideoOption.Builder builder = new VideoOption.Builder();
        VideoOption option = builder
                .setAutoPlayPolicy(autoPlayOnWifi ? 0 : 1)
                .setAutoPlayMuted(autoPlayMuted)
                .setDetailPageMuted(detailPageMuted)
                .build();
        iad.setVideoOption(option);

    }

    /**
     * 显示广告
     */
    private void show() {
        if (iad != null && iad.isValid()) {
            iad.show();
        } else {
            Log.d(TAG, "请加载广告并渲染成功后再进行展示 ！ ");
        }
    }

    /**
     * 以 Popup 形式显示广告
     */
    private void showAsPopup() {
        if (iad != null && iad.isValid()) {
            iad.showAsPopupWindow();
        } else {
            Log.d(TAG, "请加载广告并渲染成功后再进行展示 ！ ");
        }
    }

    @Override
    public void onADReceive() {
        Log.d(TAG, "onADReceive eCPMLevel = " + iad.getECPMLevel() + ", ECPM: " + iad.getECPM() + ", videoduration=" + iad.getVideoDuration());
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdLoaded));
    }

    @Override
    public void onVideoCached() {
        Log.i(TAG, "onVideoCached");
    }

    @Override
    public void onNoAD(AdError error) {
        String msg = String.format(Locale.getDefault(), "onNoAD, error code: %d, error msg: %s",
                error.getErrorCode(), error.getErrorMsg());
        Log.e(TAG, msg);
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(this.posId, error.getErrorCode(), error.getErrorMsg()));
    }

    @Override
    public void onADOpened() {
        Log.i(TAG, "onADOpened");
    }

    @Override
    public void onADExposure() {
        Log.i(TAG, "onADExposure");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdExposure));
    }

    @Override
    public void onADClicked() {
        Log.i(TAG, "onADClicked");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClicked));
    }

    @Override
    public void onADLeftApplication() {
        Log.i(TAG, "onADLeftApplication");
    }

    @Override
    public void onADClosed() {
        Log.i(TAG, "onADClosed");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClosed));
    }

    @Override
    public void onRenderSuccess() {
        Log.i(TAG, "onRenderSuccess，建议在此回调后再调用展示方法");
        if (showPopup) {
            showAsPopup();
        } else {
            show();
        }
    }

    @Override
    public void onRenderFail() {
        Log.i(TAG, "onRenderFail");
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(this.posId, -100, "onRenderFail"));
    }
}