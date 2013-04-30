#import "LUCategory.h"

@implementation LUCategory

#pragma mark - Creation

- (id)initWithCategoryID:(NSNumber *)categoryID name:(NSString *)name {
  self = [super init];
  if (!self) return nil;

  _categoryID = categoryID;
  _name = name;

  return self;
}


#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCategory [ID=%@, name=%@]", self.categoryID, self.name];
}

@end
