#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"
#import "LUTicket.h"

@implementation LUTicket

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"ticket"];
  }
}

#pragma mark - Public Methods

- (NSDictionary *)parameters {
  return [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"body"]];
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.body) {
    total += [self.body hash] * 11;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 13;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUTicket class]]) {
    LUTicket *otherTicket = (LUTicket*)otherObject;

    BOOL bodyEqual = ((!otherTicket.body && !self.body) ||
        (otherTicket.body && self.body &&
        [otherTicket.body isEqualToString:self.body]));

    BOOL modelIdEqual = ((!otherTicket.modelId && !self.modelId) ||
        (otherTicket.modelId && self.modelId &&
        [otherTicket.modelId intValue] ==[self.modelId intValue]));

    return bodyEqual && modelIdEqual;
  }

  return NO;
}
@end
