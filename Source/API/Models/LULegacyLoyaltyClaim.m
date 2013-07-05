#import "LULegacyLoyaltyClaim.h"

@implementation LULegacyLoyaltyClaim

#pragma mark - Creation

- (id)initWithClaim:(LUClaim *)claim merchant:(LUMerchant *)merchant {
  self = [super init];
  if (!self) return nil;

  _claim = claim;
  _merchant = merchant;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LULegacyLoyaltyClaim [claim=%@, merchant=%@]", self.claim, self.merchant];
}

@end
