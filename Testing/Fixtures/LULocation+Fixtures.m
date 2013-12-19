// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULocation+Fixtures.h"
#import "LUWebLocations.h"
#import "LUWebLocations+Fixtures.h"

@implementation LULocation (Fixtures)

+ (LULocation *)fixture {
  return [[LULocation alloc] initWithCategoryIDs:@[@1, @2]
                                 descriptionHTML:@"pizza, pizza, pizza!"
                                 extendedAddress:@"Apt E"
                                           hours:@"Mon-Fri 9am-5pm"
                                        latitude:@70
                                        locality:@"Boston"
                                      locationID:@1
                                       longitude:@-45
                                      merchantID:@2
                                    merchantName:@"Test Merchant"
                                            name:@"Test Location"
                                           phone:@"(123) 123-1234"
                                      postalCode:@"01234"
                                          region:@"MA"
                                           shown:YES
                                   streetAddress:@"123 Main St."
                                   updatedAtDate:[NSDate date]
                                    webLocations:[LUWebLocations fixture]];
}

+ (LULocation *)fixtureWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
  LULocation *location = [self fixture];
  [location setValue:latitude forKey:@"latitude"];
  [location setValue:longitude forKey:@"longitude"];
  return location;
}

+ (LULocation *)fixtureWithLocationID:(NSNumber *)locationID {
  LULocation *location = [self fixture];
  [location setValue:locationID forKey:@"locationID"];
  return location;
}

+ (LULocation *)fixtureWithNoExtendedAddress {
  LULocation *location = [self fixture];
  [location setValue:nil forKey:@"extendedAddress"];
  return location;
}

@end
