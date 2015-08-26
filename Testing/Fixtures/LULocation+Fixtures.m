/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LULocation+Fixtures.h"
#import "LUMonetaryValue.h"
#import "LUWebLocations.h"
#import "LUWebLocations+Fixtures.h"

@implementation LULocation (Fixtures)

+ (LULocation *)fixture {
  return [[LULocation alloc] initWithCategoryIDs:@[@1, @2]
                                   categoryNames:@[@"American", @"Pizza"]
                                 deliveryMenuURL:[NSURL URLWithString:@"http://pizza.com/delivery"]
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
                                   pickupMenuURL:[NSURL URLWithString:@"http://pizza.com/pickup"]
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
