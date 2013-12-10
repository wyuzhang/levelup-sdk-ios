// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LULoyaltyJSONFactory.h"

SPEC_BEGIN(LULoyaltyRequestFactorySpec)

describe(@"LULoyaltyRequestFactory", ^{
  __block LUAPIRequest *request;

  describe(@"requestForLoyaltyForMerchantWithID:", ^{
    beforeEach(^{
      request = [LULoyaltyRequestFactory requestForLoyaltyForMerchantWithID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'merchants/:id/loyalty", ^{
      [[request.path should] equal:@"merchants/1/loyalty"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with an attached LULoyaltyJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULoyaltyJSONFactory class]];
    });
  });
});

SPEC_END
