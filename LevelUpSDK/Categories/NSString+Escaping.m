#import "NSString+Escaping.h"

@implementation NSString (Escaping)

static NSCharacterSet *normalizedCharacterSet;

- (NSString *)searchNormalizedString {
  if (nil == normalizedCharacterSet) {
    normalizedCharacterSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
  }

  return [[[self lowercaseString] componentsSeparatedByCharactersInSet:normalizedCharacterSet] componentsJoinedByString:@""];
}

@end
