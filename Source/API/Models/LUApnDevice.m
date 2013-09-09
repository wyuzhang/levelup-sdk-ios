// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUApnDevice.h"

@implementation LUApnDevice

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUApnDevice [development=%@, ID=%@, lat=%@, lng=%@, token=%@]", @(self.development),
          self.apnDeviceID, self.lat, self.lng, self.token];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUApnDevice [ID=%@, token=%@]", self.apnDeviceID, self.token];
}

@end
