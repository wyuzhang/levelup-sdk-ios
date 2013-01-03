#import "LUAPIClient.h"
#import "LUApnDevice.h"
#import "LUApnDeviceRequest.h"
#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"
#import "LUKeychainAccess.h"

static NSString * const DeviceIdentifierKey = @"LUDeviceToken";

@implementation LUApnDevice

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"apn_device"];
  }
}

#pragma mark - Public Methods

+ (void)registerDeviceToken:(NSData *)deviceToken sandbox:(BOOL)sandbox {
  NSString *deviceTokenString = [[[[deviceToken description]
                                   stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                                 stringByReplacingOccurrencesOfString:@" " withString:@""];

  [[LUKeychainAccess standardKeychainAccess] setString:deviceTokenString forKey:DeviceIdentifierKey];

  LUApnDevice *device = [[self alloc] init];
  device.token = deviceTokenString;

  if (sandbox) {
    device.development = @YES;
  }

  [[LUAPIClient sharedClient] performRequest:[LUApnDeviceRequest createApnDevice:device] success:nil failure:nil];
}

+ (void)unregisterDeviceToken {
  NSString *deviceToken = [[LUKeychainAccess standardKeychainAccess] stringForKey:DeviceIdentifierKey];

  if (deviceToken.length > 0) {
    LUApnDevice *device = [[self alloc] init];
    device.token = deviceToken;

    [[LUAPIClient sharedClient] performRequest:[LUApnDeviceRequest unregisterApnDevice:device] success:nil failure:nil];
  }
}

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
