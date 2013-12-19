// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCategoryJSONFactory.h"

SPEC_BEGIN(LUCategoryJSONFactorySpec)

describe(@"LUCategoryJSONFactory", ^{
  __block LUCategoryJSONFactory *factory;

  beforeEach(^{
    factory = [LUCategoryJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCategory", ^{
      NSDictionary *JSON = @{@"id" : @1, @"name" : @"Test Category"};
      LUCategory *category = [factory createFromAttributes:JSON];

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
