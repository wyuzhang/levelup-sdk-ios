#import "LUCategory.h"

@implementation LUCategory

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"Category [ID=%@, name=%@]", self.categoryID, self.name];
}

@end
