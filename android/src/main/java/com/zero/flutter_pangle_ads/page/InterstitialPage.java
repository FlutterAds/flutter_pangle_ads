package com.zero.flutter_pangle_ads.page;

import android.app.Activity;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;
import com.zero.flutter_pangle_ads.event.AdEventAction;

import java.util.List;

import io.flutter.plugin.common.MethodCall;

/**
 * 插屏广告
 */
public class InterstitialPage extends BaseAdPage implements TTAdNative.NativeExpressAdListener, TTNativeExpressAd.AdInteractionListener {
    private final String TAG = InterstitialPage.class.getSimpleName();
    // 渲染广告对象
    TTNativeExpressAd iad;

    @Override
    public void loadAd(Activity activity, @NonNull MethodCall call) {
        int expressViewWidth = call.argument("width");
        int expressViewHeight = call.argument("height");
        adSlot = new AdSlot.Builder()
                .setCodeId(posId)
                .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)
                .build();
        ad.loadInteractionExpressAd(adSlot, this);
    }

    @Override
    public void onError(int i, String s) {
        Log.e(TAG, "onError code:" + i + " msg:" + s);
        sendErrorEvent(i, s);
    }

    @Override
    public void onNativeExpressAdLoad(List<TTNativeExpressAd> list) {
        Log.i(TAG, "onRenderSuccess");
        if (list == null || list.size() == 0) {
            return;
        }
        iad = list.get(0);
        iad.setExpressInteractionListener(this);
        iad.render();
        // 添加广告事件
        sendEvent( AdEventAction.onAdLoaded);
    }


    @Override
    public void onAdClicked(View view, int i) {
        Log.i(TAG, "onAdClicked");
        // 添加广告事件
        sendEvent( AdEventAction.onAdClicked);
    }

    @Override
    public void onAdShow(View view, int i) {
        Log.i(TAG, "onAdShow");
        // 添加广告事件
        sendEvent( AdEventAction.onAdExposure);
    }

    @Override
    public void onRenderFail(View view, String s, int i) {
        Log.e(TAG, "onRenderFail code:" + i + " msg:" + s);
        // 添加广告错误事件
        sendErrorEvent(i, s);
    }

    @Override
    public void onRenderSuccess(View view, float v, float v1) {
        Log.i(TAG, "onRenderSuccess");
        if (iad != null && activity != null) {
            iad.showInteractionExpressAd(activity);
            // 添加广告事件
            sendEvent( AdEventAction.onAdPresent);
        }
    }

    @Override
    public void onAdDismiss() {
        Log.i(TAG, "onAdDismiss");
        // 添加广告事件
        sendEvent( AdEventAction.onAdClosed);
    }
}