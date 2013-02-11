#import "LUAPIRequest.h"
#import "LUCohortRequestBuilder.h"

@implementation LUCohortRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCohortWithCode:(NSString *)code {
  NSString *path = [NSString stringWithFormat:@"cohorts/%@", code];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

@end
