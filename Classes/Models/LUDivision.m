#import <CoreLocation/CoreLocation.h>
#import "LUDivision.h"
#import "LUJSONDeserializer.h"

@implementation LUDivision

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"division"];
  }
}

#pragma mark -
#pragma mark Public Methods

- (CLLocation *)location {
  if (self.lat && self.lng) {
    return [[CLLocation alloc] initWithLatitude:[self.lat doubleValue] longitude:[self.lng doubleValue]];
  } else {
    return nil;
  }
}

@end
