// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULocation.h"

@interface LULocation (Fixtures)

+ (LULocation *)fixture;
+ (LULocation *)fixtureWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;
+ (LULocation *)fixtureWithLocationID:(NSNumber *)locationID;
+ (LULocation *)fixtureWithNoExtendedAddress;

@end
