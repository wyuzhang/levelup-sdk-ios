#import "LUMonetaryValueJSONFactory.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserJSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  BOOL ableToRefer = [attributes boolForKey:@"able_to_refer"];
  NSDate *birthdate = [attributes dateForKey:@"born_at"];
  BOOL connectedToFacebook = [attributes stringForKey:@"facebook_access_token"].length > 0;
  LUMonetaryValue *credit = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"credit"]];
  NSDictionary *customAttributes = [attributes dictionaryForKey:@"custom_attributes"];
  NSString *email = [attributes stringForKey:@"email"];
  NSString *employer = [attributes stringForKey:@"employer"];
  NSString *firstName = [attributes stringForKey:@"first_name"];
  LUGender gender = [self genderFromString:[attributes stringForKey:@"gender"]];
  NSString *lastName = [attributes stringForKey:@"last_name"];
  LUMonetaryValue *loyaltiesSavings = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"loyalties_savings"]];
  NSNumber *merchantsVisitedCount = [attributes numberForKey:@"merchants_visited_count"];
  NSNumber *ordersCount = [attributes numberForKey:@"orders_count"];
  NSDate *termsAcceptedDate = [attributes dateForKey:@"terms_accepted_at"];
  NSNumber *userID = [attributes numberForKey:@"id"];

  return [[LUUser alloc] initWithAbleToRefer:ableToRefer birthdate:birthdate
                         connectedToFacebook:connectedToFacebook credit:credit customAttributes:customAttributes
                                       email:email employer:employer firstName:firstName gender:gender lastName:lastName
                            loyaltiesSavings:loyaltiesSavings merchantsVisitedCount:merchantsVisitedCount
                                 ordersCount:ordersCount termsAcceptedDate:termsAcceptedDate userID:userID];
}

- (NSString *)rootKey {
  return @"user";
}

#pragma mark - Private Methods

- (LUGender)genderFromString:(NSString *)genderString {
  if ([genderString isEqualToString:@"male"]) {
    return LUGenderMale;
  } else if ([genderString isEqualToString:@"female"]) {
    return LUGenderFemale;
  } else {
    return LUGenderUnspecified;
  }
}

@end
