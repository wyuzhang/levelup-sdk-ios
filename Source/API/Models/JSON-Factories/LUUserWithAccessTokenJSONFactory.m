// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAccessToken.h"
#import "LUAccessTokenJSONFactory.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "LUUserWithAccessToken.h"
#import "LUUserWithAccessTokenJSONFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUUserWithAccessTokenJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUAccessToken *accessToken = [[LUAccessTokenJSONFactory factory] fromJSONObject:[attributes lu_safeValueForKey:@"access_token"]];
  LUUser *user = [[LUUserJSONFactory factory] fromJSONObject:[attributes lu_safeValueForKey:@"user"]];

  return [[LUUserWithAccessToken alloc] initWithAccessToken:accessToken user:user];
}

@end
