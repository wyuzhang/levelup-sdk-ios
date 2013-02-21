#import "LUCampaignModelBuilder.h"
#import "LUClaim.h"
#import "LUClaimModelBuilder.h"
#import "LUCohortModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUClaimModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"claim"]) {
    attributes = attributes[@"claim"];
  }

  LUClaim *claim = [[LUClaim alloc] init];
  claim.campaign = [[LUCampaignModelBuilder builder] buildModelFromJSON:attributes[@"campaign"]];
  claim.claimID = [attributes numberForKey:@"claim_id"];
  claim.cohort = [[LUCohortModelBuilder builder] buildModelFromJSON:attributes[@"cohort"]];
  claim.shareCohort = [[LUCohortModelBuilder builder] buildModelFromJSON:attributes[@"share_cohort"]];

  return claim;
}

@end
