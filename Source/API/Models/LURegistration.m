// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LURegistration.h"

@implementation LURegistration

#pragma mark - Creation

- (id)initWithAppName:(NSString *)appName facebook:(BOOL)facebook registrationDescription:(NSString *)registrationDescription {
  self = [super init];
  if (!self) return nil;

  _appName = appName;
  _facebook = facebook;
  _registrationDescription = registrationDescription;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat: @"LURegistration [address=%p, appName=%@, facebook=%@, registrationDescription=%@]",
          self, self.appName, @(self.facebook), self.registrationDescription];
}

@end
