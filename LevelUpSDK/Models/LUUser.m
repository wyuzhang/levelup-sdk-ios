#import "LUCause.h"
#import "LUDeviceIdentifier.h"
#import "LUDictionarySerializer.h"
#import "LUDivision.h"
#import "LUJSONDeserializer.h"
#import "LUMonetaryValue.h"
#import "LUQRCode.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "NSDate+StringFormats.h"

NSString * const GenderMale = @"male";
NSString * const GenderFemale = @"female";
float const SecondsInAYear = 365.25 * 24 * 60 * 60;

@interface LUUser ()

@property (nonatomic, copy) NSString *bornAt;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *termsAcceptedAt;

@end

@implementation LUUser

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"user"];
  }
}

#pragma mark - Property Getters

- (NSDate *)birthday {
  return [NSDate dateFromIso8601DateTimeString:self.bornAt];
}

- (NSString *)deviceIdentifier {
  return [LUDeviceIdentifier deviceIdentifier];
}

- (BOOL)isMale {
  return [self.gender isEqualToString:GenderMale];
}

- (BOOL)isFemale {
  return [self.gender isEqualToString:GenderFemale];
}

- (NSDate *)termsAcceptedTime {
  return [NSDate dateFromIso8601DateTimeString:self.termsAcceptedAt];
}

#pragma mark - Property Setters

- (void)setBirthday:(NSDate *)birthday {
  self.bornAt = [birthday iso8601DateTimeString];
}

- (void)setDivision:(LUDivision *)aDivision {
  if (_division == aDivision) {
    return;
  }

  _division = aDivision;

  if (_division) {
    self.divisionId = _division.modelId;
  } else {
    self.divisionId = nil;
  }
}

- (void)setIsFemale:(BOOL)isFemale {
  self.gender = GenderFemale;
}

- (void)setIsMale:(BOOL)isMale {
  self.gender = GenderMale;
}

- (void)setTermsAcceptedTime:(NSDate *)termsAcceptedTime {
  self.termsAcceptedAt = [termsAcceptedTime iso8601DateTimeString];
}

#pragma mark - Public Methods

- (NSInteger)ageInYears {
  if (nil == self.bornAt) {
    return 0;
  } else {
    return (NSInteger)([[NSDate date] timeIntervalSinceDate:self.birthday] / SecondsInAYear);
  }
}

- (BOOL)hasValidQRCode {
  return [self isPaymentEligible] && self.qrCode.data.length > 0;
}

- (LUUserAddress *)homeAddress {
  if (nil != self.userAddresses) {
    for (LUUserAddress *address in self.userAddresses) {
      if ([address isHomeAddress]) {
        return address;
      }
    }
  }

  return nil;
}

- (BOOL)isAbleToRefer {
  return ((nil != self.ableToRefer && [self.ableToRefer boolValue]) || nil == self.ableToRefer);
}

- (BOOL)isPaymentEligible {
  return [self.paymentEligible boolValue];
}

- (BOOL)isSubscribed {
  return [self.subscribed boolValue];
}

- (NSDictionary *)parameters {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];

  [params addEntriesFromDictionary:
   [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"bornAt", @"customAttributes",
    @"deviceIdentifier", @"divisionId", @"email", @"employer", @"firstName", @"gender", @"lastName", @"lat", @"lng",
    @"percentDonation", @"promotionCode", @"subscribed", @"termsAcceptedAt"]]];

  if (self.newPassword.length > 0) {
    params[@"new_password"] = self.newPassword;
    params[@"new_password_confirmation"] = self.newPassword;
  }

  if (self.userAddresses) {
    [self.userAddresses enumerateObjectsUsingBlock:^(LUUserAddress *address, NSUInteger idx, BOOL *stop) {
      params[[NSString stringWithFormat:@"user_addresses_attributes[%d]", idx]] =
        [LUDictionarySerializer parametersForModel:address withAttributesNamed:@[@"addressType", @"extendedAddress",
         @"modelId", @"locality", @"postalCode", @"region", @"streetAddress"]];
    }];
  }

  return params;
}

- (NSString *)referralFacebookDescription {
  return [NSString stringWithFormat:@"I'm using LevelUp and loving it. Sign up with my code \"%@\" and you'll get $5 to spend anywhere on LevelUp.", self.referralCode];
}

- (NSString *)referralTweetString {
  return [NSString stringWithFormat:@"Sign up for LevelUp using my code \"%@\" and you'll get $5 to spend anywhere on LevelUp.", self.referralCode];
}

- (NSString *)referralUrl {
  return [NSString stringWithFormat:@"https://www.thelevelup.com/c/%@", self.referralCode];
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.bornAt) {
    total += [self.bornAt hash] * 11;
  }
  if (self.gender) {
    total += [self.gender hash] * 13;
  }
  if (self.termsAcceptedAt) {
    total += [self.termsAcceptedAt hash] * 17;
  }
  if (self.ableToRefer) {
    total += [self.ableToRefer intValue] * 19;
  }
  if (self.birthday) {
    total += [self.birthday hash] * 23;
  }
  if (self.cause) {
    total += [self.cause hash] * 29;
  }
  if (self.causeId) {
    total += [self.causeId intValue] * 31;
  }
  if (self.credit) {
    total += [self.credit hash] * 37;
  }
  if (self.division) {
    total += [self.division hash] * 41;
  }
  if (self.divisionId) {
    total += [self.divisionId intValue] * 43;
  }
  if (self.email) {
    total += [self.email hash] * 47;
  }
  if (self.employer) {
    total += [self.employer hash] * 53;
  }
  if (self.facebookUserId) {
    total += [self.facebookUserId hash] * 59;
  }
  if (self.firstName) {
    total += [self.firstName hash] * 61;
  }
  if (self.isFemale) {
    total += [[NSNumber numberWithBool:self.isFemale]intValue] * 67;
  }
  if (self.isMale) {
    total += [[NSNumber numberWithBool:self.isMale]intValue] * 71;
  }
  if (self.lastName) {
    total += [self.lastName hash] * 73;
  }
  if (self.lat) {
    total += [self.lat intValue] * 79;
  }
  if (self.lng) {
    total += [self.lng intValue] * 83;
  }
  if (self.loyaltiesSavings) {
    total += [self.loyaltiesSavings hash] * 89;
  }
  if (self.merchantsVisitedCount) {
    total += [self.merchantsVisitedCount intValue] * 97;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 11;
  }
  if (self.newPassword) {
    total += [self.newPassword hash] * 13;
  }
  if (self.newPasswordConfirmation) {
    total += [self.newPasswordConfirmation hash] * 17;
  }
  if (self.ordersCount) {
    total += [self.ordersCount intValue] * 19;
  }
  if (self.paymentEligible) {
    total += [self.paymentEligible intValue] * 23;
  }
  if (self.percentDonation) {
    total += [self.percentDonation intValue] * 29;
  }
  if (self.promotionCode) {
    total += [self.promotionCode hash] * 31;
  }
  if (self.qrCode) {
    total += [self.qrCode hash] * 37;
  }
  if (self.referralCode) {
    total += [self.referralCode hash] * 41;
  }
  if (self.subscribed) {
    total += [self.subscribed intValue] * 43;
  }
  if (self.termsAcceptedTime) {
    total += [self.termsAcceptedTime hash] * 47;
  }
  if (self.twitterAuthenticated) {
    total += [self.twitterAuthenticated intValue] * 53;
  }
  if (self.userAddresses) {
    total += [self.userAddresses hash] * 59;
  }
  if (self.xUserId) {
    total += [self.xUserId intValue] * 61;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUUser class]]) {
    LUUser *otherUser = (LUUser *)otherObject;

    BOOL bornAtEqual = ((!otherUser.bornAt && !self.bornAt) ||
        (otherUser.bornAt && self.bornAt &&
        [otherUser.bornAt isEqualToString:self.bornAt]));

    BOOL genderEqual = ((!otherUser.gender && !self.gender) ||
        (otherUser.gender && self.gender &&
        [otherUser.gender isEqualToString:self.gender]));

    BOOL termsAcceptedAtEqual = ((!otherUser.termsAcceptedAt && !self.termsAcceptedAt) ||
        (otherUser.termsAcceptedAt && self.termsAcceptedAt &&
        [otherUser.termsAcceptedAt isEqualToString:self.termsAcceptedAt]));

    BOOL ableToReferEqual = ((!otherUser.ableToRefer && !self.ableToRefer) ||
        (otherUser.ableToRefer && self.ableToRefer &&
        [otherUser.ableToRefer intValue] == [self.ableToRefer intValue]));

    BOOL birthdayEqual = ((!otherUser.birthday && !self.birthday) ||
        (otherUser.birthday && self.birthday &&
        [otherUser.birthday isEqualToDate:self.birthday]));

    BOOL causeEqual = ((!otherUser.cause && !self.cause) ||
        (otherUser.cause && self.cause &&
        [otherUser.cause isEqual:self.cause]));

    BOOL causeIdEqual = ((!otherUser.causeId && !self.causeId) ||
        (otherUser.causeId && self.causeId &&
        [otherUser.causeId intValue] == [self.causeId intValue]));

    BOOL creditEqual = ((!otherUser.credit && !self.credit) ||
        (otherUser.credit && self.credit &&
        [otherUser.credit isEqual:self.credit]));

    BOOL divisionEqual = ((!otherUser.division && !self.division) ||
        (otherUser.division && self.division &&
        [otherUser.division isEqual:self.division]));

    BOOL divisionIdEqual = ((!otherUser.divisionId && !self.divisionId) ||
        (otherUser.divisionId && self.divisionId &&
        [otherUser.divisionId intValue] == [self.divisionId intValue]));

    BOOL emailEqual = ((!otherUser.email && !self.email) ||
        (otherUser.email && self.email &&
        [otherUser.email isEqualToString:self.email]));

    BOOL employerEqual = ((!otherUser.employer && !self.employer) ||
        (otherUser.employer && self.employer &&
        [otherUser.employer isEqualToString:self.employer]));

    BOOL facebookUserIdEqual = ((!otherUser.facebookUserId && !self.facebookUserId) ||
        (otherUser.facebookUserId && self.facebookUserId &&
        [otherUser.facebookUserId isEqualToString:self.facebookUserId]));

    BOOL firstNameEqual = ((!otherUser.firstName && !self.firstName) ||
        (otherUser.firstName && self.firstName &&
        [otherUser.firstName isEqualToString:self.firstName]));

    BOOL isFemaleEqual = ((!otherUser.isFemale && !self.isFemale) ||
        (otherUser.isFemale && self.isFemale &&
        otherUser.isFemale == self.isFemale));

    BOOL isMaleEqual = ((!otherUser.isMale && !self.isMale) ||
        (otherUser.isMale && self.isMale &&
        otherUser.isMale == self.isMale));

    BOOL lastNameEqual = ((!otherUser.lastName && !self.lastName) ||
        (otherUser.lastName && self.lastName &&
        [otherUser.lastName isEqualToString:self.lastName]));

    BOOL latEqual = ((!otherUser.lat && !self.lat) ||
        (otherUser.lat && self.lat &&
        [otherUser.lat intValue] == [self.lat intValue]));

    BOOL lngEqual = ((!otherUser.lng && !self.lng) ||
        (otherUser.lng && self.lng &&
        [otherUser.lng intValue] == [self.lng intValue]));

    BOOL loyaltiesSavingsEqual = ((!otherUser.loyaltiesSavings && !self.loyaltiesSavings) ||
        (otherUser.loyaltiesSavings && self.loyaltiesSavings &&
        [otherUser.loyaltiesSavings isEqual:self.loyaltiesSavings]));

    BOOL merchantsVisitedCountEqual = ((!otherUser.merchantsVisitedCount && !self.merchantsVisitedCount) ||
        (otherUser.merchantsVisitedCount && self.merchantsVisitedCount &&
        [otherUser.merchantsVisitedCount intValue] == [self.merchantsVisitedCount intValue]));

    BOOL modelIdEqual = ((!otherUser.modelId && !self.modelId) ||
        (otherUser.modelId && self.modelId &&
        [otherUser.modelId intValue] == [self.modelId intValue]));

    BOOL newPasswordEqual = ((!otherUser.newPassword && !self.newPassword) ||
        (otherUser.newPassword && self.newPassword &&
        [otherUser.newPassword isEqualToString:self.newPassword]));

    BOOL newPasswordConfirmationEqual = ((!otherUser.newPasswordConfirmation && !self.newPasswordConfirmation) ||
        (otherUser.newPasswordConfirmation && self.newPasswordConfirmation &&
        [otherUser.newPasswordConfirmation isEqualToString:self.newPasswordConfirmation]));

    BOOL ordersCountEqual = ((!otherUser.ordersCount && !self.ordersCount) ||
        (otherUser.ordersCount && self.ordersCount &&
        [otherUser.ordersCount intValue] == [self.ordersCount intValue]));

    BOOL paymentEligibleEqual = ((!otherUser.paymentEligible && !self.paymentEligible) ||
        (otherUser.paymentEligible && self.paymentEligible &&
        [otherUser.paymentEligible intValue] == [self.paymentEligible intValue]));

    BOOL percentDonationEqual = ((!otherUser.percentDonation && !self.percentDonation) ||
        (otherUser.percentDonation && self.percentDonation &&
        [otherUser.percentDonation intValue] == [self.percentDonation intValue]));

    BOOL promotionCodeEqual = ((!otherUser.promotionCode && !self.promotionCode) ||
        (otherUser.promotionCode && self.promotionCode &&
        [otherUser.promotionCode isEqualToString:self.promotionCode]));

    BOOL qrCodeEqual = ((!otherUser.qrCode && !self.qrCode) ||
        (otherUser.qrCode && self.qrCode &&
        [otherUser.qrCode isEqual:self.qrCode]));

    BOOL referralCodeEqual = ((!otherUser.referralCode && !self.referralCode) ||
        (otherUser.referralCode && self.referralCode &&
        [otherUser.referralCode isEqualToString:self.referralCode]));

    BOOL subscribedEqual = ((!otherUser.subscribed && !self.subscribed) ||
        (otherUser.subscribed && self.subscribed &&
        [otherUser.subscribed intValue] == [self.subscribed intValue]));

    BOOL termsAcceptedTimeEqual = ((!otherUser.termsAcceptedTime && !self.termsAcceptedTime) ||
        (otherUser.termsAcceptedTime && self.termsAcceptedTime &&
        [otherUser.termsAcceptedTime isEqualToDate:self.termsAcceptedTime]));

    BOOL twitterAuthenticatedEqual = ((!otherUser.twitterAuthenticated && !self.twitterAuthenticated) ||
        (otherUser.twitterAuthenticated && self.twitterAuthenticated &&
        [otherUser.twitterAuthenticated intValue] == [self.twitterAuthenticated intValue]));

    BOOL userAddressesEqual = ((!otherUser.userAddresses && !self.userAddresses) ||
        (otherUser.userAddresses && self.userAddresses &&
        [otherUser.userAddresses isEqualToArray:self.userAddresses]));

    BOOL xUserIdEqual = ((!otherUser.xUserId && !self.xUserId) ||
        (otherUser.xUserId && self.xUserId &&
        [otherUser.xUserId intValue] == [self.xUserId intValue]));

    return bornAtEqual && genderEqual && termsAcceptedAtEqual && ableToReferEqual &&
        birthdayEqual && causeEqual && causeIdEqual && creditEqual &&
        divisionEqual && divisionIdEqual && emailEqual && employerEqual &&
        facebookUserIdEqual && firstNameEqual && isFemaleEqual && isMaleEqual &&
        lastNameEqual && latEqual && lngEqual && loyaltiesSavingsEqual &&
        merchantsVisitedCountEqual && modelIdEqual && newPasswordEqual && newPasswordConfirmationEqual &&
        ordersCountEqual && paymentEligibleEqual && percentDonationEqual && promotionCodeEqual &&
        qrCodeEqual && referralCodeEqual && subscribedEqual && termsAcceptedTimeEqual &&
        twitterAuthenticatedEqual && userAddressesEqual && xUserIdEqual;
  }

  return NO;
}

@end
