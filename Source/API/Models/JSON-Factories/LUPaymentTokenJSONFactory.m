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

#import "LUPaymentToken.h"
#import "LUPaymentTokenJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUPaymentTokenJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *action = [attributes lu_stringForKey:@"action"];
  NSString *data = [attributes lu_stringForKey:@"data"];
  NSString *message = [attributes lu_stringForKey:@"message"];
  NSNumber *paymentTokenID = [attributes lu_numberForKey:@"id"];

  return [[LUPaymentToken alloc] initWithAction:action data:data message:message paymentTokenID:paymentTokenID];
}

- (NSString *)rootKey {
  return @"payment_token";
}

@end
