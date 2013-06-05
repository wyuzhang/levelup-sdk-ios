#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAuthenticationRequestFactory.h"
#import "LUDeviceIdentifier.h"

SPEC_BEGIN(LUAuthenticationRequestFactorySpec)

describe(@"LUAuthenticationRequestFactory", ^{
  __block LUAPIRequest *request;

  // Public Methods

  NSString *apiKey = @"api-key";
  NSString *deviceIdentifier = @"12345";

  beforeEach(^{
    [LUAPIClient setupWithAPIKey:apiKey developmentMode:YES];
    [LUDeviceIdentifier stub:@selector(deviceIdentifier) andReturn:deviceIdentifier];
  });

  describe(@"requestToLoginWithEmail:password:", ^{
    NSString *email = @"test@example.com";
    NSString *password = @"test123";

    beforeEach(^{
      request = [LUAuthenticationRequestFactory requestToLoginWithEmail:email password:password];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'access_tokens'", ^{
      [[request.path should] equal:@"access_tokens"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{
        @"access_token" : @{
          @"client_id" : apiKey,
          @"device_identifier" : deviceIdentifier,
          @"password" : password,
          @"username" : email
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToLoginWithFacebookAccessToken:", ^{
    NSString *facebookAccessToken = @"facebook-access-token";

    beforeEach(^{
      request = [LUAuthenticationRequestFactory requestToLoginWithFacebookAccessToken:facebookAccessToken];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'access_tokens'", ^{
      [[request.path should] equal:@"access_tokens"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{
        @"access_token" : @{
          @"client_id" : apiKey,
          @"device_identifier" : deviceIdentifier,
          @"facebook_access_token" : facebookAccessToken
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
