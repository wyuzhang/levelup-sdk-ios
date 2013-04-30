#import "LUAPIRequest.h"
#import "LUCohortJSONFactory.h"
#import "LUCohortRequestFactory.h"

@implementation LUCohortRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCohortWithCode:(NSString *)code {
  NSString *path = [NSString stringWithFormat:@"cohorts/%@", code];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil modelFactory:[LUCohortJSONFactory factory]];
}

@end
