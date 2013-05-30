#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"

@implementation LUAuthenticatedAPIRequest

- (NSMutableURLRequest *)urlRequest {
  NSMutableURLRequest *urlRequest = [super urlRequest];

  if ([LUAPIClient sharedClient].accessToken) {
    NSString *authorization = [NSString stringWithFormat:@"token %@", [LUAPIClient sharedClient].accessToken];

    [urlRequest addValue:authorization forHTTPHeaderField:@"Authorization"];
  }

  return urlRequest;
}

@end
