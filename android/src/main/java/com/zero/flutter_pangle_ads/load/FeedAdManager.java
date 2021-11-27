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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 信息流广告管理
 */
public class FeedAdManager extends BaseAdPage implements TTAdNative.NativeExpressAdListener {
    private final String TAG = FeedAdManager.class.getSimpleName();
    // 信息流广告管理类对象
    private static FeedAdManager _instance;
    public static synchronized FeedAdManager getInstance() {
        if(_instance==null){
            synchronized (FeedAdManager.class){
                _instance=new FeedAdManager();
            }
        }
        return _instance;
    }
    // 返回对象
    private MethodChannel.Result result;
    // 信息流广告列表
    public Map<Integer, TTNativeExpressAd> feedAdList=new HashMap<Integer, TTNativeExpressAd>();

    /**
     * 加载信息流广告列表
     * @param call
     * @param result
     */
    public void loadFeedAdList(Activity activity, @NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        this.result=result;
        showAd(activity,call);
    }

    /**
     * 获取广告渲染对象
     * @param key 广告缓存id
     * @return 广告渲染对象
     */
    public TTNativeExpressAd getAd(int key){
        return feedAdList.get(key);
    }

    /**
     * 删除广告渲染对象
     * @param key 广告缓存id
     * @return 广告渲染对象
     */
    public TTNativeExpressAd removeAd(int key){
        return feedAdList.remove(key);
    }

    @Override
    public void loadAd(@NonNull MethodCall call) {
        // 获取请求模板广告素材的尺寸
        int expressViewWidth = call.argument("width");
        int expressViewHeight = call.argument("height");
        // 是否自动关闭
//        autoClose = call.argument("autoClose");
        adSlot = new AdSlot.Builder()
                .setCodeId(posId)
                .setAdCount(3)
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
            feedAdList.put(key,adItem);
        }
        // 添加广告事件
        sendEvent(AdEventAction.onAdLoaded);
        this.result.success(adResultList);
    }

}
