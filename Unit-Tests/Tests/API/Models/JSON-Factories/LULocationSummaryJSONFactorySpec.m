// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULocationSummaryJSONFactory.h"

SPEC_BEGIN(LULocationSummaryJSONFactorySpec)

describe(@"LULocationSummaryJSONFactory", ^{
  __block LULocationSummaryJSONFactory *factory;

  beforeEach(^{
    factory = [LULocationSummaryJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULocation", ^{
      LULocation *location = [factory createFromAttributes:[LULocation summaryJSONObject]];

      [[location.categoryIDs should] equal:@[@1, @2, @3]];
      [[location.latitude should] equal:@70];
      [[location.locationID should] equal:@1];
      [[location.longitude should] equal:@-45];
      [[location.merchantID should] equal:@1];
      [[location.merchantName should] equal:@"Dewey, Cheatem and Howe"];
      [[theValue(location.shown) should] beYes];
      [[theValue(location.summary) should] beYes];
      [[location.updatedAtDate should] equal:[NSDate fixture]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'location'", ^{
      [[[factory rootKey] should] equal:@"location"];
    });
  });
});

SPEC_END
