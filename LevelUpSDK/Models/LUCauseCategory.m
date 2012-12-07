#import "LUCauseCategory.h"
#import "LUJSONDeserializer.h"

@implementation LUCauseCategory

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"cause_category"];
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
  if(otherObject && [otherObject isKindOfClass:[LUCauseCategory class]]) {
    LUCauseCategory *otherCauseCategory = (LUCauseCategory *)otherObject;

    BOOL modelIdEqual = ((!otherCauseCategory.modelId && !self.modelId) ||
        (otherCauseCategory.modelId && self.modelId &&
        [otherCauseCategory.modelId intValue] == [self.modelId intValue]));

    BOOL nameEqual = ((!otherCauseCategory.name && !self.name) ||
        (otherCauseCategory.name && self.name &&
        [otherCauseCategory.name isEqualToString:self.name]));

    return modelIdEqual && nameEqual;
  }

  return NO;
}

@end
