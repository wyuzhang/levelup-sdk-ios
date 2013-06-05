#import "LUAccessToken.h"

@implementation LUAccessToken

#pragma mark - Creation

- (id)initWithToken:(NSString *)token userID:(NSNumber *)userID {
  self = [super init];
  if (!self) return nil;

  _token = token;
  _userID = userID;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUAccessToken [token=%@, userID=%@]", self.token, self.userID];
}

@end
