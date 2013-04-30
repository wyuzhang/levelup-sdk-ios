#import "LUCause+Fixtures.h"
#import "LUCauseJSONFactory.h"

@implementation LUCause (Fixtures)

+ (LUCause *)fullCause {
  return [[LUCauseJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
    @"description_html" : @"<p>description</p>",
    @"employer_required" : @NO,
    @"facebook_url" : @"http://facebook.com/example",
    @"featured" : @YES,
    @"home_address_required" : @NO,
    @"id" : @1,
    @"image_url_320x212_1x" : @"http://example.com/image_url_1x",
    @"image_url_320x212_2x" : @"http://example.com/image_url_2x",
    @"minimum_age_required" : @18,
    @"name" : @"Test Cause",
    @"partner_specific_terms" : @"terms",
    @"twitter_username" : @"example",
    @"website" : @"http://example.com"
  };
}

@end
