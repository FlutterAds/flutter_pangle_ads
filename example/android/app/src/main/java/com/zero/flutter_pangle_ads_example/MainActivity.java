package com.zero.flutter_pangle_ads_example;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.zero.flutter_pangle_ads.utils.StatusBarUtils;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        StatusBarUtils.setTranslucent(this);
    }
}
