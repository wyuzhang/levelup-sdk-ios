#import "LUCampaign+Fixtures.h"
#import "LUCampaignJSONFactory.h"

@implementation LUCampaign (Fixtures)

+ (LUCampaign *)fullCampaign {
  return [[LUCampaignJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
    @"claimed" : @YES,
    @"cohort" : [LUCohort fullJSONObject],
    @"cohorts" : @[[LUCohort minimalJSONObject]],
    @"confirmation_html" : @"<p>confirmation</p>",
    @"global" : @NO,
    @"id" : @1,
    @"merchants" : @[[LUMerchant minimalJSONObject]],
    @"mobile_image_url_320x212_1x" : @"http://example.com/image_url_1x",
    @"mobile_image_url_320x212_2x" : @"http://example.com/image_url_2x",
    @"name" : @"Test Campaign",
    @"offer_html" : @"<p>offer</p>",
    @"sponsor" : @"Sponsor",
    @"support_email" : @"support@example.com",
    @"value" : [LUMonetaryValue fullJSONObject]
  };
}

+ (LUCampaign *)minimalCampaign {
  return [[LUCampaignJSONFactory factory] fromJSONObject:[self minimalJSONObject]];
}

+ (NSDictionary *)minimalJSONObject {
  return @{
    @"id" : @1
  };
}

@end
