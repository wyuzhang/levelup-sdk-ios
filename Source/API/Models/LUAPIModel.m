// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"
#import <objc/runtime.h>

@implementation LUAPIModel

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  int prime = 11;
  NSUInteger total = [NSStringFromClass([self class]) hash] * prime;

  prime = [self primeAfter:prime];

  for (NSString *attribute in [self propertyNames]) {
    id value = [self valueForKey:attribute];

    if (value) {
      total += [value hash] * prime;
      prime = [self primeAfter:prime];
    }
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(!otherObject || [otherObject class] != [self class]) {
    return NO;
  }

  LUAPIModel *otherModel = (LUAPIModel *)otherObject;

  for (NSString *attribute in [self propertyNames]) {
    id value = [self valueForKey:attribute];
    id otherValue = [otherModel valueForKey:attribute];

    BOOL bothValuesNil = !value && !otherValue;
    BOOL valuesEqual = [value isEqual:otherValue];

    if (!bothValuesNil && !valuesEqual) {
      return NO;
    }
  }

  return YES;
}

#pragma mark - Private

- (BOOL)isPrime:(int)possiblePrime {
  for (int i = 2; i < possiblePrime; i++) {
    if (possiblePrime % i == 0) {
      return NO;
    }
  }

  return YES;
}

- (int)primeAfter:(int)prime {
  int nextPrime = prime + 1;

  while (![self isPrime:nextPrime]) {
    nextPrime++;
  }

  return nextPrime;
}

- (NSArray *)propertyNames {
  NSMutableArray *properties = [NSMutableArray array];

  Class cls = [self class];
  while (cls && (cls != [LUAPIModel superclass])) {
    [properties addObjectsFromArray:[self propertyNamesForClass:cls]];

    cls = [cls superclass];
  }

  return properties;
}

- (NSArray *)propertyNamesForClass:(Class)cls {
  NSMutableArray *classProperties = [NSMutableArray array];

  unsigned int outCount, i;
  objc_property_t *properties = class_copyPropertyList(cls, &outCount);
  for(i = 0; i < outCount; i++) {
    objc_property_t property = properties[i];
    const char *propName = property_getName(property);

    NSString *attribute = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
    [classProperties addObject:attribute];
  }
  free(properties);

  return classProperties;
}

@end
