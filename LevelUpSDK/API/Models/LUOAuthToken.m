#import "LUOAuthToken.h"

@implementation LUOAuthToken

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"OAuthToken [accessToken=%@, xUserId=%@]", self.accessToken, self.xUserId];
}

@end
