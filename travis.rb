#!/usr/bin/env ruby

def run_tests(destination)
  system_raise_failure "xcodebuild -workspace LevelUpSDK.xcworkspace -scheme 'LevelUpSDK' -configuration Debug -destination '#{destination}' clean build | xcpretty -c && exit ${PIPESTATUS[0]}"
  system_raise_failure "xcodebuild -workspace LevelUpSDK.xcworkspace -scheme 'LevelUpSDK' -configuration Debug -destination '#{destination}' test | xcpretty -c && exit ${PIPESTATUS[0]}"
end

def system_raise_failure(command)
  success = system(command)
  unless success
    raise "TEST_STEP_FAILURE"
  end
end

run_tests 'platform=iOS Simulator,OS=8.0,name=iPhone 6'
run_tests 'platform=iOS Simulator,OS=7.1,name=iPhone 5'
