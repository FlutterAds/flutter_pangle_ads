package com.zero.flutter_pangle_ads.event;

import java.util.HashMap;

/**
 * 广告激励事件
 */
public class AdRewardEvent extends AdEvent {

    // 奖励类型
    private final int rewardType;
    // 奖励是否有效
    private final boolean rewardVerify;
    // 奖励数量
    private final int rewardAmount;
    // 奖励名称
    private final String rewardName;
    // 错误码
    private final int errCode;
    // 错误信息
    private final String errMsg;
    // 自定义信息
    private final String customData;
    // 用户信息
    private final String userId;

    public AdRewardEvent(String adId, int rewardType,boolean rewardVerify, int rewardAmount, String rewardName, int errCode, String errMsg, String customData, String userId) {
        super(adId, AdEventAction.onAdReward);
        this.rewardType=rewardType;
        this.rewardVerify = rewardVerify;
        this.rewardAmount = rewardAmount;
        this.rewardName = rewardName;
        this.errCode = errCode;
        this.errMsg = errMsg;
        this.customData = customData;
        this.userId = userId;
    }

    @Override
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> newMap = super.toMap();
        newMap.put("rewardType", rewardType);
        newMap.put("rewardVerify", rewardVerify);
        newMap.put("rewardAmount", rewardAmount);
        newMap.put("rewardName", rewardName);
        newMap.put("errCode", errCode);
        newMap.put("errMsg", errMsg);
        newMap.put("customData", customData);
        newMap.put("userId", userId);
        return newMap;
    }
}
