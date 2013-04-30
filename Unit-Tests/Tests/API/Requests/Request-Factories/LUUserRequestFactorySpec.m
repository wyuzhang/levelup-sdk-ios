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

      request = [LUUserRequestFactory requestForCurrentUser];
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
  });

  describe(@"requestToConnectToFacebookWithAccessToken:", ^{
    NSString *facebookAccessToken = @"facebook-access-token";

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUUserRequestFactory requestToConnectToFacebookWithAccessToken:facebookAccessToken];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users/<userid>/facebook_connections'", ^{
      [[request.path should] equal:@"users/1/facebook_connections"];
    });

    it(@"returns a request with parameters for the facebook access token", ^{
      [[request.parameters should] equal:@{@"facebook_access_token" : facebookAccessToken}];
    });
  });

  describe(@"requestToCreateUser:", ^{
    LUUser *user = [[LUUser alloc] init];
    NSString *apiKey = @"api-key";
    NSDictionary *userParams = @{@"params" : @"for user"};

    beforeEach(^{
      [LUAPIClient setupWithAPIKey:apiKey developmentMode:YES];
      [[LUUserParameterBuilder stubAndReturn:userParams] parametersForUser:user];

      request = [LUUserRequestFactory requestToCreateUser:user];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users'", ^{
      [[request.path should] equal:@"users"];
    });

    it(@"returns a request with parameters including the API key as the clientId", ^{
      [[request.parameters[@"client_id"] should] equal:apiKey];
    });

    it(@"returns a request with parameters including the user", ^{
      [[request.parameters[@"user"] should] equal:userParams];
    });
  });

  describe(@"requestToDisconnectFromFacebook", ^{
    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUUserRequestFactory requestToDisconnectFromFacebook];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a DELETE request", ^{
      [[request.method should] equal:@"DELETE"];
    });

    it(@"returns a request to the path 'users/<userid>/facebook_connections'", ^{
      [[request.path should] equal:@"users/1/facebook_connections"];
    });
  });

  describe(@"requestToRemoveCauseAffiliation", ^{
    beforeEach(^{
      request = [LUUserRequestFactory requestToRemoveCauseAffiliation];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a DELETE request", ^{
      [[request.method should] equal:@"DELETE"];
    });

    it(@"returns a request to the path 'cause_affiliation'", ^{
      [[request.path should] equal:@"cause_affiliation"];
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

    it(@"returns a request with parameters for the user email", ^{
      NSDictionary *expectedParams = @{@"user" : @{@"email" : email}};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToSetCauseId:", ^{
    NSNumber *causeId = @2;

    beforeEach(^{
      request = [LUUserRequestFactory requestToSetCauseId:causeId];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'cause_affiliation'", ^{
      [[request.path should] equal:@"cause_affiliation"];
    });

    it(@"returns a request with parameters for the causeId", ^{
      [[request.parameters should] equal:@{@"cause_id" : causeId}];
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

    it(@"returns a request with parameters for the user", ^{
      [[request.parameters[@"user"] should] equal:userParams];
    });
  });
});

SPEC_END
