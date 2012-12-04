#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUBundleRequest.h"

@implementation LUBundleRequest

+ (LUAPIRequest *)getBundlesForPage:(NSUInteger)page {
    NSString *path = [NSString stringWithFormat:@"users/%@/bundles", [LUAPIClient sharedClient].currentUserId];

    return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:@{@"page" : @(page)}];
}

@end
