#import "LUBundle.h"
#import "LUJSONDeserializer.h"
#import "LUOrder.h"
#import "LUMonetaryValue.h"
#import "NSDate+StringFormats.h"

@interface LUBundle ()

@property (nonatomic, copy) NSString *chargedAt;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *state;

@end

@implementation LUBundle

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"bundle"];
  }
}

#pragma mark - Public methods

- (NSDate *)chargeDate {
  return [NSDate dateFromIso8601DateTimeString:self.chargedAt];
}

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

- (BOOL)hasChargeData {
  return (self.chargedAt != nil);
}

- (BOOL)hasNonZeroBalance {
  return ([self.amount.amount floatValue] != 0.0f);
}

- (BOOL)hasSavings {
  return ([self.totalCreditUsed.amount floatValue] > 0.0f);
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

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.chargedAt) {
    total += [self.chargedAt hash] * 11;
  }
  if (self.createdAt) {
    total += [self.createdAt hash] * 13;
  }
  if (self.state) {
    total += [self.state hash] * 17;
  }
  if (self.amount) {
    total += [self.amount hash] * 19;
  }
  if (self.last_4) {
    total += [self.last_4 hash] * 23;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 29;
  }
  if (self.orders) {
    total += [self.orders hash] * 31;
  }
  if (self.refunds) {
    total += [self.refunds hash] * 37;
  }
  if (self.totalCreditUsed) {
    total += [self.totalCreditUsed hash] * 41;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUBundle class]]) {
    LUBundle *otherBundle = (LUBundle *)otherObject;

    BOOL chargedAtEqual = ((!otherBundle.chargedAt && !self.chargedAt) ||
        (otherBundle.chargedAt && self.chargedAt &&
        [otherBundle.chargedAt isEqualToString:self.chargedAt]));

    BOOL createdAtEqual = ((!otherBundle.createdAt && !self.createdAt) ||
        (otherBundle.createdAt && self.createdAt &&
        [otherBundle.createdAt isEqualToString:self.createdAt]));

    BOOL stateEqual = ((!otherBundle.state && !self.state) ||
        (otherBundle.state && self.state &&
        [otherBundle.state isEqualToString:self.state]));

    BOOL amountEqual = ((!otherBundle.amount && !self.amount) ||
        (otherBundle.amount && self.amount &&
        [otherBundle.amount isEqual:self.amount]));

    BOOL last_4Equal = ((!otherBundle.last_4 && !self.last_4) ||
        (otherBundle.last_4 && self.last_4 &&
        [otherBundle.last_4 isEqualToString:self.last_4]));

    BOOL ordersEqual = ((!otherBundle.orders && !self.orders) ||
        (otherBundle.orders && self.orders &&
        [otherBundle.orders isEqualToArray:self.orders]));

    BOOL refundsEqual = ((!otherBundle.refunds && !self.refunds) ||
        (otherBundle.refunds && self.refunds &&
        [otherBundle.refunds isEqualToArray:self.refunds]));

    BOOL totalCreditUsedEqual = ((!otherBundle.totalCreditUsed && !self.totalCreditUsed) ||
        (otherBundle.totalCreditUsed && self.totalCreditUsed &&
        [otherBundle.totalCreditUsed isEqual:self.totalCreditUsed]));

    return chargedAtEqual && createdAtEqual && stateEqual && amountEqual &&
        last_4Equal && ordersEqual && refundsEqual && totalCreditUsedEqual;
  }

  return NO;
}

@end
