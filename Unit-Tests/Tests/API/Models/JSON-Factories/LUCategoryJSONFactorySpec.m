#import "LUCategoryJSONFactory.h"

SPEC_BEGIN(LUCategoryJSONFactorySpec)

describe(@"LUCategoryJSONFactory", ^{
  __block LUCategoryJSONFactory *factory;

  beforeEach(^{
    factory = [LUCategoryJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCategory", ^{
      LUCategory *category = [factory createFromAttributes:[LUCategory fullJSONObject]];

      [[category.categoryID should] equal:@1];
      [[category.name should] equal:@"Test Category"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'category'", ^{
      [[[factory rootKey] should] equal:@"category"];
    });
  });
});

SPEC_END
