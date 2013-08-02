#import "LUInterstitialURLAction.h"

@implementation LUInterstitialURLAction

#pragma mark - Creation

- (id)initWithURL:(NSURL *)URL {
  self = [super init];
  if (!self) return nil;

  _URL = URL;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUInterstitialURLAction [URL=%@]", self.URL];
}

@end
