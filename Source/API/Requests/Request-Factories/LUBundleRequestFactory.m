#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUBundleJSONFactory.h"
#import "LUBundleRequestFactory.h"

@implementation LUBundleRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForBundlesOnPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/bundles", [LUAPIClient sharedClient].currentUserID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:@{@"page" : @(page)}
                                            modelFactory:[LUBundleJSONFactory factory]];
}

@end
