#!/usr/bin/env ruby

def run_tests(destination)
  build_options = "-workspace LevelUpSDK.xcworkspace -scheme 'LevelUpSDK' -configuration Debug -sdk iphonesimulator -destination '#{destination}'"
  system_raise_failure "xcodebuild build #{build_options} > /dev/null"
  system_raise_failure "xcodebuild analyze #{build_options} > /dev/null"
  system_raise_failure "xcodebuild test #{build_options} | xcpretty -ct"
end

def system_raise_failure(command)
  puts "\n\033[1mCommand: #{command}\033[22m\n"
	raise 'TEST_STEP_FAILURE' unless system(command)
end

run_tests 'platform=iOS Simulator,OS=8.4,name=iPhone 6'
run_tests 'platform=iOS Simulator,OS=9.2,name=iPhone 6'
