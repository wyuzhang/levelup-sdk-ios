// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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
