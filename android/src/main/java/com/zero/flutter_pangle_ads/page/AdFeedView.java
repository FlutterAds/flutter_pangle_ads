package com.zero.flutter_pangle_ads.page;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdDislike;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTFeedAd;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;
import com.zero.flutter_pangle_ads.PluginDelegate;
import com.zero.flutter_pangle_ads.event.AdEventAction;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.platform.PlatformView;

/**
 * Feed 信息流广告 View
 */
class AdFeedView extends BaseAdPage implements PlatformView, TTAdNative.NativeExpressAdListener, TTNativeExpressAd.AdInteractionListener {
    private final String TAG = AdFeedView.class.getSimpleName();
    @NonNull
    private final FrameLayout frameLayout;
    private final PluginDelegate pluginDelegate;
    private int id;
    private TTNativeExpressAd fad;
    private boolean autoClose;


    AdFeedView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, PluginDelegate pluginDelegate) {
        this.id = id;
        this.pluginDelegate = pluginDelegate;
        frameLayout = new FrameLayout(context);
        MethodCall call = new MethodCall("AdFeedView", creationParams);
        showAd(this.pluginDelegate.activity, call);
    }

    @NonNull
    @Override
    public View getView() {
        return frameLayout;
    }

    @Override
    public void dispose() {
        disposeAd();
    }

    @Override
    public void loadAd(@NonNull MethodCall call) {
        // 获取请求模板广告素材的尺寸
        int expressViewWidth = call.argument("width");
        int expressViewHeight = call.argument("height");
        // 是否自动关闭
        autoClose = call.argument("autoClose");
        adSlot = new AdSlot.Builder()
                .setCodeId(posId)
                .setAdCount(1)
                .setSupportDeepLink(true)
                .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)
                .build();
        ad.loadNativeExpressAd(adSlot,this);
    }

    /**
     * 销毁广告
     */
    private void disposeAd() {
        frameLayout.removeAllViews();
        if (fad != null) {
            fad.destroy();
        }
    }


    @Override
    public void onError(int i, String s) {
        Log.e(TAG, "onError code:" + i + " msg:" + s);
        sendErrorEvent(i, s);
        disposeAd();
    }

    @Override
    public void onNativeExpressAdLoad(List<TTNativeExpressAd> list) {
        Log.i(TAG, "onRenderSuccess");
        if (list == null || list.size() == 0) {
            return;
        }
        fad = list.get(0);
        fad.setExpressInteractionListener(this);
        bindDislikeAction(fad);
        fad.render();
        // 添加广告事件
        sendEvent(AdEventAction.onAdLoaded);
    }

    @Override
    public void onAdDismiss() {
        Log.i(TAG, "onAdDismiss");
        // 添加广告事件
        sendEvent(AdEventAction.onAdClosed);
        // 点击如不感兴趣后，自动关闭
        if (autoClose) {
            disposeAd();
        }
    }

    @Override
    public void onAdClicked(View view, int i) {
        Log.i(TAG, "onAdClicked");
        // 添加广告事件
        sendEvent(AdEventAction.onAdClicked);
    }

    @Override
    public void onAdShow(View view, int i) {
        Log.i(TAG, "onAdShow");
        // 添加广告事件
        sendEvent(AdEventAction.onAdExposure);
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
        if (fad != null && activity != null) {
            frameLayout.addView(view);
            // 添加广告事件
            sendEvent(AdEventAction.onAdPresent);
        }
    }

    /**
     * 接入dislike 逻辑，有助于提示广告精准投放度
     * 和后续广告关闭逻辑处理
     *
     * @param ad 广告 View
     */
    private void bindDislikeAction(TTNativeExpressAd ad) {
        // 使用默认Dislike
        final TTAdDislike ttAdDislike = ad.getDislikeDialog(activity);
        if (ttAdDislike != null) {
            ttAdDislike.setDislikeInteractionCallback(new TTAdDislike.DislikeInteractionCallback() {
                @Override
                public void onShow() {

                }

                @Override
                public void onSelected(int position, String value, boolean enforce) {
                        onAdDismiss();
                }

                @Override
                public void onCancel() {

                }
            });
        }
    }


}