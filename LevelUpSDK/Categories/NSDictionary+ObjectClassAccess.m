#import "LUMonetaryValueModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"
#import "NSDate+StringFormats.h"

@implementation NSDictionary (ObjectClassAccess)

#pragma mark - Public Methods

- (BOOL)boolForKey:(id)aKey {
  NSNumber *numberValue = [self numberForKey:aKey];
  if (!numberValue) return NO;

  return [numberValue boolValue];
}

- (NSDate *)dateForKey:(id)aKey {
  NSString *stringValue = [self stringForKey:aKey];
  if (!stringValue) return nil;

  return [NSDate dateFromIso8601DateTimeString:stringValue];
}

- (float)floatForKey:(id)aKey {
  NSNumber *numberValue = [self numberForKey:aKey];
  if (!numberValue) return 0.0f;

  return [numberValue floatValue];
}

- (NSNumber *)numberForKey:(id)aKey {
  NSNumber *number = [self objectForKey:aKey ofClass:[NSNumber class]];
  if (number) return number;

  NSString *string = [self objectForKey:aKey ofClass:[NSString class]];
  if (!string) return nil;

  return [NSNumber numberWithDouble:[string doubleValue]];
}

- (LUMonetaryValue *)monetaryValueForKey:(id)aKey {
  return [[LUMonetaryValueModelBuilder builder] buildModelFromJSON:[self objectForKey:aKey]];
}

- (NSString *)stringForKey:(id)aKey {
  return [self objectForKey:aKey ofClass:[NSString class]];
}

#pragma mark - Private Methods

- (id)objectForKey:(id)aKey ofClass:(Class)aClass {
  id value = [self objectForKey:aKey];
  if (!value || ![value isKindOfClass:aClass]) return nil;

  return value;
}

@end
