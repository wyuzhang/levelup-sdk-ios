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

#import "LUPaymentToken+Fixtures.h"

@implementation LUPaymentToken (Fixtures)

+ (LUPaymentToken *)fixture {
  return [[LUPaymentToken alloc] initWithAction:nil
                                           data:@"LU02000TESTTESTTEST01234"
                                        message:nil
                                 paymentTokenID:@1];
}

+ (LUPaymentToken *)fixtureWithActionAndMessage {
  LUPaymentToken *paymentToken = [self fixture];
  [paymentToken setValue:@"add_payment_method" forKey:@"action"];
  [paymentToken setValue:@"Add a Payment Method for one-touch payments & loyalty" forKey:@"message"];
  return paymentToken;
}

+ (LUPaymentToken *)fixtureWithMessage {
  LUPaymentToken *paymentToken = [self fixture];
  [paymentToken setValue:@"Your card is expiring soon!" forKey:@"message"];
  return paymentToken;
}

@end
