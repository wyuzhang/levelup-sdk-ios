#import "LUBundle.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@interface LUBundle ()

@property (nonatomic, copy) NSString *state;

@end

@implementation LUBundle

#pragma mark - Public Methods

- (BOOL)hasChargeData {
  return (self.chargedAt != nil);
}

- (BOOL)hasNonZeroBalance {
  return (self.amount.amount.floatValue != 0.0f);
}

- (BOOL)hasSavings {
  return (self.totalCreditUsed.amount.floatValue > 0.0f);
}

- (BOOL)isClosed {
  return [self.state isEqualToString:@"closed"];
}

- (NSArray *)ordersAndRefunds {
  NSArray *mergedOrders = [self.orders arrayByAddingObjectsFromArray:self.refunds];
  return [mergedOrders sortedArrayUsingComparator:^(id a, id b) {
    NSString *objectACreationDate = [a valueForKey:@"createdAt"];
    NSString *objectBCreationDate = [b valueForKey:@"createdAt"];

    return [objectBCreationDate compare:objectACreationDate];
  }];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat: @"Bundle [amount=%@, ID=%@, chargedAt=%@, createdAt=%@, last4CreditCardDigits=%@, orders=%@, refunds=%@, state=%@, totalCreditUsed=%@]",
          self.amount, self.bundleID, self.chargedAt, self.createdAt, self.last4CreditCardDigits, self.orders,
          self.refunds, self.state, self.totalCreditUsed];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Bundle [amount=%@, createdAt=%@, ID=%@, state=%@]", self.amount, self.createdAt,
          self.bundleID, self.state];
}

@end
