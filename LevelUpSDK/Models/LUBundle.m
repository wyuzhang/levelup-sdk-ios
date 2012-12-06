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

@end
