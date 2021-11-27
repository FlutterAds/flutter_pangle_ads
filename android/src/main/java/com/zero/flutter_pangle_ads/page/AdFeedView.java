package com.zero.flutter_pangle_ads.page;

import android.content.Context;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
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
import com.zero.flutter_pangle_ads.load.FeedAdManager;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.platform.PlatformView;

/**
 * Feed 信息流广告 View
 */
class AdFeedView extends BaseAdPage implements PlatformView,TTNativeExpressAd.AdInteractionListener {
    private final String TAG = AdFeedView.class.getSimpleName();
    @NonNull
    private final FrameLayout frameLayout;
    private final PluginDelegate pluginDelegate;
    private int id;
    private TTNativeExpressAd fad;


    AdFeedView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, PluginDelegate pluginDelegate) {
        this.id = id;
        this.pluginDelegate = pluginDelegate;
        frameLayout = new FrameLayout(context);
        FrameLayout.LayoutParams params=new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        frameLayout.setLayoutParams(params);
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
        removeAd();
    }

    @Override
    public void loadAd(@NonNull MethodCall call) {
        fad=FeedAdManager.getInstance().getAd(Integer.parseInt(this.posId));
        if(fad!=null){
            View adView= fad.getExpressAdView();
            if (adView.getParent()!=null){
                ((ViewGroup)adView.getParent()).removeAllViews();
            }
            frameLayout.removeAllViews();
            FrameLayout.LayoutParams params=new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            frameLayout.addView(adView,params);
            fad.setExpressInteractionListener(this);
            bindDislikeAction(fad);
            fad.render();
        }
    }

    /**
     * 移除广告
     */
    private void removeAd() {
        frameLayout.removeAllViews();
    }

    /**
     * 销毁广告
     */
    private void disposeAd() {
        removeAd();
        FeedAdManager.getInstance().removeAd(Integer.parseInt(this.posId));
        if(fad!=null){
            fad.destroy();
        }
    }

    @Override
    public void onAdDismiss() {
        Log.i(TAG, "onAdDismiss");
        // 添加广告事件
        sendEvent(AdEventAction.onAdClosed);
        disposeAd();
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
        Log.i(TAG, "onRenderSuccess v:"+v +" v1:"+v1);
        if (fad != null) {
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