#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUClaimJSONFactory.h"
#import "LUClaimRequestFactory.h"
#import "LUCohort.h"
#import "LULegacyLoyaltyClaimJSONFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUClaimRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToClaimCohort:(LUCohort *)cohort {
  NSString *path = [NSString stringWithFormat:@"users/%@/claims", [LUAPIClient sharedClient].currentUserID];

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:cohort.code forKey:@"cohort_code"];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"POST"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:@{@"claim" : parameters}
                                            modelFactory:[LUClaimJSONFactory factory]];
}

+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithID:(NSString *)legacyID campaignID:(NSNumber *)campaignID {
  NSString *path = [NSString stringWithFormat:@"loyalties/legacy/%@/claims", campaignID];

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:legacyID forKey:@"legacy_id"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:path
                                 apiVersion:LUAPIVersion13
                                 parameters:parameters
                               modelFactory:[LULegacyLoyaltyClaimJSONFactory factory]];
}

@end
