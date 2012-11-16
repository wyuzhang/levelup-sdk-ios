#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUClaimRequest.h"
#import "LUCohort.h"

@implementation LUClaimRequest

+ (LUAPIRequest *)claimCohort:(LUCohort *)cohort {
  NSString *path = [NSString stringWithFormat:@"users/%@/claims", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest authenticatedApiRequestWithMethod:@"POST" path:path parameters:@{@"claim" : @{@"cohort_code" : cohort.code }}];
}

@end
