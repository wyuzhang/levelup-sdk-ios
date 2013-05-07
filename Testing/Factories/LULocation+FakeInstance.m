#import "LULocation+FakeInstance.h"
#import "LUWebLocations.h"

@implementation LULocation (FakeInstance)

+ (LULocation *)fakeInstance {
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
                                    webLocations:[LUWebLocations fakeInstance]
          ];
}

+ (LULocation *)fakeInstanceWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
  LULocation *location = [self fakeInstance];
  [location setValue:latitude forKey:@"latitude"];
  [location setValue:longitude forKey:@"longitude"];
  return location;
}

+ (LULocation *)fakeInstanceWithLocationID:(NSNumber *)locationID {
  LULocation *location = [self fakeInstance];
  [location setValue:locationID forKey:@"locationID"];
  return location;
}

+ (LULocation *)fakeInstanceWithNoExtendedAddress {
  LULocation *location = [self fakeInstance];
  [location setValue:nil forKey:@"extendedAddress"];
  return location;
}

@end
