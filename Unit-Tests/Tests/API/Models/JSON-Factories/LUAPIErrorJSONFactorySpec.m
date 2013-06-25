#import "LUAPIError.h"
#import "LUAPIErrorJSONFactory.h"

SPEC_BEGIN(LUAPIErrorJSONFactorySpec)

describe(@"LUAPIErrorJSONFactory", ^{
  __block LUAPIErrorJSONFactory *factory;

  beforeEach(^{
    factory = [LUAPIErrorJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUAPIError", ^{
      LUAPIError *error = [factory createFromAttributes:[LUAPIError fullJSONObject]];

      [[error.message should] equal:@"error message"];
      [[error.object should] equal:@"user"];
      [[error.property should] equal:@"first_name"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'error'", ^{
      [[[factory rootKey] should] equal:@"error"];
    });
  });
});

SPEC_END
