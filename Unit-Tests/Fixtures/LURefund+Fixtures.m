#import "LURefund+Fixtures.h"
#import "LURefundJSONFactory.h"

@implementation LURefund (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"created_at" : [[NSDate fixture] iso8601DateTimeString],
    @"id" : @1,
    @"order" : [LUOrder fullJSONObject]
  };
}

+ (LURefund *)fullRefund {
  return [[LURefundJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
