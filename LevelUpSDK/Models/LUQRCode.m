#import "LUJSONDeserializer.h"
#import "LUQRCode.h"

@implementation LUQRCode

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"qr_code"];
  }
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.data) {
    total += [self.data hash] * 11;
  }
  if (self.dataImageUrl) {
    total += [self.dataImageUrl hash] * 13;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 17;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUQRCode class]]) {
    LUQRCode *otherQRCode = (LUQRCode *)otherObject;

    BOOL dataEqual = ((!otherQRCode.data && !self.data) ||
        (otherQRCode.data && self.data &&
        [otherQRCode.data isEqualToString:self.data]));

    BOOL dataImageUrlEqual = ((!otherQRCode.dataImageUrl && !self.dataImageUrl) ||
        (otherQRCode.dataImageUrl && self.dataImageUrl &&
        [otherQRCode.dataImageUrl isEqualToString:self.dataImageUrl]));

    BOOL modelIdEqual = ((!otherQRCode.modelId && !self.modelId) ||
        (otherQRCode.modelId && self.modelId &&
        [otherQRCode.modelId intValue] ==[self.modelId intValue]));

    return dataEqual && dataImageUrlEqual && modelIdEqual;
  }

  return NO;
}

@end
