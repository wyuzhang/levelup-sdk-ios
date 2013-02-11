#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUBundleRequestBuilder.h"

@implementation LUBundleRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForBundlesOnPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/bundles", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:@{@"page" : @(page)}];
}

@end
