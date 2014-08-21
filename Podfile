platform :ios, '6.0'

pod 'AFNetworking', '2.3.1'
pod 'AutoCoding', '2.0.3'
pod 'BTEncryption', '2.2.8'
pod 'LUKeychainAccess', '1.2.1'
pod 'ZXingObjC/QRCode', '3.0.0'

target :test, :exclusive => true do
  link_with 'Tests'
  pod 'Kiwi', '2.2.4'
  pod 'OHHTTPStubs', '1.1.2'
end

post_install do |installer|
  environment_header = installer.config.project_pods_root + 'Pods-environment.h'
  text = "#import \"NamespacedDependencies.h\"\n\n" + environment_header.read
  environment_header.open('w') { |file| file.write(text) }

  dummy_class = installer.config.project_pods_root + 'Pods-dummy.m'
  text = "#import \"NamespacedDependencies.h\"\n\n" + dummy_class.read
  dummy_class.open('w') { |file| file.write(text) }

  File.write(installer.config.project_pods_root + 'NamespacedDependencies.h', '')
end
