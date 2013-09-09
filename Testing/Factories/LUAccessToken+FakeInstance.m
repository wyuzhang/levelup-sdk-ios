// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAccessToken+FakeInstance.h"

@implementation LUAccessToken (FakeInstance)

+ (LUAccessToken *)fakeInstance {
  return [[LUAccessToken alloc] initWithToken:@"token" userID:@1];
}

@end
