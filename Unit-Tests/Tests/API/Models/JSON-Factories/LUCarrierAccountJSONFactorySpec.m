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

#import "LUCarrierAccount.h"
#import "LUCarrierAccountJSONFactory.h"

SPEC_BEGIN(LUCarrierAccountJSONFactorySpec)

describe(@"LUCarrierAccountJSONFactory", ^{
  __block LUCarrierAccountJSONFactory *factory;

  beforeEach(^{
    factory = [LUCarrierAccountJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCarrierAccount",^{
      NSDictionary *JSON = @{
        @"id" : @123,
        @"carrier" : @"SPR",
        @"ev_url" : @"http://mi.billtomobile.com/m/evurl?SKEY=secret_key",
        @"mobile_device_number" : @"1111111111",
        @"state" : @"active"
      };

      LUCarrierAccount *carrierAccount = [factory createFromAttributes:JSON];

      [[carrierAccount.carrierAccountID should] equal:@123];
      [[carrierAccount.carrierName should] equal:@"SPR"];
      [[carrierAccount.EVURL should] equal:[NSURL URLWithString:@"http://mi.billtomobile.com/m/evurl?SKEY=secret_key"]];
      [[carrierAccount.mobileDeviceNumber should] equal:@"1111111111"];
      [[theValue(carrierAccount.state) should] equal:theValue(LUCarrierAccountStateActive)];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'carrier_account'", ^{
      [[[factory rootKey] should] equal:@"carrier_account"];
    });
  });
});

SPEC_END