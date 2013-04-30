#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUDeviceIdentifier.h"
#import "LUOAuthTokenRequestFactory.h"

SPEC_BEGIN(LUOAuthTokenRequestFactorySpec)

describe(@"LUOAuthTokenRequestFactory", ^{
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
      request = [LUOAuthTokenRequestFactory requestToLoginWithEmail:email password:password];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'oauth/access_token'", ^{
      [[request.path should] equal:@"oauth/access_token"];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{
        @"client_id" : apiKey,
        @"device_identifier" : deviceIdentifier,
        @"grant_type" : @"password",
        @"password" : password,
        @"username" : email
      };

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToLoginWithFacebookAccessToken:", ^{
    NSString *facebookAccessToken = @"facebook-access-token";

    beforeEach(^{
      request = [LUOAuthTokenRequestFactory requestToLoginWithFacebookAccessToken:facebookAccessToken];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'oauth/access_token'", ^{
      [[request.path should] equal:@"oauth/access_token"];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{
        @"client_id" : apiKey,
        @"device_identifier" : deviceIdentifier,
        @"facebook_access_token" : facebookAccessToken,
        @"grant_type" : @"facebook"
      };

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
