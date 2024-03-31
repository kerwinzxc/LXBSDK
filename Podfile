# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'BLSDK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'MJExtension'
  pod 'AFNetworking'
  pod 'YYCache'
  pod 'CocoaLumberjack'
  pod 'MMKV'
  pod 'MyLayout'
  
  # google 广告
  pod 'Google-Mobile-Ads-SDK'
  pod 'GoogleUserMessagingPlatform'
  
  # 谷歌登录
  pod 'GoogleSignIn'
  # Facebook 登录
  pod 'FBSDKLoginKit', '14.1.0'
  
  pod 'SVProgressHUD'
  
  pod 'Adjust'
  
  pod 'FirebaseAnalytics'
  
  pod 'FirebaseCrashlytics'
  
  pod 'ThinkingSDK'
  # Pods for BLSDK

end

target 'BLSDKDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for BLSDKDemo
  pod 'MJExtension'
  pod 'AFNetworking'
  pod 'YYCache'
  pod 'CocoaLumberjack'
  pod 'MMKV'
  pod 'MyLayout'
  
  # google 广告
  pod 'Google-Mobile-Ads-SDK'
  pod 'GoogleUserMessagingPlatform'
  
  # 谷歌登录
  pod 'GoogleSignIn'
  # Facebook 登录
  pod 'FBSDKLoginKit', '14.1.0'
  
  pod 'SVProgressHUD'
  
  pod 'Adjust'
  
  pod 'FirebaseAnalytics'
  
  pod 'FirebaseCrashlytics'
  
  pod 'ThinkingSDK'
end

post_install do |installer|
  installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          end
      end
  end
end
