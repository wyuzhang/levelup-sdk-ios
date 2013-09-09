// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "NSDate+StringFormats.h"

SPEC_BEGIN(NSDateStringFormatsSpec)

describe(@"NSDate", ^{
  // Public Methods

  NSString *dateString = @"2013-02-10T01:06:19+0000";
  NSTimeInterval secondsSince1970 = 1360458379;

  describe(@"dateFromIso8601DateTimeString:", ^{
    it(@"returns an NSDate given an ISO 8601 string", ^{

      NSDate *date = [NSDate lu_dateFromIso8601DateTimeString:dateString];
      [[theValue([date timeIntervalSince1970]) should] equal:theValue(secondsSince1970)];
    });
  });

  describe(@"iso8601DateTimeString", ^{
    it(@"returns the date as an ISO 8601 string", ^{
      NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondsSince1970];

      [[[date lu_iso8601DateTimeString] should] equal:dateString];
    });
  });
});

SPEC_END
