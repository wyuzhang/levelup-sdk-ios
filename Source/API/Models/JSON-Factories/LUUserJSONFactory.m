#import "LUMonetaryValueJSONFactory.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserJSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSDate *birthdate = [attributes dateForKey:@"born_at"];
  BOOL connectedToFacebook = [attributes stringForKey:@"facebook_access_token"].length > 0;
  NSNumber *causeID = [attributes numberForKey:@"cause_id"];
  NSDictionary *customAttributes = [attributes dictionaryForKey:@"custom_attributes"];
  NSString *email = [attributes stringForKey:@"email"];
  NSString *firstName = [attributes stringForKey:@"first_name"];
  LUGender gender = [self genderFromString:[attributes stringForKey:@"gender"]];
  LUMonetaryValue *globalCredit = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"global_credit"]];
  NSString *lastName = [attributes stringForKey:@"last_name"];
  NSNumber *merchantsVisitedCount = [attributes numberForKey:@"merchants_visited_count"];
  NSNumber *ordersCount = [attributes numberForKey:@"orders_count"];
  NSDate *termsAcceptedDate = [attributes dateForKey:@"terms_accepted_at"];
  LUMonetaryValue *totalSavings = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"total_savings"]];
  NSNumber *userID = [attributes numberForKey:@"id"];

  return [[LUUser alloc] initWithBirthdate:birthdate causeID:causeID connectedToFacebook:connectedToFacebook
                          customAttributes:customAttributes email:email firstName:firstName gender:gender
                              globalCredit:globalCredit lastName:lastName merchantsVisitedCount:merchantsVisitedCount
                               ordersCount:ordersCount termsAcceptedDate:termsAcceptedDate totalSavings:totalSavings
                                      userID:userID];
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
