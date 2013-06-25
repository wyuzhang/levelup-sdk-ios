#import "LUCause+Fixtures.h"
#import "LUUser+Fixtures.h"
#import "LUUserJSONFactory.h"

@implementation LUUser (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"born_at" : [[NSDate fixture] iso8601DateTimeString],
    @"cause" : [LUCause fullJSONObject],
    @"credit" : [LUMonetaryValue fullJSONObject],
    @"custom_attributes" : @{@"key" : @"value"},
    @"email" : @"test@example.com",
    @"facebook_access_token" : @"facebook-access-token",
    @"first_name" : @"Test",
    @"gender" : @"male",
    @"id" : @1,
    @"last_name" : @"User",
    @"loyalties_savings" : [LUMonetaryValue fullJSONObject],
    @"merchants_visited_count" : @5,
    @"orders_count" : @10,
    @"terms_accepted_at" : [[NSDate fixture] iso8601DateTimeString]
  };
}

+ (NSDictionary *)fullV14JSONObject {
  return @{
    @"born_at" : [[NSDate fixture] iso8601DateTimeString],
    @"cause_id" : @1,
    @"connected_to_facebook" : @YES,
    @"custom_attributes" : @{@"key" : @"value"},
    @"email" : @"test@example.com",
    @"first_name" : @"Test",
    @"gender" : @"male",
    @"global_credit_amount" : [LUMonetaryValue fullMonetaryValue].amount,
    @"id" : @1,
    @"last_name" : @"User",
    @"merchants_visited_count" : @5,
    @"orders_count" : @10,
    @"terms_accepted_at" : [[NSDate fixture] iso8601DateTimeString],
    @"total_savings_amount" : [LUMonetaryValue fullMonetaryValue].amount
  };
}

@end
