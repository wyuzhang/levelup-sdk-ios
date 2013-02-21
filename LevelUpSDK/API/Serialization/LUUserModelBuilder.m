#import "LUCauseModelBuilder.h"
#import "LUUser.h"
#import "LUUserModelBuilder.h"
#import "LUUserAddressModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"user"]) {
    attributes = attributes[@"user"];
  }

  LUUser *user = [[LUUser alloc] init];
  user.ableToRefer = [attributes boolForKey:@"able_to_refer"];
  user.birthday = [attributes dateForKey:@"born_at"];
  user.cause = [[LUCauseModelBuilder builder] buildModelFromJSON:attributes[@"cause"]];
  user.connectedToFacebook = [attributes stringForKey:@"facebook_access_token"].length > 0;
  user.credit = [attributes monetaryValueForKey:@"credit"];

  if ([attributes[@"custom_attributes"] isKindOfClass:[NSDictionary class]]) {
    user.customAttributes = attributes[@"custom_attributes"];
  }

  user.email = [attributes stringForKey:@"email"];
  user.employer = [attributes stringForKey:@"employer"];
  user.firstName = [attributes stringForKey:@"first_name"];

  if ([[attributes stringForKey:@"gender"] isEqualToString:@"male"]) {
    user.gender = LUGenderMale;
  } else if ([[attributes stringForKey:@"gender"] isEqualToString:@"female"]) {
    user.gender = LUGenderFemale;
  } else {
    user.gender = LUGenderNone;
  }

  user.lastName = [attributes stringForKey:@"last_name"];
  user.loyaltiesSavings = [attributes monetaryValueForKey:@"loyalties_savings"];
  user.merchantsVisitedCount = [attributes numberForKey:@"merchants_visited_count"];
  user.ordersCount = [attributes numberForKey:@"orders_count"];
  user.paymentEligible = [attributes boolForKey:@"payment_eligible"];

  if ([attributes[@"qr_code"] isKindOfClass:[NSDictionary class]]) {
    user.paymentToken = [attributes[@"qr_code"] stringForKey:@"data"];
  }

  user.percentDonation = [attributes numberForKey:@"percent_donation"];
  user.referralCode = [attributes stringForKey:@"referral_code"];
  user.termsAcceptedAt = [attributes dateForKey:@"terms_accepted_at"];
  user.userAddresses = [[LUUserAddressModelBuilder builder] buildModelFromJSON:attributes[@"user_addresses"]];
  user.userID = [attributes numberForKey:@"id"];

  return user;
}

@end
