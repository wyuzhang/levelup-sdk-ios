#import "LULocation+FakeInstance.h"

@implementation LULocation (FakeInstance)

+ (LULocation *)fakeInstance {
  return [[LULocation alloc] initWithExtendedAddress:@"Apt E"
                                               hours:@"Mon-Fri 9am-5pm"
                                                 lat:@70
                                            locality:@"Boston"
                                          locationID:@1
                                                 lng:@-45
                                                name:@"My Location"
                                               phone:@"(123) 123-1234"
                                          postalCode:@"01234"
                                              region:@"MA"
                                       streetAddress:@"123 Main St."];
}

+ (LULocation *)fakeInstanceWithLat:(NSNumber *)lat lng:(NSNumber *)lng {
  LULocation *location = [self fakeInstance];
  [location setValue:lat forKey:@"lat"];
  [location setValue:lng forKey:@"lng"];
  return location;
}

+ (LULocation *)fakeInstanceWithNoExtendedAddress {
  LULocation *location = [self fakeInstance];
  [location setValue:nil forKey:@"extendedAddress"];
  return location;
}

@end
