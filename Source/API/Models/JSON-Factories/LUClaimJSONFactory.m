#import "LUCampaignJSONFactory.h"
#import "LUClaim.h"
#import "LUClaimJSONFactory.h"
#import "LUCohortJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUClaimJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUCampaign *campaign = [[LUCampaignJSONFactory factory] fromJSONObject:attributes[@"campaign"]];
  NSNumber *claimID = [attributes numberForKey:@"id"];
  LUCohort *cohort = [[LUCohortJSONFactory factory] fromJSONObject:attributes[@"cohort"]];
  LUCohort *shareCohort = [[LUCohortJSONFactory factory] fromJSONObject:attributes[@"share_cohort"]];

  return [[LUClaim alloc] initWithCampaign:campaign claimID:claimID cohort:cohort shareCohort:shareCohort];
}

- (NSString *)rootKey {
  return @"claim";
}

@end
