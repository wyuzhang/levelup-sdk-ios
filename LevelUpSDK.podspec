Pod::Spec.new do |s|
  s.name         = 'LevelUpSDK'
  s.version      = '1.4.5'
  s.summary      = 'An SDK for the LevelUp payment platform.'
  s.homepage     = 'http://www.thelevelup.com'
  s.license      = {
    :type => 'Custom',
    :text => <<-LICENSE
              Copyright (C) 2012-2013 SCVNGR, Inc.

              All rights reserved.
    LICENSE
  }

  s.author       = { 'Costa Walcott' => 'costa@thelevelup.com' }
  s.source       = { :git => 'git@github.com:TheLevelUp/levelup-sdk-ios.git', :tag => "#{s.version}" }
  s.platform     = :ios, '6.0'
  s.frameworks   = 'AVFoundation', 'CoreData', 'CoreGraphics', 'CoreLocation', 'CoreMedia', 'CoreVideo', 'ImageIO', 'MobileCoreServices', 'QuartzCore', 'Security', 'SystemConfiguration'
  s.requires_arc = true
  s.prefix_header_file = 'Source/Resources/LevelUpSDK-Prefix.pch'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.dependency 'AFNetworking', '2.2.3'
    core.dependency 'AutoCoding', '2.0.3'
    core.dependency 'BTEncryption', '2.2.8'
    core.dependency 'LUKeychainAccess', '1.2.0'
    core.dependency 'ZXingObjC/QRCode', '3.0.0'

    core.source_files = 'Source/**/*.{h,m}'
    core.resources = 'Source/Resources/*'
  end

  s.subspec 'Testing' do |testing|
    testing.dependency 'OHHTTPStubs', '1.1.2'

    testing.source_files = 'Testing/LevelUpSDKTesting.h', 'Testing/**/*.{h,m}'
    testing.resources = 'Testing/Stubbing/Network-Responses/*.json'
  end
end
