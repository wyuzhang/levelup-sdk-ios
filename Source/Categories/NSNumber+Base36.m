#import "NSNumber+Base36.h"

@implementation NSNumber (Base36)

- (NSString *)base36Value {
  NSString *base36 = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  NSInteger integerValue = [self integerValue];

  NSString *returnValue = [NSString string];

  do {
    returnValue = [NSString stringWithFormat:@"%c%@", [base36 characterAtIndex:integerValue % base36.length], returnValue];
    integerValue /= base36.length;
  } while (integerValue > 0);

  return returnValue;
}

@end
