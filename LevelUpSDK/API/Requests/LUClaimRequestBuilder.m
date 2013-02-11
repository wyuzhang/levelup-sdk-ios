#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUClaimRequestBuilder.h"
#import "LUCohort.h"

@implementation LUClaimRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToClaimCohort:(LUCohort *)cohort {
  NSString *path = [NSString stringWithFormat:@"users/%@/claims", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"claim" : @{@"cohort_code" : cohort.code }}];
}

+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithId:(NSString *)legacyId campaignId:(NSNumber *)campaignId {
  NSString *path = [NSString stringWithFormat:@"loyalties/legacy/%@/claims", campaignId];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"legacy_id" : legacyId}];
}

@end
