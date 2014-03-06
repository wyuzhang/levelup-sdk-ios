// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValue.h"
#import "LUUser+Fixtures.h"

@implementation LUUser (Fixtures)

+ (LUUser *)fixture {
  return [[LUUser alloc] initWithBirthdate:[NSDate distantPast]
                                   causeID:@1
                       connectedToFacebook:YES
                          customAttributes:nil
                             debitCardOnly:NO
                                     email:@"test@example.com"
                                 firstName:@"Joe"
                                    gender:LUGenderMale
                              globalCredit:[LUMonetaryValue monetaryValueWithUSD:@10]
                                  lastName:@"Test"
                     merchantsVisitedCount:@5
                               ordersCount:@10
                             termsAccepted:YES
                              totalSavings:[LUMonetaryValue monetaryValueWithUSD:@1]
                                    userID:@1];
}

+ (LUUser *)fixtureWithDebitOnly {
  return [[LUUser alloc] initWithBirthdate:[NSDate distantPast]
                                   causeID:@1
                       connectedToFacebook:YES
                          customAttributes:nil
                             debitCardOnly:YES
                                     email:@"test@example.com"
                                 firstName:@"Joe"
                                    gender:LUGenderMale
                              globalCredit:[LUMonetaryValue monetaryValueWithUSD:@10]
                                  lastName:@"Test"
                     merchantsVisitedCount:@5
                               ordersCount:@10
                             termsAccepted:YES
                              totalSavings:[LUMonetaryValue monetaryValueWithUSD:@1]
                                    userID:@1];
}

@end
