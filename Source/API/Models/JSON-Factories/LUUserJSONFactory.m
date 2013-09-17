// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValue.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserJSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSDate *birthdate = [attributes lu_dateForKey:@"born_at"];
  NSNumber *causeID = [attributes lu_numberForKey:@"cause_id"];
  BOOL connectedToFacebook = [attributes lu_boolForKey:@"connected_to_facebook"];
  NSDictionary *customAttributes = [attributes lu_dictionaryForKey:@"custom_attributes"];
  NSString *email = [attributes lu_stringForKey:@"email"];
  NSString *firstName = [attributes lu_stringForKey:@"first_name"];
  LUGender gender = [LUUser genderForGenderString:[attributes lu_stringForKey:@"gender"]];
  LUMonetaryValue *globalCredit = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"global_credit_amount"]];
  NSString *lastName = [attributes lu_stringForKey:@"last_name"];
  NSNumber *merchantsVisitedCount = [attributes lu_numberForKey:@"merchants_visited_count"];
  NSNumber *ordersCount = [attributes lu_numberForKey:@"orders_count"];
  BOOL termsAccepted = [attributes lu_dateForKey:@"terms_accepted_at"] != nil;
  LUMonetaryValue *totalSavings = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"total_savings_amount"]];
  NSNumber *userID = [attributes lu_numberForKey:@"id"];

  return [[LUUser alloc] initWithBirthdate:birthdate causeID:causeID connectedToFacebook:connectedToFacebook
                          customAttributes:customAttributes email:email firstName:firstName gender:gender
                              globalCredit:globalCredit lastName:lastName merchantsVisitedCount:merchantsVisitedCount
                               ordersCount:ordersCount termsAccepted:termsAccepted totalSavings:totalSavings
                                    userID:userID];
}

- (NSString *)rootKey {
  return @"user";
}

@end
