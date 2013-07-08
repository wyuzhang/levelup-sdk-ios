#import "NSDictionary+SafetyAdditions.h"

@implementation NSDictionary (SafetyAdditions)

- (id)lu_safeValueForKey:(NSString *)key {
  id value = [self valueForKey:key];
  if (value == [NSNull null]) {
    value = nil;
  }

  return value;
}

@end

@implementation NSMutableDictionary (SafetyAdditions)

- (void)lu_setSafeValue:(id)value forKey:(NSString *)key {
  if (!value) {
    value = [NSNull null];
  }

  [self setValue:value forKey:key];
}

@end
