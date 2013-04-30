#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUClaimJSONFactory.h"
#import "LUClaimRequestFactory.h"
#import "LUCohort.h"

@implementation LUClaimRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToClaimCohort:(LUCohort *)cohort {
  NSString *path = [NSString stringWithFormat:@"users/%@/claims", [LUAPIClient sharedClient].currentUserID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"POST"
                                                    path:path
                                              parameters:@{@"claim" : @{@"cohort_code" : cohort.code }}
                                            modelFactory:[LUClaimJSONFactory factory]];
}

+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithId:(NSString *)legacyId campaignId:(NSNumber *)campaignId {
  NSString *path = [NSString stringWithFormat:@"loyalties/legacy/%@/claims", campaignId];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:path
                                 parameters:@{@"legacy_id" : legacyId}
                               modelFactory:[LUClaimJSONFactory factory]];
}

@end
