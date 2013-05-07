#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"
#import "NSDate+StringFormats.h"

@implementation NSDictionary (ObjectClassAccess)

#pragma mark - Public Methods

- (NSArray *)arrayForKey:(id)aKey {
  return [self objectForKey:aKey ofClass:[NSArray class]];
}

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

- (NSDictionary *)dictionaryForKey:(id)aKey {
  return [self objectForKey:aKey ofClass:[NSDictionary class]];
}

- (float)floatForKey:(id)aKey {
  NSNumber *numberValue = [self numberForKey:aKey];
  if (!numberValue) return 0.0f;

  return [numberValue floatValue];
}

- (NSNumber *)numberForKey:(id)aKey {
  NSNumber *number = [self objectForKey:aKey ofClass:[NSNumber class]];
  if (number) return number;

  NSString *string = [self stringForKey:aKey];
  if (!string) return nil;

  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  return [formatter numberFromString:string];
}

- (NSString *)stringForKey:(id)aKey {
  return [self objectForKey:aKey ofClass:[NSString class]];
}

- (NSURL *)URLForKey:(id)aKey {
  NSString *string = [self objectForKey:aKey ofClass:[NSString class]];
  if (!string) return nil;

  return [NSURL URLWithString:string];
}

#pragma mark - Private Methods

- (id)objectForKey:(id)aKey ofClass:(Class)aClass {
  id value = [self objectForKey:aKey];
  if (!value || ![value isKindOfClass:aClass]) return nil;

  return value;
}

@end
