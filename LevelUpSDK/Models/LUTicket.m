#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"
#import "LUTicket.h"

@implementation LUTicket

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"ticket"];
  }
}

#pragma mark -
#pragma mark Public Methods

- (NSDictionary *)parameters {
  return [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"body"]];
}

@end
