#import "LUDonation+FakeInstance.h"

@implementation LUDonation (FakeInstance)

+ (LUDonation *)fakeInstance {
  return [[LUDonation alloc] initWithCause:nil donationID:@1 value:[LUMonetaryValue monetaryValueWithUSD:@0.49f]];
}

@end
