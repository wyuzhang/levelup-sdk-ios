#import "LUDonation.h"

@implementation LUDonation

#pragma mark - Creation

- (id)initWithCause:(LUCause *)cause donationID:(NSNumber *)donationID value:(LUMonetaryValue *)value {
  self = [super init];
  if (!self) return nil;

  _cause = cause;
  _donationID = donationID;
  _value = value;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUDonation [cause=%@, ID=%@, value=%@]", self.cause, self.donationID, self.value];
}

@end
