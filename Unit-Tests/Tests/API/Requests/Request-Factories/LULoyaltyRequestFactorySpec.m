#import "LUAuthenticatedAPIRequest.h"
#import "LULoyaltyV14JSONFactory.h"

SPEC_BEGIN(LULoyaltyRequestFactorySpec)

describe(@"LULoyaltyRequestFactory", ^{
  __block LUAPIRequest *request;

  describe(@"requestForLoyaltyForMerchantWithID:", ^{
    beforeEach(^{
      request = [LULoyaltyRequestFactory requestForLoyaltyForMerchantWithID:@1];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
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
      [[request.modelFactory should] beKindOfClass:[LULoyaltyV14JSONFactory class]];
    });
  });
});

SPEC_END
