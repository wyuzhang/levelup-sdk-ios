#import "LUCause.h"
#import "LUQRCode.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "NSDate+StringFormats.h"
#import "NSDate+LevelUpAdditions.h"

NSString * const GenderMale = @"male";
NSString * const GenderFemale = @"female";
float const SecondsInAYear = 365.25 * 24 * 60 * 60;

@interface LUUser ()

@property (nonatomic, copy) NSString *bornAt;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *termsAcceptedAt;

@end

@implementation LUUser

#pragma mark - Property Getters

- (NSDate *)birthday {
  if (self.bornAt) {
    return [NSDate dateFromIso8601DateTimeString:self.bornAt];
  } else {
    return [NSDate dateWithYearsSinceNow:-18];
  }
}

- (BOOL)isFemale {
  return [self.gender isEqualToString:GenderFemale];
}

- (BOOL)isMale {
  return [self.gender isEqualToString:GenderMale];
}

- (NSDate *)termsAcceptedTime {
  return [NSDate dateFromIso8601DateTimeString:self.termsAcceptedAt];
}

#pragma mark - Property Setters

- (void)setBirthday:(NSDate *)birthday {
  self.bornAt = [birthday iso8601DateTimeString];
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

- (BOOL)hasValidQRCode {
  return self.paymentEligible && self.qrCode.data.length > 0;
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

- (NSString *)referralURL {
  return [NSString stringWithFormat:@"https://www.thelevelup.com/c/%@", self.referralCode];
}

@end
