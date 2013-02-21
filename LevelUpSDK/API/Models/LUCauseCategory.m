#import "LUCauseCategory.h"

@implementation LUCauseCategory

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"CauseCategory [ID=%@, name=%@]", self.causeCategoryID, self.name];
}

@end
