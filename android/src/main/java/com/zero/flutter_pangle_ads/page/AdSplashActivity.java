package com.zero.flutter_pangle_ads.page;

import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.FrameLayout;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatImageView;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTSplashAd;
import com.zero.flutter_pangle_ads.PluginDelegate;
import com.zero.flutter_pangle_ads.R;
import com.zero.flutter_pangle_ads.event.AdErrorEvent;
import com.zero.flutter_pangle_ads.event.AdEvent;
import com.zero.flutter_pangle_ads.event.AdEventAction;
import com.zero.flutter_pangle_ads.event.AdEventHandler;

/**
 * 开屏广告
 */
public class AdSplashActivity extends AppCompatActivity implements TTAdNative.SplashAdListener, TTSplashAd.AdInteractionListener {
    private final String TAG = AdSplashActivity.class.getSimpleName();
    // 广告容器
    private FrameLayout ad_container;
    // 自定义品牌 logo
    private AppCompatImageView ad_logo;
    // 广告位 id
    private String posId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ad_splash);
        initView();
        initData();
    }

    /**
     * 初始化View
     */
    private void initView() {
        ad_container = findViewById(R.id.splash_ad_container);
        ad_logo = findViewById(R.id.splash_ad_logo);
    }

    /**
     * 初始化数据
     */
    private void initData() {
        // 获取参数
        posId = getIntent().getStringExtra(PluginDelegate.KEY_POSID);
        String logo = getIntent().getStringExtra(PluginDelegate.KEY_LOGO);
        // 判断是否有 Logo
        boolean hasLogo = !TextUtils.isEmpty(logo);
        if (hasLogo) {
            // 加载 logo
            int resId = getMipmapId(logo);
            hasLogo = resId > 0;
            if (hasLogo) {
                ad_logo.setVisibility(View.VISIBLE);
                ad_logo.setImageResource(resId);
            } else {
                Log.e(TAG, "Logo 名称不匹配或不在 mipmap 文件夹下，展示全屏");
            }
        }
        // 判断最终的 Logo 是否显示
        if (!hasLogo) {
            ad_logo.setVisibility(View.GONE);
        }

        // 创建开屏广告
        TTAdNative splashAD = TTAdSdk.getAdManager().createAdNative(this);
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(posId)
//                .setExpressViewAcceptedSize(1080, 1920)
                .setImageAcceptedSize(1080,1920)
                .build();
        // 加载广告
        splashAD.loadSplashAd(adSlot, this);
    }

    /**
     * 完成广告，退出开屏页面
     */
    private void finishPage() {
        finish();
        // 设置退出动画
        overridePendingTransition(0, android.R.anim.fade_out);
    }

    /**
     * 开屏页一定要禁止用户对返回按钮的控制，否则将可能导致用户手动退出了App而广告无法正常曝光和计费
     */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK || keyCode == KeyEvent.KEYCODE_HOME) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    /**
     * 获取图片资源的id
     *
     * @param resName 资源名称，不带后缀
     * @return 返回资源id
     */
    private int getMipmapId(String resName) {
        return getResources().getIdentifier(resName, "mipmap", getPackageName());
    }

    @Override
    public void onError(int i, String s) {
        Log.d(TAG, "onError code:" + i + " msg:" + s);
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(this.posId, i, s));
        finishPage();
    }

    @Override
    public void onTimeout() {
        Log.d(TAG, "onTimeout");
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(this.posId, -100, "loadSplashAd onTimeout"));
        finishPage();
    }

    @Override
    public void onSplashAdLoad(TTSplashAd ad) {
        Log.d(TAG, "onSplashAdLoad");
        //获取SplashView
        View view = ad.getSplashView();
        if (!this.isFinishing()) {
            ad_container.removeAllViews();
            ad_container.addView(view);
        } else {
            finishPage();
        }
        // 设置交互监听
        ad.setSplashInteractionListener(this);
        // 加载事件
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdLoaded));
    }

    @Override
    public void onAdClicked(View view, int i) {
        Log.d(TAG, "onAdClicked");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClicked));
    }

    @Override
    public void onAdShow(View view, int i) {
        Log.d(TAG, "onAdShow");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdExposure));
    }

    @Override
    public void onAdSkip() {
        Log.d(TAG, "onAdSkip");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdSkip));
        finishPage();
    }

    @Override
    public void onAdTimeOver() {
        Log.d(TAG, "onAdTimeOver");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdComplete));
        finishPage();
    }
}