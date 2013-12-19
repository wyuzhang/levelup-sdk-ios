// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAccessToken+Fixtures.h"

@implementation LUAccessToken (Fixtures)

+ (LUAccessToken *)fixture {
  return [[LUAccessToken alloc] initWithToken:@"token" userID:@1];
}

@end
