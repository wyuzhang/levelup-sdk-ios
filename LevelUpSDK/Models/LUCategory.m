#import "LUCategory.h"
#import "LUJSONDeserializer.h"

@implementation LUCategory

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"category"];
  }
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.modelId) {
    total += [self.modelId intValue] * 11;
  }
  if (self.name) {
    total += [self.name hash] * 13;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUCategory class]]) {
    LUCategory *otherCategory = (LUCategory *)otherObject;

    BOOL modelIdEqual = ((!otherCategory.modelId && !self.modelId) ||
        (otherCategory.modelId && self.modelId &&
        [otherCategory.modelId intValue] == [self.modelId intValue]));

    BOOL nameEqual = ((!otherCategory.name && !self.name) ||
        (otherCategory.name && self.name &&
        [otherCategory.name isEqualToString:self.name]));

    return modelIdEqual && nameEqual;
  }

  return NO;
}

@end
