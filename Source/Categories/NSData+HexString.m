#import "NSData+HexString.h"

@implementation NSData (HexString)

- (NSString *)lu_hexString {
  NSMutableString *buffer = [NSMutableString stringWithCapacity:self.length * 2];

  const unsigned char *bytes = [self bytes];
  for (int i = 0; i < self.length; i++) {
    [buffer appendFormat:@"%02X", (int)bytes[i]];
  }

  return [NSString stringWithString:buffer];
}

@end
