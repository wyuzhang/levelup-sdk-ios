#import "LUCause.h"
#import "LUDeviceIdentifier.h"
#import "LUDictionarySerializer.h"
#import "LUDivision.h"
#import "LUJSONDeserializer.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "NSDate+StringFormats.h"

#define kSecondsInAYear (365.25 * 24 * 60 * 60)

@implementation LUUser

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"user"];
  }
}

#pragma mark -
#pragma mark Public Methods

- (NSInteger)ageInYears {
  if (nil == self.bornAt) {
    return 0;
  } else {
    return (NSInteger)([[NSDate date] timeIntervalSinceDate:[NSDate dateFromIso8601DateTimeString:self.bornAt]] / kSecondsInAYear);
  }
}

- (NSString *)deviceIdentifier {
  return [LUDeviceIdentifier deviceIdentifier];
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

- (NSDictionary *)parameters {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];

  [params addEntriesFromDictionary:
   [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"bornAt", @"deviceIdentifier",
    @"divisionId", @"email", @"employer", @"firstName", @"gender", @"lastName", @"lat", @"lng", @"percentDonation",
    @"promotionCode", @"subscribed"]]];

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
  return [NSString stringWithFormat:@"https://www.thelevelup.com/join/%@", self.referralCode];
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

@end
