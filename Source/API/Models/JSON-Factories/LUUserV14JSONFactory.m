#import "LUMonetaryValue.h"
#import "LUUser.h"
#import "LUUserV14JSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserV14JSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSDate *birthdate = [attributes dateForKey:@"born_at"];
  NSNumber *causeID = [attributes numberForKey:@"cause_id"];
  BOOL connectedToFacebook = [attributes boolForKey:@"connected_to_facebook"];
  NSDictionary *customAttributes = [attributes dictionaryForKey:@"custom_attributes"];
  NSString *email = [attributes stringForKey:@"email"];
  NSString *firstName = [attributes stringForKey:@"first_name"];
  LUGender gender = [self genderFromString:[attributes stringForKey:@"gender"]];
  LUMonetaryValue *globalCredit = [LUMonetaryValue monetaryValueWithUSCents:[attributes numberForKey:@"global_credit_amount"]];
  NSString *lastName = [attributes stringForKey:@"last_name"];
  NSNumber *merchantsVisitedCount = [attributes numberForKey:@"merchants_visited_count"];
  NSNumber *ordersCount = [attributes numberForKey:@"orders_count"];
  NSDate *termsAcceptedDate = [attributes dateForKey:@"terms_accepted_at"];
  LUMonetaryValue *totalSavings = [LUMonetaryValue monetaryValueWithUSCents:[attributes numberForKey:@"total_savings_amount"]];
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
