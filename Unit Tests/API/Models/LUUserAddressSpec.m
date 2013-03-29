#import "LUUserAddress.h"

SPEC_BEGIN(LUUserAddressSpec)

describe(@"LUUserAddress", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUUserAddress class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  __block LUUserAddress *userAddress = [[LUUserAddress alloc] init];

  describe(@"isHomeAddress", ^{
    context(@"when the addressType is 'home'", ^{
      beforeEach(^{
        userAddress.addressType = @"home";
      });

      it(@"is YES", ^{
        [[theValue([userAddress isHomeAddress]) should] beYes];
      });
    });

    context(@"when the addressType is not 'home'", ^{
      beforeEach(^{
        userAddress.addressType = @"work";
      });

      it(@"is NO", ^{
        [[theValue([userAddress isHomeAddress]) should] beNo];
      });
    });
  });

  describe(@"isOtherAddress", ^{
    context(@"when the addressType is 'other'", ^{
      beforeEach(^{
        userAddress.addressType = @"other";
      });

      it(@"is YES", ^{
        [[theValue([userAddress isOtherAddress]) should] beYes];
      });
    });

    context(@"when the addressType is not 'other'", ^{
      beforeEach(^{
        userAddress.addressType = @"work";
      });

      it(@"is NO", ^{
        [[theValue([userAddress isOtherAddress]) should] beNo];
      });
    });
  });

  describe(@"isWorkAddress", ^{
    context(@"when the addressType is 'work'", ^{
      beforeEach(^{
        userAddress.addressType = @"work";
      });

      it(@"is YES", ^{
        [[theValue([userAddress isWorkAddress]) should] beYes];
      });
    });

    context(@"when the addressType is not 'work'", ^{
      beforeEach(^{
        userAddress.addressType = @"home";
      });

      it(@"is NO", ^{
        [[theValue([userAddress isWorkAddress]) should] beNo];
      });
    });
  });
});

SPEC_END
