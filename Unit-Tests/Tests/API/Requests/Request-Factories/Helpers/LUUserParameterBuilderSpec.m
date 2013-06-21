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
      user.customAttributes = @{@"key" : @"value"};
      user.email = @"test@example.com";
      user.firstName = @"John";
      user.gender = LUGenderMale;
      user.lastName = @"Smith";
      user.password = @"test123";
      user.termsAcceptedDate = [NSDate distantPast];
    });

    it(@"returns parameters for the user, plus the device identifier", ^{
      NSString *deviceIdentifer = @"abcd-1234";
      [LUDeviceIdentifier stub:@selector(deviceIdentifier) andReturn:deviceIdentifer];

      NSDictionary *expectedParams = @{
        @"born_at" : [user.birthdate iso8601DateTimeString],
        @"custom_attributes" : user.customAttributes,
        @"device_identifier" : deviceIdentifer,
        @"email" : user.email,
        @"first_name" : user.firstName,
        @"gender" : @"male",
        @"last_name" : user.lastName,
        @"password" : user.password,
        @"terms_accepted_at" : [user.termsAcceptedDate iso8601DateTimeString]
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
  });
});

SPEC_END
