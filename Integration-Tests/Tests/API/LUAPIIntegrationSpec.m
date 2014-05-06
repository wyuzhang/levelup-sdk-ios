SPEC_BEGIN(LUAPIIntegrationSpec)

describe(@"API", ^{
  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    [LUAPIClient sharedClient].accessToken = @"access-token";
  });

  afterEach(^{
    [[LUAPIStubbing sharedInstance] clearStubs];
  });

  context(@"a successful API call", ^{
    beforeEach(^{
      [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToGetPaymentToken]];
    });

    it(@"calls the success block with the parsed response object", ^{
      __block id responseObject;

      [[LUAPIClient sharedClient] performRequest:[LUPaymentTokenRequestFactory requestForPaymentToken]
                                         success:^(id result, LUAPIResponse *response) {
                                           responseObject = result;
                                         }
                                         failure:nil];

      [[expectFutureValue(responseObject) shouldNotEventually] beNil];
      [[responseObject should] beKindOfClass:[LUPaymentToken class]];
      [[[(LUPaymentToken *)responseObject data] should] equal:@"LU02000TESTTESTTEST01234"];
    });
  });

  context(@"a failing API call", ^{
    beforeEach(^{
      [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToGetIneligiblePaymentToken]];
    });

    it(@"calls the failure block with a relevant error", ^{
      __block NSError *error;

      [[LUAPIClient sharedClient] performRequest:[LUPaymentTokenRequestFactory requestForPaymentToken]
                                         success:nil
                                         failure:^(NSError *errorResponse) {
                                           error = errorResponse;
                                         }];

      [[expectFutureValue(error) shouldNotEventually] beNil];
      [[error.domain should] equal:LUAPIErrorDomain];
      [[theValue(error.code) should] equal:theValue(LUAPIErrorNotFound)];
    });
  });
});

SPEC_END
