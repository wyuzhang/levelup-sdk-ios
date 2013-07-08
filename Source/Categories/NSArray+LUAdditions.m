#import "NSArray+LUAdditions.h"

@implementation NSArray (LUAdditions)

- (id)lu_firstObject {
  if (self.count <= 0) {
    return nil;
  }

  return [self objectAtIndex:0];
}

- (NSArray *)lu_mappedArrayWithBlock:(id (^)(id obj))block {
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
