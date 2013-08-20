#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUUser.h"
#import "LUUserParameterBuilder.h"
#import "LUUserRequestFactory.h"

SPEC_BEGIN(LUUserRequestFactorySpec)

describe(@"LUUserRequestFactory", ^{
  __block LUAPIRequest *request;

  // Public Methods

  describe(@"requestForCurrentUser", ^{
    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];
    });

    it(@"forwards the message to +requestForUserWithID:", ^{
      [[[LUUserRequestFactory should] receive] requestForUserWithID:@1];
      request = [LUUserRequestFactory requestForCurrentUser];
    });
  });

  describe(@"requestForUserWithID:", ^{
    beforeEach(^{
      request = [LUUserRequestFactory requestForUserWithID:@1];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'users/<userid>'", ^{
      [[request.path should] equal:@"users/1"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestToConnectToFacebookWithAccessToken:", ^{
    NSString *facebookAccessToken = @"facebook-access-token";

    beforeEach(^{
      request = [LUUserRequestFactory requestToConnectToFacebookWithAccessToken:facebookAccessToken];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'facebook_connections'", ^{
      [[request.path should] equal:@"facebook_connections"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with parameters for the facebook access token", ^{
      [[request.parameters should] equal:@{@"user" : @{@"facebook_access_token" : facebookAccessToken}}];
    });
  });

  describe(@"requestToCreateUser:", ^{
    LUUser *user = [[LUUser alloc] init];
    NSString *apiKey = @"api-key";
    NSDictionary *userParams = @{@"params" : @"for user"};

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:apiKey developmentMode:YES];
      [[LUUserParameterBuilder stubAndReturn:userParams] parametersForUser:user];

      request = [LUUserRequestFactory requestToCreateUser:user];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users'", ^{
      [[request.path should] equal:@"users"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with parameters including the API key as the client_id", ^{
      [[request.parameters[@"client_id"] should] equal:apiKey];
    });

    it(@"returns a request with parameters including the user", ^{
      [[request.parameters[@"user"] should] equal:userParams];
    });
  });

  describe(@"requestToCreateUserWithFacebookAccessToken:", ^{
    NSString *apiKey = @"api-key";
    NSString *facebookAccessToken = @"facebook-access-token";

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:apiKey developmentMode:YES];

      request = [LUUserRequestFactory requestToCreateUserWithFacebookAccessToken:facebookAccessToken];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users'", ^{
      [[request.path should] equal:@"users"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with parameters including the API key as the client_id", ^{
      [[request.parameters[@"client_id"] should] equal:apiKey];
    });

    it(@"returns a request with the Facebook access token nested under 'user'", ^{
      [[request.parameters[@"user"][@"facebook_access_token"] should] equal:facebookAccessToken];
    });
  });

  describe(@"requestToDisconnectFromFacebook", ^{
    beforeEach(^{
      request = [LUUserRequestFactory requestToDisconnectFromFacebook];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a DELETE request", ^{
      [[request.method should] equal:@"DELETE"];
    });

    it(@"returns a request to the path 'facebook_connections'", ^{
      [[request.path should] equal:@"facebook_connections"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestToResetPasswordWithEmail:", ^{
    NSString *email = @"test@example.com";

    beforeEach(^{
      request = [LUUserRequestFactory requestToResetPasswordWithEmail:email];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users/forgot_password'", ^{
      [[request.path should] equal:@"users/forgot_password"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with parameters for the user email", ^{
      NSDictionary *expectedParams = @{@"user" : @{@"email" : email}};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToUpdateUser:", ^{
    LUUser *user = [[LUUser alloc] init];
    NSDictionary *userParams = @{@"params" : @"for user"};

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];
      [[LUUserParameterBuilder stubAndReturn:userParams] parametersForUser:user];

      request = [LUUserRequestFactory requestToUpdateUser:user];
    });

    it(@"returns a PUT request", ^{
      [[request.method should] equal:@"PUT"];
    });

    it(@"returns a request to the path 'users/<userid>'", ^{
      [[request.path should] equal:@"users/1"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with parameters for the user", ^{
      [[request.parameters[@"user"] should] equal:userParams];
    });
  });
});

SPEC_END
