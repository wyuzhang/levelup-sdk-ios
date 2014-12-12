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
#import "LUIBeaconCheckInRequestFactory.h"

SPEC_BEGIN(LUIBeaconCheckInRequestFactorySpec)

describe(@"LUIBeaconCheckInRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestToCheckInIBeaconWithMajor:minor:", ^{
    NSString *major = @"1";
    NSString *minor = @"2";

    beforeEach(^{
      request = [LUIBeaconCheckInRequestFactory requestToCheckInIBeaconWithMajor:major minor:minor];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'beacon_checkins", ^{
      NSString *expectedPath = @"beacon_checkins";

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with paramters including the major and minor ids", ^{
      NSDictionary *expectedParameters = @{@"beacon" : @{@"major_id": @"1", @"minor_id": @"2"}};

      [[request.parameters should] equal:expectedParameters];
    });
  });
});

SPEC_END
