#import "LUUser.h"
#import "NSDate+StringFormats.h"

NSString * const GenderMale = @"male";
NSString * const GenderFemale = @"female";
float const SecondsInAYear = 365.25 * 24 * 60 * 60;

@implementation LUUser

#pragma mark - Creation

- (id)initWithBirthdate:(NSDate *)birthdate causeID:(NSNumber *)causeID connectedToFacebook:(BOOL)connectedToFacebook
       customAttributes:(NSDictionary *)customAttributes email:(NSString *)email firstName:(NSString *)firstName
                 gender:(LUGender)gender globalCredit:(LUMonetaryValue *)globalCredit lastName:(NSString *)lastName
  merchantsVisitedCount:(NSNumber *)merchangsVisitedCount ordersCount:(NSNumber *)ordersCount
      termsAcceptedDate:(NSDate *)termsAcceptedDate totalSavings:(LUMonetaryValue *)totalSavings
                 userID:(NSNumber *)userID {
  self = [super init];
  if (!self) return nil;

  _birthdate = birthdate;
  _causeID = causeID;
  _connectedToFacebook = connectedToFacebook;
  _customAttributes = customAttributes;
  _email = email;
  _firstName = firstName;
  _gender = gender;
  _globalCredit = globalCredit;
  _lastName = lastName;
  _merchantsVisitedCount = merchangsVisitedCount;
  _ordersCount = ordersCount;
  _termsAcceptedDate = termsAcceptedDate;
  _totalSavings = totalSavings;
  _userID = userID;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUUser [birthdate=%@, causeID=%@, connectedToFacebook=%@, customAttributes=%@, email=%@, firstName=%@, gender=%@, globalCredit=%@, ID=%@, lastName=%@, merchantsVisitedCount=%@, ordersCount=%@, termsAcceptedDate=%@, totalSavings=%@]",
          self.birthdate, self.causeID, @(self.connectedToFacebook), self.customAttributes, self.email,
          self.firstName, [self genderString], self.globalCredit, self.userID, self.lastName, self.merchantsVisitedCount,
          self.ordersCount, self.termsAcceptedDate, self.totalSavings];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUUser [firstName=%@, ID=%@, lastName=%@]", self.firstName, self.userID,
          self.lastName];
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
