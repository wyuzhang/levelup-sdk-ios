#import "LUUser.h"
#import "LUUserAddress.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUUserSpec)

describe(@"LUUser", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUUser class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  __block LUUser *user;

  beforeEach(^{
    user = [[LUUser alloc] init];
  });

  // Public Methods

  describe(@"homeAddress", ^{
    context(@"when the user has no addresses", ^{
      beforeEach(^{
        user.userAddresses = nil;
      });

      it(@"is nil", ^{
        [[user homeAddress] shouldBeNil];
      });
    });

    context(@"when the user has no home addresses", ^{
      beforeEach(^{
        LUUserAddress *workAddress = [[LUUserAddress alloc] init];
        workAddress.addressType = @"work";
        user.userAddresses = @[workAddress];
      });

      it(@"is nil", ^{
        [[user homeAddress] shouldBeNil];
      });
    });

    context(@"when the user has a home address", ^{
      __block LUUserAddress *homeAddress;

      beforeEach(^{
        LUUserAddress *workAddress = [[LUUserAddress alloc] init];
        workAddress.addressType = @"work";
        homeAddress = [[LUUserAddress alloc] init];
        homeAddress.addressType = @"home";
        user.userAddresses = @[workAddress, homeAddress];
      });

      it(@"is the home address", ^{
        [[[user homeAddress] should] equal:homeAddress];
      });
    });

    context(@"when the user has multiple home addresses", ^{
      __block LUUserAddress *homeAddress1;

      beforeEach(^{
        LUUserAddress *workAddress = [[LUUserAddress alloc] init];
        workAddress.addressType = @"work";
        homeAddress1 = [[LUUserAddress alloc] init];
        homeAddress1.addressType = @"home";
        LUUserAddress *homeAddress2 = [[LUUserAddress alloc] init];
        homeAddress2.addressType = @"home";
        user.userAddresses = @[workAddress, homeAddress1, homeAddress2];
      });

      it(@"is the first home address", ^{
        [[[user homeAddress] should] equal:homeAddress1];
      });
    });
  });
});

SPEC_END
