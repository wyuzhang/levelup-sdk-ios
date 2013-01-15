#import "LUAPIModel.h"
#import "LUParameterSerializer.h"

@implementation LUParameterSerializer

#pragma mark - Public Methods

+ (NSDictionary *)nonBlankParametersForModel:(LUAPIModel *)model attributes:(NSArray *)attributes {
  return [self parametersForModel:model attributes:attributes allowBlank:NO];
}

+ (NSDictionary *)parametersForModel:(LUAPIModel *)model attributes:(NSArray *)attributes {
  return [self parametersForModel:model attributes:attributes allowBlank:YES];
}

#pragma mark - Private Methods

+ (NSDictionary *)parametersForModel:(LUAPIModel *)model attributes:(NSArray *)attributes allowBlank:(BOOL)allowBlank {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

  for (NSString *attribute in attributes) {
    id value = [model valueForKey:attribute];

    if (value) {
      if (allowBlank || ![value isKindOfClass:[NSString class]] || [value length] > 0) {
        parameters[[self propertyNameForDictionary:attribute]] = value;
      }
    }
  }

  return parameters;
}

+ (NSString *)propertyNameForDictionary:(NSString *)string {
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

  return [[convertedString lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
