package com.zero.flutter_pangle_ads.load;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;
import com.zero.flutter_pangle_ads.event.AdEventAction;
import com.zero.flutter_pangle_ads.page.BaseAdPage;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 信息流加载对象
 */
public class AdFeedLoad extends BaseAdPage implements TTAdNative.NativeExpressAdListener {
    private final String TAG = FeedAdManager.class.getSimpleName();
    private MethodChannel.Result result;

    /**
     * 加载信息流广告列表
     * @param call
     * @param result
     */
    public void loadFeedAdList(Activity activity, @NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        this.result=result;
        showAd(activity,call);
    }

    @Override
    public void loadAd(@NonNull MethodCall call) {
        // 获取请求模板广告素材的尺寸
        int expressViewWidth = call.argument("width");
        int expressViewHeight = call.argument("height");
        int count = call.argument("count");
        adSlot = new AdSlot.Builder()
                .setCodeId(posId)
                .setAdCount(count)
                .setSupportDeepLink(true)
                .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)
                .build();
        ad.loadNativeExpressAd(adSlot,this);
    }

    @Override
    public void onError(int i, String s) {
        Log.e(TAG, "onError code:" + i + " msg:" + s);
        sendErrorEvent(i, s);
        this.result.error(""+i,s,s);
    }


    @Override
    public void onNativeExpressAdLoad(List<TTNativeExpressAd> list) {
        List<Integer> adResultList=new ArrayList<>();
        Log.i(TAG, "onNativeExpressAdLoad");
        if (list == null || list.size() == 0) {
            this.result.success(adResultList);
            return;
        }
        for (TTNativeExpressAd adItem : list) {
            int key=adItem.hashCode();
            adResultList.add(key);
            FeedAdManager.getInstance().put(key,adItem);
        }
        // 添加广告事件
        sendEvent(AdEventAction.onAdLoaded);
        this.result.success(adResultList);
    }
}
