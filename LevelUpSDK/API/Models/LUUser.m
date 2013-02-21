#import "LUCause.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "NSDate+StringFormats.h"

NSString * const GenderMale = @"male";
NSString * const GenderFemale = @"female";
float const SecondsInAYear = 365.25 * 24 * 60 * 60;

@implementation LUUser

#pragma mark - Public Methods

- (BOOL)hasValidQRCode {
  return self.paymentEligible && self.paymentToken.length > 0;
}

- (LUUserAddress *)homeAddress {
  if (self.userAddresses) {
    for (LUUserAddress *address in self.userAddresses) {
      if ([address isHomeAddress]) {
        return address;
      }
    }
  }

  return nil;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"User [ableToRefer=%@, birthday=%@, connectedToFacebook=%@, customAttributes=%@, email=%@, firstName=%@, gender=%@, ID=%@, lastName=%@, merchantsVisitedCount=%@, ordersCount=%@, paymentEligible=%@, paymentToken=%@, percentDonation=%@, referralCode=%@, termsAcceptedAt=%@]",
          @(self.ableToRefer), self.birthday, @(self.connectedToFacebook), self.customAttributes, self.email,
          self.firstName, [self genderString], self.userID, self.lastName, self.merchantsVisitedCount,
          self.ordersCount, @(self.paymentEligible), self.paymentToken, self.percentDonation, self.referralCode,
          self.termsAcceptedAt];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"User [firstName=%@, ID=%@, lastName=%@]", self.firstName, self.userID, self.lastName];
}

#pragma mark - Private Methods

- (NSString *)genderString {
  switch (self.gender) {
    case LUGenderNone:
      return @"none";

    case LUGenderMale:
      return @"male";

    case LUGenderFemale:
      return @"female";

    default:
      return nil;
  }
}

- (NSString *)referralURL {
  return [NSString stringWithFormat:@"https://www.thelevelup.com/c/%@", self.referralCode];
}

@end
