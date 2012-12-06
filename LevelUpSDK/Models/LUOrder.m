#import "LUBundle.h"
#import "LUDonation.h"
#import "LUJSONDeserializer.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@interface LUOrder ()

@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *refundedAt;

@end

@implementation LUOrder

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"order"];
  }
}

#pragma mark - Properties

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

- (NSDate *)refundDate {
  return [NSDate dateFromIso8601DateTimeString:self.refundedAt];
}

#pragma mark - Public Methods

- (BOOL)hasDonation {
  return (self.donation && self.donation.value && [self.donation.value.amount floatValue] > 0);
}

- (BOOL)hasEarnedCredit {
  return (self.earn && [self.earn.amount floatValue] > 0);
}

- (BOOL)wasRefunded {
  return (self.refundedAt != nil);
}

@end
