#import "LUDictionarySerializer.h"

@implementation LUDictionarySerializer

#pragma mark -
#pragma mark Public Methods

+ (NSDictionary *)parametersForModel:(id)model withAttributesNamed:(NSArray *)attributeNames {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];

  for (NSString *attributeName in attributeNames) {
    id value = [model valueForKey:attributeName];

    if (nil != value) {
      NSString *underscoredName = [self propertyNameForDictionary:attributeName];
      params[underscoredName] = value;
    }
  }

  return params;
}

+ (NSDictionary *)parametersForModel:(id)model withNonBlankAttributesNamed:(NSArray *)attributeNames {
  NSMutableArray *finalAttributeNames = [NSMutableArray arrayWithCapacity:[attributeNames count]];

  for (NSString *attributeName in attributeNames) {
    id value = [model valueForKey:attributeName];

    if ([value isKindOfClass:[NSString class]]) {
      if ([(NSString *)value length] > 0) {
        [finalAttributeNames addObject:attributeName];
      }
    } else {
      [finalAttributeNames addObject:attributeName];
    }
  }

  return [self parametersForModel:model withAttributesNamed:finalAttributeNames];
}

#pragma mark -
#pragma mark Private Methods

+ (NSString *)propertyNameForDictionary:(NSString *)string {
  if ([string isEqualToString:@"modelId"]) {
    // Special case since objects can't have properties called "id"
    return @"modelId";
  }

  NSMutableString *convertedString = [NSMutableString string];

  for (NSUInteger i = 0; i < [string length]; i++) {
    unichar oneChar = [string characterAtIndex:i];

    if ([[NSCharacterSet uppercaseLetterCharacterSet]
         characterIsMember:oneChar] && i > 0) {
      [convertedString appendFormat:@"_%C", oneChar];
    } else {
      [convertedString appendFormat:@"%C", oneChar];
    }
  }

  return [[convertedString lowercaseString]
          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
