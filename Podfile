source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '6.0'

pod 'AFNetworking', '2.4.1'
pod 'AutoCoding', '2.0.3'
pod 'BTEncryption', '2.2.8'
pod 'LUKeychainAccess', '1.2.3'
pod 'ZXingObjC/QRCode', '3.0.3'

target :test, :exclusive => true do
  link_with 'Tests'
  pod 'Kiwi', '2.3.0'
  pod 'OHHTTPStubs', '1.1.2'
end

post_install do |installer|
  environment_header = installer.config.sandbox.target_support_files_root + 'Pods/Pods-environment.h'
  text = "#import \"NamespacedDependencies.h\"\n\n" + environment_header.read
  environment_header.open('w') { |file| file.write(text) }

  dummy_class = installer.config.sandbox.target_support_files_root + 'Pods/Pods-dummy.m'
  text = "#import \"NamespacedDependencies.h\"\n\n" + dummy_class.read
  dummy_class.open('w') { |file| file.write(text) }

  File.write(installer.config.sandbox.target_support_files_root + 'Pods/NamespacedDependencies.h', '')
end
