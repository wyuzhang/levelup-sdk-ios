// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULoyalty.h"

@implementation LULoyalty

#pragma mark - Creation

- (id)initWithMerchantID:(NSNumber *)merchantID merchantLoyaltyEnabled:(BOOL)merchantLoyaltyEnabled
             ordersCount:(NSNumber *)ordersCount potentialCredit:(LUMonetaryValue *)potentialCredit
         progressPercent:(float)progressPercent savings:(LUMonetaryValue *)savings
             shouldSpend:(LUMonetaryValue *)shouldSpend spendRemaining:(LUMonetaryValue *)spendRemaining
             totalVolume:(LUMonetaryValue *)totalVolume willEarn:(LUMonetaryValue *)willEarn {
  self = [super init];
  if (!self) return nil;

  _merchantID = merchantID;
  _merchantLoyaltyEnabled = merchantLoyaltyEnabled;
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
          @"LULoyalty [address=%p, merchantID=%@, merchantLoyaltyEnabled=%@, ordersCount=%@, potentialCredit=%@, progressPercent=%@, savings=%@, shouldSpend=%@, spendRemaining=%@, totalVolume=%@, willEarn=%@]",
          self, self.merchantID, @(self.merchantLoyaltyEnabled), self.ordersCount, self.potentialCredit,
          @(self.progressPercent), self.savings, self.shouldSpend, self.spendRemaining, self.totalVolume, self.willEarn];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LULoyalty [address=%p, merchantID=%@]", self, self.merchantID];
}

@end
