#import "LUDeviceIdentifier.h"
#import "LUKeychainAccess.h"

SPEC_BEGIN(LUDeviceIdentifierSpec)

describe(@"LUDeviceIdentifier", ^{
  // Public Methods

  describe(@"deviceIdentifier", ^{
    beforeEach(^{
      [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[LUKeychainAccess nullMock]];
    });

    context(@"when a device identifier has not been stored", ^{
      beforeEach(^{
        [[[LUKeychainAccess standardKeychainAccess] stubAndReturn:nil] stringForKey:DeviceIdentifierKey];
      });

      it(@"returns a new UUID", ^{
        NSString *UUID1 = [LUDeviceIdentifier deviceIdentifier];
        NSString *UUID2 = [LUDeviceIdentifier deviceIdentifier];

        [[UUID1 shouldNot] equal:UUID2];
      });
    });

    context(@"when a device identifier has been previously stored", ^{
      NSString *UUID = @"c5d0d1fefaf12815bf60413f9f81c07c";

      beforeEach(^{
        [[[LUKeychainAccess standardKeychainAccess] stubAndReturn:UUID] stringForKey:DeviceIdentifierKey];
      });

      it(@"returns the stored device identifier", ^{
        [[[LUDeviceIdentifier deviceIdentifier] should] equal:UUID];
      });
    });
  });
});

SPEC_END
