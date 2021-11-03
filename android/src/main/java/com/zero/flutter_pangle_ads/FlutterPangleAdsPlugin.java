package com.zero.flutter_pangle_ads;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterPangleAdsPlugin
 */
public class FlutterPangleAdsPlugin implements FlutterPlugin, ActivityAware {

    // 方法通道
    private MethodChannel methodChannel;
    // 事件通道
    private EventChannel eventChannel;
    // 插件代理
    private PluginDelegate delegate;
    // 插件连接器
    private FlutterPluginBinding bind;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        bind = flutterPluginBinding;
        // 初始化方法通道和事件通道
        methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_pangle_ads");
        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_pangle_ads_event");
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        // 解除方法通道和事件通道
        methodChannel.setMethodCallHandler(null);
        eventChannel.setStreamHandler(null);
    }


    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.delegate = new PluginDelegate(binding.getActivity(), bind);
        methodChannel.setMethodCallHandler(delegate);
        eventChannel.setStreamHandler(delegate);
        this.delegate.registerBannerView();
        this.delegate.registerFeedView();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }


    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }


    @Override
    public void onDetachedFromActivity() {
        this.delegate = null;
    }
}
