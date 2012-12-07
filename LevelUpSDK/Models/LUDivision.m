#import <CoreLocation/CoreLocation.h>
#import "LUDivision.h"
#import "LUJSONDeserializer.h"

@implementation LUDivision

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"division"];
  }
}

#pragma mark - Public Methods

- (CLLocation *)location {
  if (self.lat && self.lng) {
    return [[CLLocation alloc] initWithLatitude:[self.lat doubleValue] longitude:[self.lng doubleValue]];
  } else {
    return nil;
  }
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.lat) {
    total += [self.lat intValue] * 11;
  }
  if (self.lng) {
    total += [self.lng intValue] * 13;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 17;
  }
  if (self.name) {
    total += [self.name hash] * 19;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUDivision class]]) {
    LUDivision *otherDivision = (LUDivision *)otherObject;

    BOOL latEqual = ((!otherDivision.lat && !self.lat) ||
        (otherDivision.lat && self.lat &&
        [otherDivision.lat intValue] == [self.lat intValue]));

    BOOL lngEqual = ((!otherDivision.lng && !self.lng) ||
        (otherDivision.lng && self.lng &&
        [otherDivision.lng intValue] == [self.lng intValue]));

    BOOL modelIdEqual = ((!otherDivision.modelId && !self.modelId) ||
        (otherDivision.modelId && self.modelId &&
        [otherDivision.modelId intValue] == [self.modelId intValue]));

    BOOL nameEqual = ((!otherDivision.name && !self.name) ||
        (otherDivision.name && self.name &&
        [otherDivision.name isEqualToString:self.name]));

    return latEqual && lngEqual && modelIdEqual && nameEqual;
  }

  return NO;
}

@end
