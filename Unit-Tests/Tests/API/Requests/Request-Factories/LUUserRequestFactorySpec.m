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

  describe(@"requestToCreateUser:withPermissions:", ^{
    LUUser *user = [LUUser fixture];
    NSString *apiKey = @"api-key";
    NSArray *permissions = @[@"create_orders", @"read_qr_code"];
    NSDictionary *userParams = @{@"email": user.email, @"first_name": user.firstName, @"last_name": user.lastName};

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:apiKey];

      request = [LUUserRequestFactory requestToCreateUser:user withPermissions:permissions];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'apps/users'", ^{
      [[request.path should] equal:@"apps/users"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with parameters including the API key", ^{
      [[request.parameters[@"api_key"] should] equal:apiKey];
    });

    it(@"returns a request with parameters including the permissions", ^{
      [[request.parameters[@"permission_keynames"] should] equal:permissions];
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
      [LUUserParameterBuilder stub:@selector(parametersForUser:) andReturn:userParams withArguments:user, nil];

      request = [LUUserRequestFactory requestToUpdateUser:user];
    });

    it(@"returns a PUT request", ^{
      [[request.method should] equal:@"PUT"];
    });

    it(@"returns a request to the path 'users'", ^{
      [[request.path should] equal:@"users"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with parameters for the user", ^{
      [[request.parameters[@"user"] should] equal:userParams];
    });
  });
});

SPEC_END
