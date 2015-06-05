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

#import "LUPaymentMethodJSONFactory.h"

SPEC_BEGIN(LUPaymentMethodJSONFactorySpec)

describe(@"LUPaymentMethodJSONFactory", ^{
  __block LUPaymentMethodJSONFactory *factory;

  beforeEach(^{
    factory = [LUPaymentMethodJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    context(@"for an Apple Pay card with monthly billing enabled", ^{
      it(@"parses a JSON dictionary into an LUApplePayCardPaymentMethod", ^{
        NSDictionary *JSON = @{
          @"description": @"Apple Pay",
          @"metadata": @{
            @"issuer": @"Visa"
          },
          @"monthly_billing_day": @15,
          @"monthly_transaction_limit_amount": @15000,
          @"payment_preference_type": @"monthly_billing",
          @"preload_reload_threshold_amount": [NSNull null],
          @"preload_value_amount": [NSNull null],
          @"type": @"apple_pay_card"
        };
        LUApplePayCardPaymentMethod *paymentMethod = [factory createFromAttributes:JSON];

        [[paymentMethod should] beKindOfClass:[LUApplePayCardPaymentMethod class]];
        [[paymentMethod.issuer should] equal:@"Visa"];
        [[paymentMethod.monthlyBillingDay should] equal:@15];
        [[paymentMethod.monthlyTransactionLimit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@15000]];
        [[paymentMethod.paymentMethodDescription should] equal:@"Apple Pay"];
        [[theValue(paymentMethod.paymentPreferenceType) should] equal:theValue(LUPaymentPreferenceTypeMonthlyBilling)];
        [paymentMethod.preloadReloadThreshold shouldBeNil];
        [paymentMethod.preloadValue shouldBeNil];
      });
    });

    context(@"for an Apple Pay card with preloading enabled", ^{
      it(@"parses a JSON dictionary into an LUApplePayCardPaymentMethod", ^{
        NSDictionary *JSON = @{
          @"description": @"Apple Pay",
          @"metadata": @{
            @"issuer": @"Visa"
          },
          @"monthly_billing_day": [NSNull null],
          @"monthly_transaction_limit_amount": [NSNull null],
          @"payment_preference_type": @"preload",
          @"preload_reload_threshold_amount": @1000,
          @"preload_value_amount": @2500,
          @"type": @"apple_pay_card"
        };
        LUApplePayCardPaymentMethod *paymentMethod = [factory createFromAttributes:JSON];

        [[paymentMethod should] beKindOfClass:[LUApplePayCardPaymentMethod class]];
        [[paymentMethod.issuer should] equal:@"Visa"];
        [paymentMethod.monthlyBillingDay shouldBeNil];
        [paymentMethod.monthlyTransactionLimit shouldBeNil];
        [[paymentMethod.paymentMethodDescription should] equal:@"Apple Pay"];
        [[theValue(paymentMethod.paymentPreferenceType) should] equal:theValue(LUPaymentPreferenceTypePreload)];
        [[paymentMethod.preloadReloadThreshold should] equal:[LUMonetaryValue monetaryValueWithUSCents:@1000]];
        [[paymentMethod.preloadValue should] equal:[LUMonetaryValue monetaryValueWithUSCents:@2500]];
      });
    });

    context(@"for a carrier account", ^{
      it(@"parses a JSON dictionary into an LUCarrierAccountPaymentMethod", ^{
        NSDictionary *JSON = @{
          @"description": @"Sprint *1234",
          @"metadata": @{
            @"carrier": @"Sprint",
            @"last_4": @"1234"
          },
          @"monthly_billing_day": [NSNull null],
          @"monthly_transaction_limit_amount": [NSNull null],
          @"payment_preference_type": @"instant_billing",
          @"preload_reload_threshold_amount": [NSNull null],
          @"preload_value_amount": [NSNull null],
          @"type": @"carrier"
        };
        LUCarrierAccountPaymentMethod *paymentMethod = [factory createFromAttributes:JSON];

        [[paymentMethod should] beKindOfClass:[LUCarrierAccountPaymentMethod class]];
        [[paymentMethod.carrier should] equal:@"Sprint"];
        [[paymentMethod.last4Digits should] equal:@"1234"];
        [paymentMethod.monthlyBillingDay shouldBeNil];
        [paymentMethod.monthlyTransactionLimit shouldBeNil];
        [[paymentMethod.paymentMethodDescription should] equal:@"Sprint *1234"];
        [[theValue(paymentMethod.paymentPreferenceType) should] equal:theValue(LUPaymentPreferenceTypeInstantBilling)];
        [paymentMethod.preloadReloadThreshold shouldBeNil];
        [paymentMethod.preloadValue shouldBeNil];
      });
    });

    context(@"for a credit card with monthly billing enabled", ^{
      it(@"parses a JSON dictionary into an LUCreditCardPaymentMethod", ^{
        NSDictionary *JSON = @{
          @"description": @"Visa *1234",
          @"metadata": @{
            @"expiration_month": @"11",
            @"expiration_year": @"2020",
            @"issuer": @"Visa",
            @"last_4": @"1234"
          },
          @"monthly_billing_day": @15,
          @"monthly_transaction_limit_amount": @15000,
          @"payment_preference_type": @"monthly_billing",
          @"preload_reload_threshold_amount": [NSNull null],
          @"preload_value_amount": [NSNull null],
          @"type": @"credit_card"
        };
        LUCreditCardPaymentMethod *paymentMethod = [factory createFromAttributes:JSON];

        [[paymentMethod should] beKindOfClass:[LUCreditCardPaymentMethod class]];
        [[theValue(paymentMethod.debit) should] beNo];
        [[paymentMethod.expirationMonth should] equal:@11];
        [[paymentMethod.expirationYear should] equal:@2020];
        [[paymentMethod.issuer should] equal:@"Visa"];
        [[paymentMethod.last4Digits should] equal:@"1234"];
        [[paymentMethod.monthlyBillingDay should] equal:@15];
        [[paymentMethod.monthlyTransactionLimit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@15000]];
        [[paymentMethod.paymentMethodDescription should] equal:@"Visa *1234"];
        [[theValue(paymentMethod.paymentPreferenceType) should] equal:theValue(LUPaymentPreferenceTypeMonthlyBilling)];
        [paymentMethod.preloadReloadThreshold shouldBeNil];
        [paymentMethod.preloadValue shouldBeNil];
      });
    });

    context(@"for a credit card with preloading enabled", ^{
      it(@"parses a JSON dictionary into an LUCreditCardPaymentMethod", ^{
        NSDictionary *JSON = @{
          @"description": @"Visa *1234",
          @"metadata": @{
            @"expiration_month": @"11",
            @"expiration_year": @"2020",
            @"issuer": @"Visa",
            @"last_4": @"1234"
          },
          @"monthly_billing_day": [NSNull null],
          @"monthly_transaction_limit_amount": [NSNull null],
          @"payment_preference_type": @"preload",
          @"preload_reload_threshold_amount": @1000,
          @"preload_value_amount": @2500,
          @"type": @"credit_card"
        };
        LUCreditCardPaymentMethod *paymentMethod = [factory createFromAttributes:JSON];

        [[paymentMethod should] beKindOfClass:[LUCreditCardPaymentMethod class]];
        [[theValue(paymentMethod.debit) should] beNo];
        [[paymentMethod.expirationMonth should] equal:@11];
        [[paymentMethod.expirationYear should] equal:@2020];
        [[paymentMethod.issuer should] equal:@"Visa"];
        [[paymentMethod.last4Digits should] equal:@"1234"];
        [paymentMethod.monthlyBillingDay shouldBeNil];
        [paymentMethod.monthlyTransactionLimit shouldBeNil];
        [[paymentMethod.paymentMethodDescription should] equal:@"Visa *1234"];
        [[theValue(paymentMethod.paymentPreferenceType) should] equal:theValue(LUPaymentPreferenceTypePreload)];
        [[paymentMethod.preloadReloadThreshold should] equal:[LUMonetaryValue monetaryValueWithUSCents:@1000]];
        [[paymentMethod.preloadValue should] equal:[LUMonetaryValue monetaryValueWithUSCents:@2500]];
      });
    });

    context(@"for a debit card", ^{
      it(@"parses a JSON dictionary into an LUCreditCardPaymentMethod", ^{
        NSDictionary *JSON = @{
          @"description": @"Visa *1234",
          @"metadata": @{
            @"expiration_month": @"11",
            @"expiration_year": @"2020",
            @"issuer": @"Visa",
            @"last_4": @"1234"
          },
          @"monthly_billing_day": @15,
          @"monthly_transaction_limit_amount": @15000,
          @"payment_preference_type": @"monthly_billing",
          @"preload_reload_threshold_amount": [NSNull null],
          @"preload_value_amount": [NSNull null],
          @"type": @"debit_card"
        };
        LUCreditCardPaymentMethod *paymentMethod = [factory createFromAttributes:JSON];

        [[paymentMethod should] beKindOfClass:[LUCreditCardPaymentMethod class]];
        [[theValue(paymentMethod.debit) should] beYes];
        [[paymentMethod.expirationMonth should] equal:@11];
        [[paymentMethod.expirationYear should] equal:@2020];
        [[paymentMethod.issuer should] equal:@"Visa"];
        [[paymentMethod.last4Digits should] equal:@"1234"];
        [[paymentMethod.monthlyBillingDay should] equal:@15];
        [[paymentMethod.monthlyTransactionLimit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@15000]];
        [[paymentMethod.paymentMethodDescription should] equal:@"Visa *1234"];
        [[theValue(paymentMethod.paymentPreferenceType) should] equal:theValue(LUPaymentPreferenceTypeMonthlyBilling)];
        [paymentMethod.preloadReloadThreshold shouldBeNil];
        [paymentMethod.preloadValue shouldBeNil];
      });
    });

    context(@"for a payment method with an unknown type", ^{
      it(@"returns nil", ^{
        NSDictionary *JSON = @{ @"type": @"unknown" };

        [[[factory createFromAttributes:JSON] should] beNil];
      });
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'payment_method'", ^{
      [[[factory rootKey] should] equal:@"payment_method"];
    });
  });
});

SPEC_END
