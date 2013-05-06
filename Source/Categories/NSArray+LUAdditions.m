#import "NSArray+LUAdditions.h"

@implementation NSArray (LUAdditions)

- (id)firstObject {
  if (self.count <= 0) {
    return nil;
  }

  return [self objectAtIndex:0];
}

- (NSArray *)mappedArrayWithBlock:(id (^)(id obj))block {
  NSMutableArray *new = [NSMutableArray array];

  for (id obj in self) {
    id newObj = block(obj);
    if (newObj) {
      [new addObject:newObj];
    }
  }

  return new;
}

@end
