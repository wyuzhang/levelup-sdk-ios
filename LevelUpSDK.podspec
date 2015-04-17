Pod::Spec.new do |s|
  s.name         = 'LevelUpSDK'
  s.version      = '1.8.3'
  s.summary      = 'An SDK for the LevelUp payment platform.'
  s.homepage     = 'http://developer.thelevelup.com'
  s.license      = 'Apache License, Version 2.0'
  s.author       = { 'LevelUp' => 'support@thelevelup.com' }
  s.source       = { :git => 'https://github.com/TheLevelUp/levelup-sdk-ios.git', :tag => "#{s.version}" }
  s.platform     = :ios, '7.0'
  s.frameworks   = 'AVFoundation', 'CoreBluetooth', 'CoreData', 'CoreGraphics', 'CoreLocation', 'CoreMedia', 'CoreTelephony', 'CoreVideo', 'ImageIO', 'MobileCoreServices', 'QuartzCore', 'Security', 'SystemConfiguration'
  s.weak_frameworks = 'PassKit'
  s.requires_arc = true
  s.prefix_header_file = 'Source/Resources/LevelUpSDK-Prefix.pch'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.dependency 'AFNetworking', '2.5.2'
    core.dependency 'AutoCoding', '2.0.3'
    core.dependency 'LUKeychainAccess', '1.2.3'
    core.dependency 'ZXingObjC/QRCode', '3.0.3'

    core.source_files = 'Source/*.{h,m}', 'Source/**/*.{h,m}'
    core.resources = 'Source/Resources/*'
  end

  s.subspec 'Testing' do |testing|
    testing.dependency 'OHHTTPStubs', '1.1.2'

    testing.source_files = 'Source/*.h', 'Source/**/*.h', 'Testing/LevelUpSDKTesting.h', 'Testing/**/*.{h,m}'
    testing.resources = 'Testing/Stubbing/Network-Responses/*'
  end
end
