#import "LUCauseCategoryJSONFactory.h"

SPEC_BEGIN(LUCauseCategoryJSONFactorySpec)

describe(@"LUCauseCategoryJSONFactory", ^{
  __block LUCauseCategoryJSONFactory *factory;

  beforeEach(^{
    factory = [LUCauseCategoryJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCauseCategory", ^{
      LUCauseCategory *category = [factory createFromAttributes:[LUCauseCategory fullJSONObject]];

      [[category.causeCategoryID should] equal:@1];
      [[category.name should] equal:@"Test Cause Category"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'cause_category'", ^{
      [[[factory rootKey] should] equal:@"cause_category"];
    });
  });
});

SPEC_END
