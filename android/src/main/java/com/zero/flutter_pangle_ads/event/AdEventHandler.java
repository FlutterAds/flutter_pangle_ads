package com.zero.flutter_pangle_ads.event;

import com.zero.flutter_pangle_ads.PluginDelegate;

/**
 * 广告事件处理类
 */
public class AdEventHandler {
    // 广告事件处理对象
    private static volatile AdEventHandler _instance;

    /**
     * 获取广告事件处理类
     *
     * @return 广告事件处理对象
     */
    public static AdEventHandler getInstance() {
        if (_instance == null) {
            synchronized (AdEventHandler.class) {
                _instance = new AdEventHandler();
            }
        }
        return _instance;
    }

    /**
     * 添加广告事件
     *
     * @param event 广告事件
     */
    public void sendEvent(AdEvent event) {
        if (event != null) {
            PluginDelegate.getInstance().addEvent(event.toMap());
        }
    }

}
