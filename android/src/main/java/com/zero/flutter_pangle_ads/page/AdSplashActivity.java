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
import com.bytedance.sdk.openadsdk.CSJAdError;
import com.bytedance.sdk.openadsdk.CSJSplashAd;
import com.bytedance.sdk.openadsdk.TTAdLoadType;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.zero.flutter_pangle_ads.PluginDelegate;
import com.zero.flutter_pangle_ads.R;
import com.zero.flutter_pangle_ads.event.AdErrorEvent;
import com.zero.flutter_pangle_ads.event.AdEvent;
import com.zero.flutter_pangle_ads.event.AdEventAction;
import com.zero.flutter_pangle_ads.event.AdEventHandler;
import com.zero.flutter_pangle_ads.utils.StatusBarUtils;
import com.zero.flutter_pangle_ads.utils.UIUtils;

/**
 * 开屏广告
 */
public class AdSplashActivity extends AppCompatActivity implements TTAdNative.CSJSplashAdListener, CSJSplashAd.SplashAdListener {
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
        UIUtils.hideBottomUIMenu(this);
        StatusBarUtils.setTranslucent(this);
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
        double timeout = getIntent().getDoubleExtra(PluginDelegate.KEY_TIMEOUT, 3.5);
        int absTimeout = (int) (timeout * 1000);
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
        int width = (int) UIUtils.getScreenWidthInPx(this);
        int widthDp = (int) UIUtils.getScreenWidthDp(this);
        int height = (int) UIUtils.getScreenHeightInPx(this);
        // 判断最终的 Logo 是否显示
        if (!hasLogo) {
            ad_logo.setVisibility(View.GONE);
        } else {
            // 显示 Logo 高度去掉 Logo 的高度
            height = height - ad_logo.getLayoutParams().height;
        }
        // 创建开屏广告
        TTAdNative splashAD = TTAdSdk.getAdManager().createAdNative(this);
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(posId)
                .setSupportDeepLink(true)
                .setImageAcceptedSize(width, height) // 单位是px
                .setExpressViewAcceptedSize(widthDp, UIUtils.px2dip(this,height)) // 单位是dp
                .setAdLoadType(TTAdLoadType.LOAD)
                .build();
        // 加载广告
        splashAD.loadSplashAd(adSlot,this,absTimeout);
    }

    /**
     * 完成广告，退出开屏页面
     */
    private void finishPage() {
        finish();
        // 设置退出动画
        overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
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
    public void onSplashLoadSuccess() {
        Log.d(TAG, "onSplashLoadSuccess");
        // 加载事件
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdLoaded));
    }

    @Override
    public void onSplashLoadFail(CSJAdError error) {
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(this.posId, error.getCode(), error.getMsg()));
        finishPage();
    }

    @Override
    public void onSplashRenderSuccess(CSJSplashAd csjSplashAd) {
        Log.d(TAG, "onSplashAdLoad");
        if (this.isFinishing()) {
            AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClosed));
            finishPage();
        } else {
            csjSplashAd.showSplashView(ad_container);
            // 设置交互监听
            csjSplashAd.setSplashAdListener(this);
            // 加载事件
            AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdPresent));
        }

    }

    @Override
    public void onSplashRenderFail(CSJSplashAd csjSplashAd, CSJAdError error) {
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(this.posId, error.getCode(), error.getMsg()));
        finishPage();
    }

    @Override
    public void onSplashAdShow(CSJSplashAd csjSplashAd) {
        Log.d(TAG, "onSplashLoadSuccess");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdExposure));
    }

    @Override
    public void onSplashAdClick(CSJSplashAd csjSplashAd) {
        Log.d(TAG, "onSplashAdClick");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClicked));
        finishPage();
    }

    @Override
    public void onSplashAdClose(CSJSplashAd csjSplashAd, int i) {
        Log.d(TAG, "onSplashAdClose");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClosed));
        finishPage();
    }
}