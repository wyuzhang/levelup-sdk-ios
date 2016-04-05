/*
 * Copyright (C) 2016 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUMonetaryValue.h"
#import "LUOrderAheadViewableOrder+Fixtures.h"
#import "NSDate+StringFormats.h"

@implementation LUOrderAheadViewableOrder (Fixtures)

+ (instancetype)fixture {
  return [self fixtureWithTimezone:[NSTimeZone localTimeZone]];
}

+ (instancetype)fixtureWithESTTimeZone {
  return [self fixtureWithTimezone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
}

+ (instancetype)fixtureWithTimezone:(NSTimeZone *)timeZone {
  NSURL *completionURL =
    [NSURL URLWithString:@"https://api.staging-levelup.com/v15/order_ahead/orders/1a2b3c4d5e6f7g8h9i/complete"];

  NSDate *soonestAvailableAt = [[NSDate lu_dateFromIso8601DateTimeString:@"2015-09-17T15:00:00Z"]
                                lu_dateAfterConvertingToTimeZone:timeZone];

  return [[LUOrderAheadViewableOrder alloc]
          initWithCompletionURL:completionURL
          discount:[LUMonetaryValue monetaryValueWithUSCents:@100]
          locationSubtitle:@"Boston, MA 02114"
          locationTitle:@"123 Main St."
          serviceFee:[LUMonetaryValue monetaryValueWithUSCents:@150]
          soonestAvailableAt:soonestAvailableAt
          spend:[LUMonetaryValue monetaryValueWithUSCents:@498]
          state:LUOrderAheadOrderStateValid
          tax:[LUMonetaryValue monetaryValueWithUSCents:@45]
          tip:[LUMonetaryValue monetaryValueWithUSCents:@0]
          total:[LUMonetaryValue monetaryValueWithUSCents:@945]
          UUID:@"1a2b3c4d5e6f7g8h9i"];
}

@end
