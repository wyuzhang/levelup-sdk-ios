#import "LUBundle.h"
#import "LUDonation.h"
#import "LUJSONDeserializer.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@implementation LUOrder

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"order"];
  }
}

#pragma mark -
#pragma mark Properties

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

#pragma mark -
#pragma mark Public Methods

- (BOOL)hasDonation {
  return nil != self.donation && nil != self.donation.value && [self.donation.value.amount floatValue] > 0;
}

- (BOOL)hasEarnCredit {
  return nil != self.earn && [self.earn.amount floatValue] > 0;
}

@end
