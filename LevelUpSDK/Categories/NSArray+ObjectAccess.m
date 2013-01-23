#import "NSArray+ObjectAccess.h"

@implementation NSArray (ObjectAccess)

- (id)firstObject {
  if (self.count <= 0) {
    return nil;
  }

  return [self objectAtIndex:0];
}

@end
