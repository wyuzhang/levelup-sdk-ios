// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUUser.h"
#import "LUUserParameterBuilder.h"
#import "LUUserRequestFactory.h"

SPEC_BEGIN(LUUserRequestFactorySpec)

describe(@"LUUserRequestFactory", ^{
  __block LUAPIRequest *request;

  // Public Methods

  describe(@"requestForCurrentUser", ^{
    beforeEach(^{
      request = [LUUserRequestFactory requestForCurrentUser];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'users'", ^{
      [[request.path should] equal:@"users"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestForUserWithID:", ^{
    beforeEach(^{
      request = [LUUserRequestFactory requestForUserWithID:@1];
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

  describe(@"requestToCreateUser:", ^{
    LUUser *user = [[LUUser alloc] init];
    NSString *apiKey = @"api-key";
    NSDictionary *userParams = @{@"params" : @"for user"};

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:apiKey];
      [LUUserParameterBuilder stub:@selector(parametersForUser:) andReturn:userParams withArguments:user, nil];

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

    it(@"returns a request with parameters including the API key", ^{
      [[request.parameters[@"api_key"] should] equal:apiKey];
    });

    it(@"returns a request with parameters including the user", ^{
      [[request.parameters[@"user"] should] equal:userParams];
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

    it(@"returns a request to the path 'passwords'", ^{
      [[request.path should] equal:@"passwords"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with parameters for the user email", ^{
      NSDictionary *expectedParams = @{@"email" : email};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToUpdateUser:", ^{
    LUUser *user = [[LUUser alloc] init];
    NSDictionary *userParams = @{@"params" : @"for user"};

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];
      [LUUserParameterBuilder stub:@selector(parametersForUser:) andReturn:userParams withArguments:user, nil];

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
