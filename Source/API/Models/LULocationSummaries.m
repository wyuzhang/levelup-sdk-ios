#import "LULocationSummaries.h"

@implementation LULocationSummaries

#pragma mark - Creation

- (id)initWithLocations:(NSArray *)locations nextPageURL:(NSURL *)nextPageURL {
  self = [super init];
  if (!self) return nil;

  _locations = locations;
  _nextPageURL = nextPageURL;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LULocationSummaries [locations=%@, nextPageURL=%@]", self.locations,
          self.nextPageURL];
}

@end
