#import "LURegistrationRequestFactory.h"

SPEC_BEGIN(LURegistrationRequestFactorySpec)

describe(@"LURegistrationRequestFactory", ^{
  // Public Methods

  describe(@"requestForRegistrationWithEmail:", ^{
    NSString *apiKey = @"api-key";
    NSString *email = @"test@example.com";

    __block LUAPIRequest *request;

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:apiKey developmentMode:YES];

      request = [LURegistrationRequestFactory requestForRegistrationWithEmail:email];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'registration'", ^{
      [[request.path should] equal:@"registration"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request which includes the API key and the email", ^{
      [request.parameters shouldNotBeNil];
      [[request.parameters[@"api_key"] should] equal:apiKey];
      [[request.parameters[@"email"] should] equal:email];
    });
  });
});

SPEC_END
