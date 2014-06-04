#import "LURegistration.h"
#import "LURegistrationJSONFactory.h"

SPEC_BEGIN(LURegistrationJSONFactorySpec)

describe(@"LURegistrationJSONFactory", ^{
  __block LURegistrationJSONFactory *factory;

  beforeEach(^{
    factory = [LURegistrationJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LURegistration", ^{
      NSDictionary *JSON = @{@"app_name": @"App Name", @"description": @"A Description", @"facebook": @YES};
      LURegistration *registration = [factory createFromAttributes:JSON];

      [[registration.appName should] equal:@"App Name"];
      [[theValue(registration.facebook) should] beYes];
      [[registration.registrationDescription should] equal:@"A Description"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'registration'", ^{
      [[[factory rootKey] should] equal:@"registration"];
    });
  });
});

SPEC_END
