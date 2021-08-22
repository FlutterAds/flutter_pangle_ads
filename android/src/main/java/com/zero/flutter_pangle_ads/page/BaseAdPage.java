package com.zero.flutter_pangle_ads.page;

import android.app.Activity;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;

/**
 * 基础广告页面
 */
public abstract class BaseAdPage {
    // 广告位 id
    protected String posId;

    /**
     * 显示广告
     *
     * @param activity 上下文
     * @param posId    广告位 id
     * @param call     方法调用
     */
    public void showAd(Activity activity, String posId, @NonNull MethodCall call) {
        this.posId = posId;
        loadAd(activity, call);
    }

    /**
     * 加载广告
     *
     * @param activity 上下文
     * @param call     方法调用
     */
    public abstract void loadAd(Activity activity,@NonNull  MethodCall call);
}
