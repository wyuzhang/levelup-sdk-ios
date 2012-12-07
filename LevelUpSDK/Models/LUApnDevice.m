#import "LUApnDevice.h"
#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"

@implementation LUApnDevice

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"apn_device"];
  }
}

#pragma mark - Public Methods

- (NSDictionary *)parameters {
  return [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"development", @"lat", @"lng", @"token"]];
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.development) {
    total += [self.development intValue] * 11;
  }
  if (self.lat) {
    total += [self.lat intValue] * 13;
  }
  if (self.lng) {
    total += [self.lng intValue] * 17;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 19;
  }
  if (self.token) {
    total += [self.token hash] * 21;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUApnDevice class]]) {
    LUApnDevice *otherApnDevice = (LUApnDevice *)otherObject;

    BOOL developmentEqual = ((!otherApnDevice.development && !self.development) ||
        (otherApnDevice.development && self.development &&
        [otherApnDevice.development intValue] == [self.development intValue]));

    BOOL latEqual = ((!otherApnDevice.lat && !self.lat) ||
        (otherApnDevice.lat && self.lat &&
        [otherApnDevice.lat intValue] == [self.lat intValue]));

    BOOL lngEqual = ((!otherApnDevice.lng && !self.lng) ||
        (otherApnDevice.lng && self.lng &&
        [otherApnDevice.lng intValue] == [self.lng intValue]));

    BOOL modelIdEqual = ((!otherApnDevice.modelId && !self.modelId) ||
        (otherApnDevice.modelId && self.modelId &&
        [otherApnDevice.modelId intValue] == [self.modelId intValue]));

    BOOL tokenEqual = ((!otherApnDevice.token && !self.token) ||
        (otherApnDevice.token && self.token &&
        [otherApnDevice.token isEqualToString:self.token]));

    return developmentEqual && latEqual && lngEqual && modelIdEqual && tokenEqual;
  }

  return NO;
}

@end
