/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
                                     phone:@"(123) 456-7890"
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
                                     phone:@"(123) 456-7890"
                             termsAccepted:YES
                              totalSavings:[LUMonetaryValue monetaryValueWithUSD:@1]
                                    userID:@1];
}

@end
