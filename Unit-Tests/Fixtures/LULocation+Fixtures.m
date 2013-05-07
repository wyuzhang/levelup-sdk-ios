#import "LULocation+Fixtures.h"
#import "LULocationJSONFactory.h"
#import "NSDate+Fixtures.h"

@implementation LULocation (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"categories" : @[@1, @2, @3],
    @"description_html" : @"pizza, pizza, pizza!",
    @"extended_address" : @"Apt E",
    @"facebook_url" : @"http://facebook.com/pizza",
    @"hours" : @"M-F 9am-5pm",
    @"id" : @1,
    @"latitude" : @70,
    @"locality" : @"Boston",
    @"longitude" : @-45,
    @"menu_url" : @"http://pizza.com/menu",
    @"merchant_id" : @1,
    @"merchant_name" : @"Dewey, Cheatem and Howe",
    @"name" : @"Test Location",
    @"newsletter_url" : @"http://pizza.com/newsletter",
    @"opentable_url" : @"http://opentable.com/pizza",
    @"phone" : @"617-123-1234",
    @"postal_code" : @"01234",
    @"region" : @"MA",
    @"shown" : @1,
    @"street_address" : @"1 Main St",
    @"twitter_url" : @"http://twitter.com/pizza",
    @"updated_at" : [[NSDate fixture] iso8601DateTimeString],
    @"yelp_url" : @"http://yelp.com/pizza"
  };
}

+ (LULocation *)fullLocation {
  return [[LULocationJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
