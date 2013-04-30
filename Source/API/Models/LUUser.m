#import "LUCause.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "NSDate+StringFormats.h"

NSString * const GenderMale = @"male";
NSString * const GenderFemale = @"female";
float const SecondsInAYear = 365.25 * 24 * 60 * 60;

@implementation LUUser

#pragma mark - Creation

- (id)initWithAbleToRefer:(BOOL)ableToRefer birthdate:(NSDate *)birthdate cause:(LUCause *)cause
                  causeID:(NSNumber *)causeID connectedToFacebook:(BOOL)connectedToFacebook
                   credit:(LUMonetaryValue *)credit customAttributes:(NSDictionary *)customAttributes
                    email:(NSString *)email employer:(NSString *)employer firstName:(NSString *)firstName
                   gender:(LUGender)gender lastName:(NSString *)lastName
         loyaltiesSavings:(LUMonetaryValue *)loyaltiesSavings merchantsVisitedCount:(NSNumber *)merchangsVisitedCount
              ordersCount:(NSNumber *)ordersCount paymentEligible:(BOOL)paymentEligible
             paymentToken:(NSString *)paymentToken percentDonation:(NSNumber *)percentDonation
        termsAcceptedDate:(NSDate *)termsAcceptedDate userAddresses:(NSArray *)userAddresses userID:(NSNumber *)userID {
  self = [super init];
  if (!self) return nil;

  _ableToRefer = ableToRefer;
  _birthdate = birthdate;
  _cause = cause;
  _causeID = causeID;
  _connectedToFacebook = connectedToFacebook;
  _credit = credit;
  _customAttributes = customAttributes;
  _email = email;
  _employer = employer;
  _firstName = firstName;
  _gender = gender;
  _lastName = lastName;
  _loyaltiesSavings = loyaltiesSavings;
  _merchantsVisitedCount = merchangsVisitedCount;
  _ordersCount = ordersCount;
  _paymentEligible = paymentEligible;
  _paymentToken = paymentToken;
  _percentDonation = percentDonation;
  _termsAcceptedDate = termsAcceptedDate;
  _userAddresses = userAddresses;
  _userID = userID;

  return self;
}

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
          @"LUUser [ableToRefer=%@, birthdate=%@, connectedToFacebook=%@, customAttributes=%@, email=%@, firstName=%@, gender=%@, ID=%@, lastName=%@, merchantsVisitedCount=%@, ordersCount=%@, paymentEligible=%@, paymentToken=%@, percentDonation=%@, termsAcceptedDate=%@]",
          @(self.ableToRefer), self.birthdate, @(self.connectedToFacebook), self.customAttributes, self.email,
          self.firstName, [self genderString], self.userID, self.lastName, self.merchantsVisitedCount,
          self.ordersCount, @(self.paymentEligible), self.paymentToken, self.percentDonation, self.termsAcceptedDate];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUUser [firstName=%@, ID=%@, lastName=%@]", self.firstName, self.userID, self.lastName];
}

#pragma mark - Private Methods

- (NSString *)genderString {
  switch (self.gender) {
    case LUGenderUnspecified:
      return @"none";

    case LUGenderMale:
      return @"male";

    case LUGenderFemale:
      return @"female";

    default:
      return nil;
  }
}

@end
