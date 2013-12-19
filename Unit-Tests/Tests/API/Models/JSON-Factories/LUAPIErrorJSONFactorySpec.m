// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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
      NSDictionary *JSON = @{
        @"message" : @"error message",
        @"object" : @"user",
        @"property" : @"first_name"
      };
      LUAPIError *error = [factory createFromAttributes:JSON];

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
