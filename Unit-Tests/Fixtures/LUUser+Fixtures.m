#import "LUUser+Fixtures.h"
#import "LUUserJSONFactory.h"

@implementation LUUser (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"born_at" : [[NSDate fixture] iso8601DateTimeString],
    @"cause_id" : @1,
    @"custom_attributes" : @{@"key" : @"value"},
    @"email" : @"test@example.com",
    @"facebook_access_token" : @"facebook-access-token",
    @"first_name" : @"Test",
    @"gender" : @"male",
    @"global_credit" : [LUMonetaryValue fullJSONObject],
    @"id" : @1,
    @"last_name" : @"User",
    @"merchants_visited_count" : @5,
    @"orders_count" : @10,
    @"terms_accepted_at" : [[NSDate fixture] iso8601DateTimeString],
    @"total_savings" : [LUMonetaryValue fullJSONObject]
  };
}

@end
