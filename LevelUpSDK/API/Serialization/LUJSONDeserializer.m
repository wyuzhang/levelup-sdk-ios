#import "LUAPIClient.h"
#import "LUJSONDeserializer.h"

@implementation LUJSONDeserializer

static NSMutableDictionary *registeredModels;

+ (id)deserializeJSON:(id)JSON {
  if ([JSON isKindOfClass:[NSArray class]]) {
    NSMutableArray *parsed = [NSMutableArray array];
    for (id subJSON in JSON) {
      [parsed addObject:[self deserializeJSON:subJSON]];
    }

    return parsed;
  } else if ([JSON isKindOfClass:[NSDictionary class]]) {
    if ([JSON count] == 1) {
      if (!registeredModels[[JSON allKeys][0]]) {
        return [JSON allValues][0];
      }

      Class modelClass = NSClassFromString(registeredModels[[JSON allKeys][0]]);
      id model = [[modelClass alloc] init];

      NSDictionary *properties = [JSON allValues][0];
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
  }

  if ([JSON isEqual:[NSNull null]]) {
    return nil;
  } else {
    return JSON;
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
