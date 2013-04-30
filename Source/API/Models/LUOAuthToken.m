#import "LUOAuthToken.h"

@implementation LUOAuthToken

#pragma mark - Creation

- (id)initWithAccessToken:(NSString *)accessToken xUserID:(NSNumber *)xUserID {
  self = [super init];
  if (!self) return nil;

  _accessToken = accessToken;
  _xUserID = xUserID;

  return self;
}


#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOAuthToken [accessToken=%@, xUserID=%@]", self.accessToken,
          self.xUserID];
}

@end
