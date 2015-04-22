/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUPaymentOptionsSummary.h"

NSString * const LUPaymentOptionInstantBilling = @"instant_billing";
NSString * const LUPaymentOptionMonthlyBilling = @"monthly_billing";
NSString * const LUPaymentOptionPreload = @"preload";

@implementation LUPaymentOptionsSummary

#pragma mark - Creation

- (id)initWithMaxCreditLimit:(LUMonetaryValue *)maxCreditLimit
           monthlyBillingDay:(NSNumber *)monthlyBillingDay options:(NSArray *)options
      preloadReloadThreshold:(LUMonetaryValue *)preloadReloadThreshold
                preloadValue:(LUMonetaryValue *)preloadValue {
  self = [super init];
  if (!self) return nil;

  _maxCreditLimit = maxCreditLimit;
  _monthlyBillingDay = monthlyBillingDay;
  _options = options;
  _preloadReloadThreshold = preloadReloadThreshold;
  _preloadValue = preloadValue;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUPaymentOptionsSummary [address=%p, maxCreditLimit=%@, monthlyBillingDay=%@, options=%@, preloadReloadThreshold=%@, preloadValue=%@]",
          self, self.maxCreditLimit, self.monthlyBillingDay, self.options,
          self.preloadReloadThreshold, self.preloadValue];
}

@end
