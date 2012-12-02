#import "LUApnDevice.h"
#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"

@implementation LUApnDevice

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"apn_device"];
  }
}

#pragma mark -
#pragma mark Public Methods

- (NSDictionary *)parameters {
  return [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"development", @"lat", @"lng", @"token"]];
}

@end
