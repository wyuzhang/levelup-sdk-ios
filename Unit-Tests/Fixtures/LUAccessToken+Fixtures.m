// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAccessToken+Fixtures.h"

@implementation LUAccessToken (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"token" : @"access-token",
    @"user_id" : @1
  };
}

@end
