#import "LUCauseCategory.h"

@implementation LUCauseCategory

#pragma mark - Creation

- (id)initWithCauseCategoryID:(NSNumber *)causeCategoryID name:(NSString *)name {
  self = [super init];
  if (!self) return nil;

  _causeCategoryID = causeCategoryID;
  _name = name;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCauseCategory [ID=%@, name=%@]", self.causeCategoryID, self.name];
}

@end
