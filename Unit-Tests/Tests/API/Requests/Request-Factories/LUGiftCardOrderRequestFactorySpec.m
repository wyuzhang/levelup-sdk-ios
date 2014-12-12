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

#import "LUGiftCardOrder.h"
#import "LUGiftCardOrderRequestFactory.h"

SPEC_BEGIN(LUGiftCardOrderRequestFactorySpec)

describe(@"LUGiftCardOrderRequestFactory", ^{
  describe(@"requestToCreateGiftCardOrder:", ^{
    __block LUGiftCardOrder *giftCardOrder;
    __block LUAPIRequest *request;

    beforeEach(^{
      giftCardOrder = [LUGiftCardOrder fixture];
      request = [LUGiftCardOrderRequestFactory requestToCreateGiftCardOrder:giftCardOrder];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users/gift_card_value_orders'", ^{
      [[request.path should] equal:@"users/gift_card_value_orders"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{
        @"gift_card_value_order": @{
          @"merchant_id": @1,
          @"recipient_email": @"test@example.com",
          @"recipient_message": @"Test Message",
          @"recipient_name": @"John",
          @"value_amount": @500
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
