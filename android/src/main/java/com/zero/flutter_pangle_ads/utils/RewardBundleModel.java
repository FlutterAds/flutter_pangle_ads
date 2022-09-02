package com.zero.flutter_pangle_ads.utils;

import android.os.Bundle;

import com.bytedance.sdk.openadsdk.TTRewardVideoAd;

/**
 * Created by zero
 * Usage: 激励视频奖励回调额外参数
 */
public class RewardBundleModel {

    private int mServerErrorCode;
    private String mServerErrorMsg;
    private String mRewardName;
    private int mRewardAmount;
    private float mRewardPropose;

    public RewardBundleModel(Bundle extraInfo) {

        mServerErrorCode = extraInfo.getInt(TTRewardVideoAd.REWARD_EXTRA_KEY_ERROR_CODE);

        mServerErrorMsg = extraInfo.getString(TTRewardVideoAd.REWARD_EXTRA_KEY_ERROR_MSG);

        mRewardName = extraInfo.getString(TTRewardVideoAd.REWARD_EXTRA_KEY_REWARD_NAME);

        mRewardAmount = extraInfo.getInt(TTRewardVideoAd.REWARD_EXTRA_KEY_REWARD_AMOUNT);

        mRewardPropose = extraInfo.getFloat(TTRewardVideoAd.REWARD_EXTRA_KEY_REWARD_PROPOSE);
    }

    /**
     * 获得服务器验证的错误码
     */
    public int getServerErrorCode() {
        return mServerErrorCode;
    }
    /**
     * 获得服务器验证的错误信息
     */
    public String getServerErrorMsg() {
        return mServerErrorMsg;
    }
    /**
     * 获得开发者平台配置的奖励名称
     */
    public String getRewardName() {
        return mRewardName;
    }
    /**
     * 获得开发者平台配置的奖励数量
     */
    public int getRewardAmount() {
        return mRewardAmount;
    }

    /**
     * 获得此次奖励建议发放的奖励比例
     */
    public float getRewardPropose() {
        return mRewardPropose;
    }
}
