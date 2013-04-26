Pod::Spec.new do |s|
  s.name         = 'LevelUpSDK'
  s.version      = '0.6.5'
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
  s.source       = { :git => 'git@github.com:TheLevelUp/whitelabel-ios-sdk.git', :tag => '0.6.5' }
  s.platform     = :ios, '5.0'
  s.source_files = 'LevelUpSDK/**/*.{h,m}', 'Frameworks/Braintree-Encryption/src'
  s.frameworks   = 'AVFoundation', 'CoreGraphics', 'CoreLocation', 'CoreMedia', 'CoreVideo', 'ImageIO', 'MobileCoreServices', 'QuartzCore', 'Security', 'SystemConfiguration'
  s.requires_arc = true

  s.dependency 'AFNetworking', '~> 1.1.0'
  s.dependency 'LUKeychainAccess', '~> 1.0.0'
  s.dependency 'ZXingObjC', '~> 2.0.2'
end
