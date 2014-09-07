#!/usr/bin/env ruby

def system_raise_failure(command)
  success = system(command)
  if !success
    raise "TEST_STEP_FAILURE"
  end
end


system_raise_failure "xcodebuild -workspace LevelUpSDK.xcworkspace -scheme 'LevelUpSDK' -configuration Debug -destination 'name=iPhone Retina (4-inch 64-bit)' clean build | xcpretty -c && exit ${PIPESTATUS[0]}"
system_raise_failure "xcodebuild -workspace LevelUpSDK.xcworkspace -scheme 'LevelUpSDK' -configuration Debug -destination 'name=iPhone Retina (4-inch 64-bit)' test | xcpretty -c && exit ${PIPESTATUS[0]}"
