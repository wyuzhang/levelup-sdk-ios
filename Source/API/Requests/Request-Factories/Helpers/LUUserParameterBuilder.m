#import "LUDeviceIdentifier.h"
#import "LUUser.h"
#import "LUUserParameterBuilder.h"
#import "NSDate+StringFormats.h"

@implementation LUUserParameterBuilder

#pragma mark - Public Methods

+ (NSDictionary *)parametersForUser:(LUUser *)user {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];

  [self addKey:@"born_at" toDictionary:params ifValuePresent:[user.birthdate iso8601DateTimeString]];
  [self addKey:@"custom_attributes" toDictionary:params ifValuePresent:user.customAttributes];
  [self addKey:@"device_identifier" toDictionary:params ifValuePresent:[LUDeviceIdentifier deviceIdentifier]];
  [self addKey:@"email" toDictionary:params ifValuePresent:user.email];
  [self addKey:@"employer" toDictionary:params ifValuePresent:user.employer];
  [self addKey:@"first_name" toDictionary:params ifValuePresent:user.firstName];

  if (user.gender == LUGenderFemale) {
    params[@"gender"] = @"female";
  } else if (user.gender == LUGenderMale) {
    params[@"gender"] = @"male";
  }

  [self addKey:@"last_name" toDictionary:params ifValuePresent:user.lastName];
  [self addKey:@"new_password" toDictionary:params ifValuePresent:user.newPassword];
  [self addKey:@"new_password_confirmation" toDictionary:params ifValuePresent:user.newPasswordConfirmation];
  [self addKey:@"promotion_code" toDictionary:params ifValuePresent:user.promotionCode];
  [self addKey:@"terms_accepted_at" toDictionary:params ifValuePresent:[user.termsAcceptedDate iso8601DateTimeString]];

  return params;
}

#pragma mark - Private Methods

+ (void)addKey:(NSString *)key toDictionary:(NSMutableDictionary *)dictionary ifValuePresent:(id)value {
  if (value && (![value respondsToSelector:@selector(length)] || [value length] > 0)) {
    dictionary[key] = value;
  }
}

@end
