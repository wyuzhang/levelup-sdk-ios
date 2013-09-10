// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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
  return [NSString stringWithFormat:@"LUAccessToken [address=%p, token=%@, userID=%@]", self, self.token, self.userID];
}

@end
