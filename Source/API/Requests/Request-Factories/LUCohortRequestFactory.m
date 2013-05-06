#import "LUAuthenticatedAPIRequest.h"
#import "LUCohortJSONFactory.h"
#import "LUCohortRequestFactory.h"

@implementation LUCohortRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCohortWithCode:(NSString *)code {
  NSString *path = [NSString stringWithFormat:@"cohorts/%@", code];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUCohortJSONFactory factory]];
}

@end
