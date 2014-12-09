#!/usr/bin/env ruby

def run_tests(destination)
  system_raise_failure "xctool -workspace LevelUpSDK.xcworkspace -scheme 'LevelUpSDK' -configuration Debug -sdk iphonesimulator -destination '#{destination}' build-tests > /dev/null"
  system_raise_failure "xctool -workspace LevelUpSDK.xcworkspace -scheme 'LevelUpSDK' -configuration Debug -sdk iphonesimulator -destination '#{destination}' run-tests"
end

def system_raise_failure(command)
  puts "Command: #{command}"
  success = system(command)
  unless success
    raise 'TEST_STEP_FAILURE'
  end
end

run_tests 'platform=iOS Simulator,OS=8.1,name=iPhone 6'
run_tests 'platform=iOS Simulator,OS=7.1,name=iPhone 5'
