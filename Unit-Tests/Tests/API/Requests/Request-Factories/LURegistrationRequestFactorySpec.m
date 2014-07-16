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
