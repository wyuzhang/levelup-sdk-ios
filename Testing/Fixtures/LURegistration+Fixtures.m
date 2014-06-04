// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LURegistration+Fixtures.h"

@implementation LURegistration (Fixtures)

+ (LURegistration *)fixture {
  return [[LURegistration alloc] initWithAppName:@"Test App" facebook:NO registrationDescription:@"Test Description"];
}

@end
