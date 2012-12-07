#import "LUCause.h"
#import "LUDonation.h"
#import "LUJSONDeserializer.h"
#import "LUMonetaryValue.h"

@implementation LUDonation

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"donation"];
  }
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.cause) {
    total += [self.cause hash] * 11;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 13;
  }
  if (self.value) {
    total += [self.value hash] * 17;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUDonation class]]) {
    LUDonation *otherDonation = (LUDonation *)otherObject;

    BOOL causeEqual = ((!otherDonation.cause && !self.cause) ||
        (otherDonation.cause && self.cause &&
        [otherDonation.cause isEqual:self.cause]));

    BOOL modelIdEqual = ((!otherDonation.modelId && !self.modelId) ||
        (otherDonation.modelId && self.modelId &&
        [otherDonation.modelId intValue] == [self.modelId intValue]));

    BOOL valueEqual = ((!otherDonation.value && !self.value) ||
        (otherDonation.value && self.value &&
        [otherDonation.value isEqual:self.value]));

    return causeEqual && modelIdEqual && valueEqual;
  }

  return NO;
}

@end
