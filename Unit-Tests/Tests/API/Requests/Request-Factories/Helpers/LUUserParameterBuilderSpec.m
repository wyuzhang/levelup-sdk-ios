/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUDeviceIdentifier.h"
#import "LUUser.h"
#import "LUUserParameterBuilder.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUUserParameterBuilderSpec)

describe(@"LUUserParameterBuilder", ^{
  // Public Methods

  describe(@"parametersForUser:", ^{
    __block LUUser *user;

    beforeEach(^{
      user = [[LUUser alloc] init];
      user.birthdate = [NSDate distantPast];
      user.email = @"test@example.com";
      user.firstName = @"John";
      user.gender = LUGenderMale;
      user.lastName = @"Smith";
      user.password = @"test123";
      user.termsAccepted = YES;
    });

    it(@"returns parameters for the user, plus the device identifier", ^{
      NSString *deviceIdentifer = @"abcd-1234";
      [LUDeviceIdentifier stub:@selector(deviceIdentifier) andReturn:deviceIdentifer];

      NSDictionary *expectedParams = @{
        @"born_at" : [user.birthdate lu_iso8601DateTimeString],
        @"device_identifier" : deviceIdentifer,
        @"email" : user.email,
        @"first_name" : user.firstName,
        @"gender" : @"male",
        @"last_name" : user.lastName,
        @"password" : user.password,
        @"terms_accepted" : @YES
      };

      [[[LUUserParameterBuilder parametersForUser:user] should] equal:expectedParams];
    });

    context(@"when a user property is a blank string", ^{
      beforeEach(^{
        user.email = @"";
      });

      it(@"does not return a parameter for that property", ^{
        [[LUUserParameterBuilder parametersForUser:user][@"email"] shouldBeNil];
      });
    });

    context(@"when a user is new", ^{
      it(@"does not include custom attributes", ^{
        user.customAttributes[@"key"] = @"value";
        [[LUUserParameterBuilder parametersForUser:user][@"custom_attributes"] shouldBeNil];
      });
    });

    context(@"when a user is existing", ^{
      beforeEach(^{
        [user setValue:@1 forKey:@"userID"];
      });

      it(@"does include custom attributes", ^{
        user.customAttributes[@"key"] = @"value";
        [[LUUserParameterBuilder parametersForUser:user][@"custom_attributes"] shouldNotBeNil];
      });
    });
  });
});

SPEC_END
