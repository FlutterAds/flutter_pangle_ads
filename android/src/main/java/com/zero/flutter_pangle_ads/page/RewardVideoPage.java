package com.zero.flutter_pangle_ads.page;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.qq.e.ads.rewardvideo.RewardVideoAD;
import com.qq.e.ads.rewardvideo.RewardVideoADListener;
import com.qq.e.ads.rewardvideo.ServerSideVerificationOptions;
import com.qq.e.comm.util.AdError;
import com.zero.flutter_pangle_ads.event.AdErrorEvent;
import com.zero.flutter_pangle_ads.event.AdEvent;
import com.zero.flutter_pangle_ads.event.AdEventAction;
import com.zero.flutter_pangle_ads.event.AdEventHandler;
import com.zero.flutter_pangle_ads.event.AdRewardEvent;

import java.util.Locale;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;

/**
 * 激励视频页面
 */
public class RewardVideoPage extends BaseAdPage implements RewardVideoADListener {
    private static final String TAG = RewardVideoPage.class.getSimpleName();
    private RewardVideoAD rvad;
    // 设置激励视频服务端验证的自定义信息
    private String customData;
    // 设置服务端验证的用户信息
    private String userId;

    @Override
    public void loadAd(Activity activity, @NonNull MethodCall call) {
        boolean playMuted = call.argument("playMuted");
        customData = call.argument("customData");
        userId = call.argument("userId");
        // 1. 初始化激励视频广告
        rvad = new RewardVideoAD(activity, posId, this, !playMuted);
        // 设置服务端验证信息
        ServerSideVerificationOptions options = new ServerSideVerificationOptions.Builder()
                .setCustomData(customData)
                .setUserId(userId) // 设置服务端验证的用户信息
                .build();
        rvad.setServerSideVerificationOptions(options);
        // 2. 加载激励视频广告
        rvad.loadAD();
    }


    /**
     * 广告加载成功，可在此回调后进行广告展示
     **/
    @Override
    public void onADLoad() {
        Log.i(TAG, "onADLoad");
        if (rvad != null) {
            rvad.showAD();
        }
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdLoaded));
    }

    /**
     * 视频素材缓存成功，可在此回调后进行广告展示
     */
    @Override
    public void onVideoCached() {
        Log.i(TAG, "onVideoCached");
    }

    /**
     * 激励视频广告页面展示
     */
    @Override
    public void onADShow() {
        Log.i(TAG, "onADShow");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdPresent));
    }

    /**
     * 激励视频广告曝光
     */
    @Override
    public void onADExpose() {
        Log.i(TAG, "onADExpose");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdExposure));
    }

    /**
     * 激励视频触发激励（观看视频大于一定时长或者视频播放完毕）
     *
     * @param map 若选择了服务端验证，可以通过 ServerSideVerificationOptions#TRANS_ID 键从 map 中获取此次交易的 id；若未选择服务端验证，则不需关注 map 参数。
     */
    @Override
    public void onReward(Map<String, Object> map) {
        String transId = (String) map.get(ServerSideVerificationOptions.TRANS_ID);
        Log.i(TAG, "onReward " + transId);  // 获取服务端验证的唯一 ID
        AdEventHandler.getInstance().sendEvent(new AdRewardEvent(this.posId, AdEventAction.onAdReward, transId,customData,userId));
    }

    /**
     * 激励视频广告被点击
     */
    @Override
    public void onADClick() {
        Log.i(TAG, "onADClick");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClicked));
    }

    /**
     * 激励视频播放完毕
     */
    @Override
    public void onVideoComplete() {
        Log.i(TAG, "onVideoComplete");
    }

    /**
     * 激励视频广告被关闭
     */
    @Override
    public void onADClose() {
        Log.i(TAG, "onADClose");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClosed));
    }

    /**
     * 广告流程出错
     */
    @Override
    public void onError(AdError error) {
        String msg = String.format(Locale.getDefault(), "onError, error code: %d, error msg: %s",
                error.getErrorCode(), error.getErrorMsg());
        Log.i(TAG, "onError, adError=" + msg);
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(this.posId, error.getErrorCode(), error.getErrorMsg()));
    }
}
