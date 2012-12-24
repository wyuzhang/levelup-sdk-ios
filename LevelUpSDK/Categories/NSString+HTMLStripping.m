#import "NSString+HTMLStripping.h"

@implementation NSString (HTMLStripping)

// Adapted from http://stackoverflow.com/a/4886998
- (NSString *)stringByStrippingHTML {
  NSString *s = [self copy];

  NSRange r;
  while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
    s = [s stringByReplacingCharactersInRange:r withString:@""];
  }

  return s;
}

@end
