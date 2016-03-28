/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "NSDate+StringFormats.h"

SPEC_BEGIN(NSDateStringFormatsSpec)

describe(@"NSDate", ^{
  // Public Methods

  NSString *dateString = @"2013-02-10T01:06:19+0000";
  NSTimeInterval secondsSince1970 = 1360458379;

  describe(@"lu_dateFromIso8601DateTimeString:", ^{
    it(@"returns an NSDate given an ISO 8601 string", ^{

      NSDate *date = [NSDate lu_dateFromIso8601DateTimeString:dateString];
      [[theValue([date timeIntervalSince1970]) should] equal:theValue(secondsSince1970)];
    });
  });

  describe(@"luui_dateAfterConvertingToTimeZone:", ^{
    NSDate *localDate = [NSDate dateWithTimeIntervalSince1970:1369926952];
    NSDate *ESTDate = [localDate lu_dateAfterConvertingToTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];

    it(@"correctly converts date representation between time zones", ^{
      NSInteger ESTDateHours = [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:ESTDate] hour];
      NSDate *PSTDate = [localDate lu_dateAfterConvertingToTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
      NSInteger PSTDateHours = [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:PSTDate] hour];

      [[theValue(ESTDateHours) should] equal:theValue((PSTDateHours + 3) % 24)];
    });
  });

  describe(@"lu_iso8601DateTimeString", ^{
    it(@"returns the date as an ISO 8601 string", ^{
      NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondsSince1970];

      [[[date lu_iso8601DateTimeString] should] equal:dateString];
    });
  });
});

SPEC_END
