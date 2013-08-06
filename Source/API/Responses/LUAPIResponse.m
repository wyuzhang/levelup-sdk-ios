#import "LUAPIResponse.h"
#import "LUWebLinkParser.h"

@implementation LUAPIResponse

- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)HTTPURLResponse {
  self = [super init];
  if (!self) return nil;

  _HTTPURLResponse = HTTPURLResponse;

  return self;
}

- (NSURL *)nextPageURL {
  NSString *linkHeader = [self.HTTPURLResponse allHeaderFields][@"Link"];
  LUWebLinkParser *webLink = [[LUWebLinkParser alloc] initWithHeaderValue:linkHeader];
  return webLink.nextURL;
}

@end
