#import "LUUserWithAccessToken.h"

@implementation LUUserWithAccessToken

#pragma mark - Creation

- (id)initWithAccessToken:(LUAccessToken *)accessToken user:(LUUser *)user {
  self = [super init];
  if (!self) return nil;

  _accessToken = accessToken;
  _user = user;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat: @"LUUserWithAccessToken [address=%p, accessToken=%@, user=%@]",
          self, self.accessToken, self.user];
}

@end
