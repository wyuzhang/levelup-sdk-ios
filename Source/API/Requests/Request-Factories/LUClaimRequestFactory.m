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
                                              apiVersion:LUAPIVersion13
                                              parameters:@{@"claim" : @{@"cohort_code" : cohort.code }}
                                            modelFactory:[LUClaimJSONFactory factory]];
}

+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithID:(NSString *)legacyID campaignID:(NSNumber *)campaignID {
  NSString *path = [NSString stringWithFormat:@"loyalties/legacy/%@/claims", campaignID];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:path
                                 apiVersion:LUAPIVersion13
                                 parameters:@{@"legacy_id" : legacyID}
                               modelFactory:[LUClaimJSONFactory factory]];
}

@end
