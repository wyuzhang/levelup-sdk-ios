// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULocationSummaryJSONFactory.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LULocationSummaryJSONFactorySpec)

describe(@"LULocationSummaryJSONFactory", ^{
  __block LULocationSummaryJSONFactory *factory;

  beforeEach(^{
    factory = [LULocationSummaryJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULocation", ^{
      NSDictionary *JSON = @{
        @"categories" : @[@1, @2, @3],
        @"id" : @1,
        @"latitude" : @70,
        @"longitude" : @-45,
        @"merchant_id" : @1,
        @"merchant_name" : @"Dewey, Cheatem and Howe",
        @"name" : @"Boston Branch",
        @"shown" : @1,
        @"updated_at" : @"2012-12-04T18:10:45-05:00"
      };
      LULocation *location = [factory createFromAttributes:JSON];

      [[location.categoryIDs should] equal:@[@1, @2, @3]];
      [[location.latitude should] equal:@70];
      [[location.locationID should] equal:@1];
      [[location.longitude should] equal:@-45];
      [[location.merchantID should] equal:@1];
      [[location.merchantName should] equal:@"Dewey, Cheatem and Howe"];
      [[location.name should] equal:@"Boston Branch"];
      [[theValue(location.shown) should] beYes];
      [[theValue(location.summary) should] beYes];
      [[location.updatedAtDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-04T18:10:45-05:00"]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'location'", ^{
      [[[factory rootKey] should] equal:@"location"];
    });
  });
});

SPEC_END
