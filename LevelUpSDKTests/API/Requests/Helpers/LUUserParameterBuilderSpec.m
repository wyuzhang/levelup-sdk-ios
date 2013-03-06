#import "LUDeviceIdentifier.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "LUUserParameterBuilder.h"

SPEC_BEGIN(LUUserParameterBuilderSpec)

describe(@"LUUserParameterBuilder", ^{
  // Public Methods

  describe(@"parametersForUser:", ^{
    __block LUUser *user;

    beforeEach(^{
      user = [[LUUser alloc] init];
      user.birthday = [NSDate distantPast];
      user.customAttributes = @{@"key" : @"value"};
      user.email = @"test@example.com";
      user.employer = @"SCVNGR";
      user.firstName = @"John";
      user.isMale = YES;
      user.lastName = @"Smith";
      user.lat = @40;
      user.lng = @-70;
      user.newPassword = @"test123";
      user.newPasswordConfirmation = @"test123";
      user.percentDonation = @50;
      user.promotionCode = @"abc123";
      user.subscribed = YES;
      user.termsAcceptedTime = [NSDate distantPast];
    });

    it(@"returns parameters for the user, plus the device identifier", ^{
      NSString *deviceIdentifer = @"abcd-1234";
      [LUDeviceIdentifier stub:@selector(deviceIdentifier) andReturn:deviceIdentifer];

      NSDictionary *expectedParams = @{
        @"born_at" : [user valueForKey:@"bornAt"],
        @"custom_attributes" : user.customAttributes,
        @"device_identifier" : deviceIdentifer,
        @"email" : user.email,
        @"employer" : user.employer,
        @"first_name" : user.firstName,
        @"gender" : [user valueForKey:@"gender"],
        @"last_name" : user.lastName,
        @"lat" : user.lat,
        @"lng" : user.lng,
        @"new_password" : user.newPassword,
        @"new_password_confirmation" : user.newPasswordConfirmation,
        @"percent_donation" : user.percentDonation,
        @"promotion_code" : user.promotionCode,
        @"subscribed" : @(user.subscribed),
        @"terms_accepted_at" : [user valueForKey:@"termsAcceptedAt"]
      };

      [[[LUUserParameterBuilder parametersForUser:user] should] equal:expectedParams];
    });

    context(@"when a user property is a blank string", ^{
      beforeEach(^{
        user.employer = @"";
      });

      it(@"does not return a parameter for that property", ^{
        [[LUUserParameterBuilder parametersForUser:user][@"employer"] shouldBeNil];
      });
    });

    context(@"when the user has addresses", ^{
      __block LUUserAddress *homeAddress, *workAddress;

      beforeEach(^{
        homeAddress = [[LUUserAddress alloc] init];
        homeAddress.addressType = @"home";
        homeAddress.extendedAddress = @"";
        homeAddress.modelId = @1;
        homeAddress.locality = @"Cambridge";
        homeAddress.postalCode = @"01234";
        homeAddress.region = @"MA";
        homeAddress.streetAddress = @"1 Main St.";

        workAddress = [[LUUserAddress alloc] init];
        workAddress.addressType = @"home";
        workAddress.extendedAddress = @"2nd Floor";
        workAddress.modelId = @2;
        workAddress.locality = @"Boston";
        workAddress.postalCode = @"";
        workAddress.region = @"MA";
        workAddress.streetAddress = @"2 Wall St.";

        user.userAddresses = @[homeAddress, workAddress];
      });

      it(@"includes the user addresses, excluding blank properties", ^{
        NSDictionary *expectedHomeAddressParams = @{
          @"address_type" : homeAddress.addressType,
          @"id" : homeAddress.modelId,
          @"locality" : homeAddress.locality,
          @"postal_code" : homeAddress.postalCode,
          @"region" : homeAddress.region,
          @"street_address" : homeAddress.streetAddress
        };

        NSDictionary *expectedWorkAddressParams = @{
          @"address_type" : workAddress.addressType,
          @"extended_address" : workAddress.extendedAddress,
          @"id" : workAddress.modelId,
          @"locality" : workAddress.locality,
          @"region" : workAddress.region,
          @"street_address" : workAddress.streetAddress
        };

        NSDictionary *userParams = [LUUserParameterBuilder parametersForUser:user];

        [[userParams[@"user_addresses_attributes[0]"] should] equal:expectedHomeAddressParams];
        [[userParams[@"user_addresses_attributes[1]"] should] equal:expectedWorkAddressParams];
      });
    });
  });
});

SPEC_END
