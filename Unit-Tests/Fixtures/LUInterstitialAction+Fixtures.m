#import "LUInterstitialAction+Fixtures.h"
#import "LUInterstitialActionJSONFactory.h"

@implementation LUInterstitialAction (Fixtures)

+ (LUInterstitialAction *)fullInterstitialAction {
  return [[LUInterstitialActionJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
    @"campaign" : [LUCampaign fullJSONObject],
    @"id" : @1,
    @"type" : @"customer_acquisition_share"
  };
}

@end
