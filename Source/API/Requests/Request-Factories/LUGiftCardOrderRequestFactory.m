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

#import "LUAPIRequest.h"
#import "LUGiftCardOrder.h"
#import "LUGiftCardOrderRequestFactory.h"
#import "LUMonetaryValue.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUGiftCardOrderRequestFactory

+ (LUAPIRequest *)requestToCreateGiftCardOrder:(LUGiftCardOrder *)giftCardOrder {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:giftCardOrder.merchantID forKey:@"merchant_id"];
  [parameters lu_setSafeValue:giftCardOrder.recipientEmail forKey:@"recipient_email"];
  [parameters lu_setSafeValue:giftCardOrder.recipientMessage forKey:@"recipient_message"];
  [parameters lu_setSafeValue:giftCardOrder.recipientName forKey:@"recipient_name"];
  [parameters lu_setSafeValue:giftCardOrder.value.amount forKey:@"value_amount"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"users/gift_card_value_orders"
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"gift_card_value_order": parameters}
                               modelFactory:nil];
}

@end
