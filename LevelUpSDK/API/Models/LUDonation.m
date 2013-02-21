#import "LUDonation.h"

@implementation LUDonation

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"Donation [cause=%@, ID=%@, value=%@]", self.cause, self.donationID, self.value];
}

@end
