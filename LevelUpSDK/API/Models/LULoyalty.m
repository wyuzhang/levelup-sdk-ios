#import "LULoyalty.h"

@implementation LULoyalty

#pragma mark - Public Methods

- (float)progress {
  return self.progressPercent * 0.01f;
}

- (void)setProgress:(float)progress {
  self.progressPercent = progress * 100.0f;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"Loyalty [ID=%@, merchantID=%@, ordersCount=%@, potentialCredit=%@, progressPercent=%@, savings=%@, shouldSpend=%@, spendRemaining=%@, totalVolume=%@, willEarn=%@]",
          self.loyaltyID, self.merchantID, self.ordersCount, self.potentialCredit, @(self.progressPercent),
          self.savings, self.shouldSpend, self.spendRemaining, self.totalVolume, self.willEarn];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Loyalty [ID=%@, merchantID=%@]", self.loyaltyID, self.merchantID];
}

@end
