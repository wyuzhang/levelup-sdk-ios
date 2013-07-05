#import "LUClaim+Fixtures.h"
#import "LUClaimJSONFactory.h"

@implementation LUClaim (Fixtures)

+ (LUClaim *)fullClaim {
  return [[LUClaimJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
    @"campaign" : [LUCampaign minimalJSONObject],
    @"id" : @1,
    @"cohort" : [LUCohort minimalJSONObject],
    @"share_cohort" : [LUCohort minimalJSONObject]
  };
}

@end
