#import "LUUser+Fixtures.h"
#import "LUUserJSONFactory.h"

@implementation LUUser (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"able_to_refer" : @YES,
    @"born_at" : [[NSDate fixture] iso8601DateTimeString],
    @"cause" : [LUCause fullJSONObject],
    @"credit" : [LUMonetaryValue fullJSONObject],
    @"custom_attributes" : @{@"key" : @"value"},
    @"email" : @"test@example.com",
    @"employer" : @"SCVNGR",
    @"facebook_access_token" : @"facebook-access-token",
    @"first_name" : @"Test",
    @"gender" : @"male",
    @"id" : @1,
    @"last_name" : @"User",
    @"loyalties_savings" : [LUMonetaryValue fullJSONObject],
    @"merchants_visited_count" : @5,
    @"orders_count" : @10,
    @"payment_eligible" : @YES,
    @"qr_code" : @{@"data" : @"payment-token"},
    @"percent_donation" : @50,
    @"terms_accepted_at" : [[NSDate fixture] iso8601DateTimeString]
  };
}

@end
