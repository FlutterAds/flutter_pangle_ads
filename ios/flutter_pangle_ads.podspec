#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_pangle_ads.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_pangle_ads'
  s.version          = '2.2.0'
  s.summary          = '一款优质的 Flutter 广告插件（字节跳动、穿山甲）'
  s.description      = <<-DESC
FlutterAds 致力于构建优质的 Flutter 广告插件
                       DESC
  s.homepage         = 'https://github.com/FlutterAds'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ZeroFlutter' => '1300326388@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Ads-CN' #SDK版本 >=3.4.0.0
  s.platform = :ios, '9.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
