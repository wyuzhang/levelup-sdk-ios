#import "LULoyalty.h"

@implementation LULoyalty

#pragma mark - Public Methods

- (float)progress {
  return self.progressPercent * 0.01f;
}

- (void)setProgress:(float)progress {
  self.progressPercent = progress * 100.0f;
}

@end
