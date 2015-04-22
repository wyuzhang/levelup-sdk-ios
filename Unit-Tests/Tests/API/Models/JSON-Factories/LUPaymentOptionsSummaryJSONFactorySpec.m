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

#import "LUPaymentOptionsSummaryJSONFactory.h"

SPEC_BEGIN(LUPaymentOptionsSummaryJSONFactorySpec)

describe(@"LUPaymentOptionsSummaryJSONFactory", ^{
  __block LUPaymentOptionsSummaryJSONFactory *factory;

  beforeEach(^{
    factory = [LUPaymentOptionsSummaryJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUPaymentOptionsSummary", ^{
      NSDictionary *JSON = @{
        @"max_credit_limit_amount": @15000,
        @"monthly_billing_day": @1,
        @"options": @[@"preload", @"monthly_billing"],
        @"preload_reload_threshold_amount": @1500,
        @"preload_value_amount": @2500
      };
      LUPaymentOptionsSummary *paymentOptionsSummary = [factory createFromAttributes:JSON];

      [[paymentOptionsSummary.maxCreditLimit should] equal:[LUMonetaryValue monetaryValueWithUSD:@150]];
      [[paymentOptionsSummary.monthlyBillingDay should] equal:@1];
      [[paymentOptionsSummary.options should] equal:@[LUPaymentOptionPreload, LUPaymentOptionMonthlyBilling]];
      [[paymentOptionsSummary.preloadReloadThreshold should] equal:[LUMonetaryValue monetaryValueWithUSD:@15]];
      [[paymentOptionsSummary.preloadValue should] equal:[LUMonetaryValue monetaryValueWithUSD:@25]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'payment_options_summary'", ^{
      [[[factory rootKey] should] equal:@"payment_options_summary"];
    });
  });
});

SPEC_END
