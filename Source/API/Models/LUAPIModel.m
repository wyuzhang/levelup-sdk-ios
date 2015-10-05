/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUAPIModel.h"
#import <objc/runtime.h>

@interface LUAPIModel ()

@property (nonatomic, copy, readonly) NSDictionary *codableProperties;

@end

@implementation LUAPIModel {
  NSDictionary *_codableProperties;
}

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
  if (!otherObject || [otherObject class] != [self class]) {
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

#pragma mark - NSSecureCoding Methods

+ (BOOL)supportsSecureCoding {
  return YES;
}

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if (!self) return nil;

  for (NSString *key in self.codableProperties) {
    Class propertyClass = self.codableProperties[key];

    id object = [decoder decodeObjectOfClass:propertyClass forKey:key];
    if (object) {
      [self setValue:object forKey:key];
    }
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  for (NSString *key in self.codableProperties) {
    id object = [self valueForKey:key];
    if (object) {
      [coder encodeObject:object forKey:key];
    }
  }
}

#pragma mark - Private

+ (NSDictionary *)codableProperties {
  NSMutableDictionary *codableProperties = [NSMutableDictionary dictionary];

  unsigned int outCount, i;
  objc_property_t *properties = class_copyPropertyList(self, &outCount);
  for (i = 0; i < outCount; i++) {
    objc_property_t property = properties[i];
    const char *propName = property_getName(property);

    NSString *attribute = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];

    char *propertyIVar = property_copyAttributeValue(property, "V");
    BOOL iVarPresent = propertyIVar != NULL;
    free(propertyIVar);

    if (!iVarPresent || [@"codableProperties" isEqual:attribute]) {
      continue;
    }

    Class propertyClass = nil;
    char *typeEncoding = property_copyAttributeValue(property, "T");
    switch (typeEncoding[0]) {
      case '@': {
        if (strlen(typeEncoding) >= 3) {
          char *className = strndup(typeEncoding + 2, strlen(typeEncoding) - 3);
          NSString *name = [NSString stringWithCString:className encoding:NSUTF8StringEncoding];
          NSRange range = [name rangeOfString:@"<"];
          if (range.location != NSNotFound) {
            name = [name substringToIndex:range.location];
          }
          propertyClass = NSClassFromString(name) ?: [NSObject class];
          free(className);
        }
        break;
      }
      case 'c':
      case 'i':
      case 's':
      case 'l':
      case 'q':
      case 'C':
      case 'I':
      case 'S':
      case 'L':
      case 'Q':
      case 'f':
      case 'd':
      case 'B': {
        propertyClass = [NSNumber class];
        break;
      }
      case '{': {
        propertyClass = [NSValue class];
        break;
      }
    }
    free(typeEncoding);

    if (propertyClass) {
      codableProperties[attribute] = propertyClass;
    }
  }
  free(properties);

  return codableProperties;
}

- (NSDictionary *)codableProperties {
  if (!_codableProperties) {
    NSMutableDictionary *codableProperties = [NSMutableDictionary dictionary];

    Class cls = [self class];
    while (cls && (cls != [LUAPIModel superclass])) {
      [codableProperties addEntriesFromDictionary:[cls codableProperties]];

      cls = [cls superclass];
    }

    _codableProperties = [NSDictionary dictionaryWithDictionary:codableProperties];
  }

  return _codableProperties;
}

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
  for (i = 0; i < outCount; i++) {
    objc_property_t property = properties[i];
    const char *propName = property_getName(property);

    NSString *attribute = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];

    if (![@[@"class", @"hash", @"description", @"debugDescription"] containsObject:attribute]) {
      [classProperties addObject:attribute];
    }
  }
  free(properties);

  return classProperties;
}

@end
