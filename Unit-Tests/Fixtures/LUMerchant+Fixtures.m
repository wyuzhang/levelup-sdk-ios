#import "LUMerchant+Fixtures.h"
#import "LUMerchantJSONFactory.h"

@implementation LUMerchant (Fixtures)

+ (NSDictionary *)minimalJSONObject {
  return @{
    @"id" : @1,
    @"name" : @"name"
  };
}

+ (LUMerchant *)minimalMerchant {
  return [[LUMerchantJSONFactory factory] fromJSONObject:[self minimalJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
    @"description_html" : @"<p>description</p>",
    @"earn" : [LUMonetaryValue fullJSONObject],
    @"facebook_url" : @"http://facebook.com/example",
    @"featured" : @YES,
    @"id" : @1,
    @"image_url_280x128_1x" : @"http://example.com/image_url_1x",
    @"image_url_280x128_2x" : @"http://example.com/image_url_2x",
    @"locations" : @[[LULocation fullJSONObject]],
    @"loyalty" : [LULoyalty fullJSONObject],
    @"loyalty_enabled" : @YES,
    @"name" : @"Test Merchant",
    @"newsletter_url" : @"http://example.com/newsletter",
    @"opentable_url" : @"http://example.com/opentable",
    @"public_url" : @"http://example.com",
    @"scvngr_url" : @"http://scvngr.com/example",
    @"spend" : [LUMonetaryValue fullJSONObject],
    @"twitter_username" : @"example",
    @"url" : @"http://example.com/website",
    @"yelp_url" : @"http://yelp.com/example"
  };
}

+ (LUMerchant *)fullMerchant {
  return [[LUMerchantJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
