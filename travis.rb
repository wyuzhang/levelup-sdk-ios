#!/usr/bin/env ruby

def run_tests(destination)
  system_raise_failure "xcodebuild -workspace LevelUpSDK.xcworkspace -scheme 'LevelUpSDK' -configuration Debug -sdk iphonesimulator -destination '#{destination}' test | xcpretty -ct"
  puts
end

def system_raise_failure(command)
  puts "Command: #{command}"
  success = system(command)
  unless success
    raise 'TEST_STEP_FAILURE'
  end
end

run_tests 'platform=iOS Simulator,OS=8.4,name=iPhone 5'
run_tests 'platform=iOS Simulator,OS=9.0,name=iPhone 5'
