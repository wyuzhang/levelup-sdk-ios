#import "LUClaim+Fixtures.h"

@implementation LUClaim (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"campaign" : [LUCampaign minimalJSONObject],
    @"id" : @1,
    @"cohort" : [LUCohort minimalJSONObject],
    @"share_cohort" : [LUCohort minimalJSONObject]
  };
}

@end
