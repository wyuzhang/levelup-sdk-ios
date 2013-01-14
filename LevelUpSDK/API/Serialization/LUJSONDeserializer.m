#import "LUAPIClient.h"
#import "LUJSONDeserializer.h"

@implementation LUJSONDeserializer

static NSMutableDictionary *registeredModels;

+ (id)deserializeJSON:(id)JSON {
  if ([JSON isKindOfClass:[NSArray class]]) {
    return [self parseArray:JSON];
  } else if ([JSON isKindOfClass:[NSDictionary class]]) {
    return [self parseDictionary:JSON];
  } else if (![JSON isEqual:[NSNull null]]) {
    return JSON;
  } else {
    return nil;
  }
}

+ (void)registerModel:(Class)model withIdentifier:(NSString *)identifier {
  [self registerModel:model withIdentifiers:@[identifier]];
}

+ (void)registerModel:(Class)model withIdentifiers:(NSArray *)identifiers {
  if (!registeredModels) {
    registeredModels = [[NSMutableDictionary alloc] init];
  }

  for (NSString *identifier in identifiers) {
    [registeredModels setObject:NSStringFromClass(model) forKey:identifier];
  }
}

#pragma mark -
#pragma mark Private Methods

+ (id)parseArray:(NSArray *)array {
  NSMutableArray *parsed = [NSMutableArray array];
  for (id subJSON in array) {
    [parsed addObject:[self deserializeJSON:subJSON]];
  }

  return parsed;
}

+ (id)parseDictionary:(NSDictionary *)dictionary {
  NSMutableDictionary *parsedValues = [NSMutableDictionary dictionary];

  for (NSString *key in [dictionary allKeys]) {
    parsedValues[key] = [self parseProperties:dictionary[key] intoModel:key];
  }

  if (parsedValues.count == 1) {
    return [parsedValues allValues][0];
  } else {
    return parsedValues;
  }
}

+ (id)parseProperties:(NSDictionary *)properties intoModel:(NSString *)modelName {
  if (!registeredModels[modelName]) {
    return properties;
  }

  Class modelClass = NSClassFromString(registeredModels[modelName]);
  id model = [[modelClass alloc] init];

  for (NSString *propertyName in properties) {
    id propertyValue = properties[propertyName];

    NSString *propertyNameForModel = [self propertyNameForModel:propertyName];

    if ([model respondsToSelector:NSSelectorFromString(propertyNameForModel)]) {
      id propertyValueForModel;
      if ([propertyValue isKindOfClass:[NSDictionary class]]) {
        propertyValueForModel = [self deserializeJSON:@{propertyName : propertyValue}];
      } else {
        propertyValueForModel = [self deserializeJSON:propertyValue];
      }

      [model setValue:propertyValueForModel forKey:propertyNameForModel];
    }
  }

  return model;
}

+ (NSString *)propertyNameForModel:(NSString *)string {
  if ([string isEqualToString:@"id"]) {
    // Special case since objects can't have properties called "id"
    return @"modelId";
  }

  NSArray *components = [string componentsSeparatedByString:@"_"];
  NSMutableString *output = [NSMutableString string];

  for (NSUInteger i = 0; i < components.count; i++) {
    if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[components[i] characterAtIndex:0]]) {
      [output appendFormat:@"_%@", components[i]];
    } else if (i == 0) {
      [output appendString:components[i]];
    } else {
      [output appendString:[components[i] capitalizedString]];
    }
  }

  return [NSString stringWithString:output];
}

@end
