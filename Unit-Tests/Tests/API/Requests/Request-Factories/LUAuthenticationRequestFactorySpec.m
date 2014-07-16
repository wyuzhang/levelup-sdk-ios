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
#import "LUAuthenticationRequestFactory.h"
#import "LUDeviceIdentifier.h"

SPEC_BEGIN(LUAuthenticationRequestFactorySpec)

describe(@"LUAuthenticationRequestFactory", ^{
  __block LUAPIRequest *request;

  // Public Methods

  NSString *apiKey = @"api-key";
  NSString *deviceIdentifier = @"12345";

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:apiKey];
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
          @"api_key" : apiKey,
          @"device_identifier" : deviceIdentifier,
          @"password" : password,
          @"username" : email
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToCreateDowngradedAccessTokenWithPermissions:", ^{
    NSArray *permissions = @[@"create_orders", @"read_user_basic_info"];

    beforeEach(^{
      request = [LUAuthenticationRequestFactory requestToCreateDowngradedAccessTokenWithPermissions:permissions];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'access_tokens/downgrades'", ^{
      [[request.path should] equal:@"access_tokens/downgrades"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{
        @"access_token" : @{
          @"permission_keynames" : permissions
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
