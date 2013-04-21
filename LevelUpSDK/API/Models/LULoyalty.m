#import "LULoyalty.h"

@implementation LULoyalty

#pragma mark - Creation

- (id)initWithLoyaltyID:(NSNumber *)loyaltyID merchantID:(NSNumber *)merchantID
            ordersCount:(NSNumber *)ordersCount potentialCredit:(LUMonetaryValue *)potentialCredit
        progressPercent:(float)progressPercent savings:(LUMonetaryValue *)savings
            shouldSpend:(LUMonetaryValue *)shouldSpend spendRemaining:(LUMonetaryValue *)spendRemaining
            totalVolume:(LUMonetaryValue *)totalVolume willEarn:(LUMonetaryValue *)willEarn {
  self = [super init];
  if (!self) return nil;

  _loyaltyID = loyaltyID;
  _merchantID = merchantID;
  _ordersCount = ordersCount;
  _potentialCredit = potentialCredit;
  _progressPercent = progressPercent;
  _savings = savings;
  _shouldSpend = shouldSpend;
  _spendRemaining = spendRemaining;
  _totalVolume = totalVolume;
  _willEarn = willEarn;

  return self;
}


#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LULoyalty [ID=%@, merchantID=%@, ordersCount=%@, potentialCredit=%@, progressPercent=%@, savings=%@, shouldSpend=%@, spendRemaining=%@, totalVolume=%@, willEarn=%@]",
          self.loyaltyID, self.merchantID, self.ordersCount, self.potentialCredit, @(self.progressPercent),
          self.savings, self.shouldSpend, self.spendRemaining, self.totalVolume, self.willEarn];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LULoyalty [ID=%@, merchantID=%@]", self.loyaltyID, self.merchantID];
}

@end
