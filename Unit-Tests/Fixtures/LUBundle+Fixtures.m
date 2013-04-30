#import "LUBundle+Fixtures.h"

@implementation LUBundle (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"amount" : [LUMonetaryValue fullJSONObject],
    @"charged_at" : [[NSDate fixture] iso8601DateTimeString],
    @"created_at" : [[NSDate fixture] iso8601DateTimeString],
    @"id" : @1,
    @"last_4" : @"1234",
    @"orders" : @[[LUOrder fullJSONObject]],
    @"refunds" : @[[LURefund fullJSONObject]],
    @"state" : @"closed",
    @"total_credit_used" : [LUMonetaryValue fullJSONObject]
  };
}

@end
