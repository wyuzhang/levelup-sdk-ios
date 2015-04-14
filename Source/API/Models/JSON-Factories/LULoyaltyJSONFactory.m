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

#import "LULoyalty.h"
#import "LULoyaltyJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULoyaltyJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *willEarn = [attributes lu_monetaryValueForKey:@"merchant_earn_amount"];
  NSNumber *merchantID = [attributes lu_numberForKey:@"merchant_id"];
  BOOL merchantLoyaltyEnabled = [attributes lu_boolForKey:@"merchant_loyalty_enabled"];
  LUMonetaryValue *shouldSpend = [attributes lu_monetaryValueForKey:@"merchant_spend_amount"];
  NSNumber *ordersCount = [attributes lu_numberForKey:@"orders_count"];
  LUMonetaryValue *potentialCredit = [attributes lu_monetaryValueForKey:@"potential_credit_amount"];
  float progressPercent = [[attributes lu_numberForKey:@"progress_percentage"] floatValue] / 100.0f;
  LUMonetaryValue *savings = [attributes lu_monetaryValueForKey:@"savings_amount"];
  LUMonetaryValue *spendRemaining = [attributes lu_monetaryValueForKey:@"spend_remaining_amount"];
  LUMonetaryValue *totalVolume = [attributes lu_monetaryValueForKey:@"total_volume_amount"];

  return [[LULoyalty alloc] initWithMerchantID:merchantID
                        merchantLoyaltyEnabled:merchantLoyaltyEnabled
                                   ordersCount:ordersCount
                               potentialCredit:potentialCredit
                               progressPercent:progressPercent
                                       savings:savings
                                   shouldSpend:shouldSpend
                                spendRemaining:spendRemaining
                                   totalVolume:totalVolume
                                      willEarn:willEarn];
}

- (NSString *)rootKey {
  return @"loyalty";
}

@end
