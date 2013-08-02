#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"

@implementation LUAuthenticatedAPIRequest

- (NSMutableURLRequest *)URLRequest {
  NSMutableURLRequest *URLRequest = [super URLRequest];

  if ([LUAPIClient sharedClient].accessToken) {
    NSString *authorization = [NSString stringWithFormat:@"token %@", [LUAPIClient sharedClient].accessToken];

    [URLRequest addValue:authorization forHTTPHeaderField:@"Authorization"];
  }

  return URLRequest;
}

@end
