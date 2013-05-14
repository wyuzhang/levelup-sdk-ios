#import "LUOrder+Fixtures.h"
#import "LUOrderJSONFactory.h"

@implementation LUOrder (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"balance" : [LUMonetaryValue fullJSONObject],
    @"closed" : @NO,
    @"created_at" : [[NSDate fixture] iso8601DateTimeString],
    @"credit" : [LUMonetaryValue fullJSONObject],
    @"donation" : [LUDonation fullJSONObject],
    @"earn" : [LUMonetaryValue fullJSONObject],
    @"id" : @1,
    @"interstitial_action" : [LUInterstitialAction fullJSONObject],
    @"location" : [LULocation fullJSONObject],
    @"loyalty" : [LULoyalty fullJSONObject],
    @"merchant" : [LUMerchant fullJSONObject],
    @"refunded_at" : [[NSDate fixture] iso8601DateTimeString],
    @"spend" : [LUMonetaryValue fullJSONObject],
    @"state" : @"processing",
    @"tip" : [LUMonetaryValue fullJSONObject],
    @"total" : [LUMonetaryValue fullJSONObject]
  };
}

+ (LUOrder *)fullOrder {
  return [[LUOrderJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
