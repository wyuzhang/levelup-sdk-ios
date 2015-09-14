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

#import "LUAbstractJSONModelFactory.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"

SPEC_BEGIN(LUAPIRequestSpec)

describe(@"LUAPIRequest", ^{
  NSString *method = @"GET";
  NSString *path = @"example";
  NSString *apiVersion = LUAPIVersion14;
  NSDictionary *parameters = @{@"test" : @1};
  LUAbstractJSONModelFactory *modelFactory = [LUAbstractJSONModelFactory mock];
  NSArray *retryResponseCodes = @[@202];
  NSTimeInterval retryTimeInterval = 0.5;
  NSURL *URL = [NSURL URLWithString:@"https://api.thelevelup.com/v14/example"];

  __block LUAPIRequest *apiRequest;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"anApiKey"];
    LUKeychainAccess *keychainAccess = [LUKeychainAccess nullMock];
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:keychainAccess];
  });

  // Object Lifecycle Methods

  describe(@"apiRequestWithMethod:URL:parameters:modelFactory:", ^{
    it(@"returns a new LUAPIRequest with the given arguments", ^{
      LUAPIRequest *result = [LUAPIRequest apiRequestWithMethod:method
                                                            URL:URL
                                                     parameters:parameters
                                                   modelFactory:modelFactory];

      [[result should] beKindOfClass:[LUAPIRequest class]];
      [[result.method should] equal:method];
      [[result.URL.absoluteString should] equal:@"https://api.thelevelup.com/v14/example?test=1"];
      [[result.parameters should] equal:parameters];
      [[result.modelFactory should] equal:modelFactory];
    });
  });

  describe(@"apiRequestWithMethod:path:apiVersion:parameters:modelFactory:", ^{
    it(@"returns a new LUAPIRequest with the given arguments", ^{
      LUAPIRequest *result = [LUAPIRequest apiRequestWithMethod:method
                                                           path:path
                                                     apiVersion:apiVersion
                                                     parameters:parameters
                                                   modelFactory:modelFactory];

      [[result should] beKindOfClass:[LUAPIRequest class]];
      [[result.method should] equal:method];
      [[result.path should] equal:path];
      [[result.apiVersion should] equal:apiVersion];
      [[result.parameters should] equal:parameters];
      [[result.modelFactory should] equal:modelFactory];
    });
  });

  describe(@"apiRequestWithMethod:path:apiVersion:parameters:modelFactory:retryResponseCodes:retryTimeInterval:", ^{
    it(@"returns a new LUAPIRequest with the given arguments", ^{
      LUAPIRequest *result = [LUAPIRequest apiRequestWithMethod:method
                                                           path:path
                                                     apiVersion:apiVersion
                                                     parameters:parameters
                                                   modelFactory:modelFactory
                                             retryResponseCodes:retryResponseCodes
                                              retryTimeInterval:retryTimeInterval];

      [[result should] beKindOfClass:[LUAPIRequest class]];
      [[result.method should] equal:method];
      [[result.path should] equal:path];
      [[result.apiVersion should] equal:apiVersion];
      [[result.parameters should] equal:parameters];
      [[result.modelFactory should] equal:modelFactory];
      [[result.retryResponseCodes should] equal:retryResponseCodes];
      [[theValue(result.retryTimeInterval) should] equal:theValue(retryTimeInterval)];
    });
  });

  describe(@"apiRequestWithMethod:URL:parameters:modelFactory:retryResponseCodes:retryTimeInterval:", ^{
    it(@"returns a new LUAPIRequest with the given arguments", ^{
      LUAPIRequest *result = [LUAPIRequest apiRequestWithMethod:method
                                                            URL:URL
                                                     parameters:parameters
                                                   modelFactory:modelFactory
                                             retryResponseCodes:retryResponseCodes
                                              retryTimeInterval:retryTimeInterval];

      [[result should] beKindOfClass:[LUAPIRequest class]];
      [[result.method should] equal:method];
      [[result.URL.absoluteString should] equal:@"https://api.thelevelup.com/v14/example?test=1"];
      [[result.parameters should] equal:parameters];
      [[result.modelFactory should] equal:modelFactory];
      [[result.retryResponseCodes should] equal:retryResponseCodes];
      [[theValue(result.retryTimeInterval) should] equal:theValue(retryTimeInterval)];
    });
  });

  // Public Methods

  describe(@"URLRequest", ^{
    beforeEach(^{
      apiRequest = [LUAPIRequest apiRequestWithMethod:method
                                                 path:path
                                           apiVersion:apiVersion
                                           parameters:parameters
                                         modelFactory:modelFactory];
    });

    it(@"returns the NSURLRequest generated by the LUAPIClient, with matching parameters", ^{
      NSString *fullPath = [NSString stringWithFormat:@"%@/%@", apiVersion, path];
      NSURLRequest *expected = [[LUAPIClient sharedClient] requestWithMethod:method
                                                                        path:fullPath
                                                                  parameters:parameters];

      [[[apiRequest URLRequest] should] equal:expected];
    });

    context(@"when an access token is set on the LUAPIClient", ^{
      NSString *accessToken = @"access-token";

      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = accessToken;
      });

      it(@"adds the access token to the Authorization header", ^{
        NSMutableURLRequest *urlRequest = [apiRequest URLRequest];

        NSString *expectedAuthorizationHeader = [NSString stringWithFormat:@"token %@", accessToken];
        [[[urlRequest allHTTPHeaderFields][@"Authorization"] should] equal:expectedAuthorizationHeader];
      });
    });

    context(@"when an access token is not set", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = nil;
      });

      it(@"doesn't add an Authorization header", ^{
        NSMutableURLRequest *urlRequest = [apiRequest URLRequest];

        [[urlRequest allHTTPHeaderFields][@"Authorization"] shouldBeNil];
      });
    });
  });

  // NSObject Methods

  describe(@"equality", ^{
    __block LUAPIRequest *request1, *request2;

    beforeEach(^{
      request1 = [LUAPIRequest apiRequestWithMethod:method
                                               path:path
                                         apiVersion:apiVersion
                                         parameters:parameters
                                       modelFactory:modelFactory];
      request2 = [LUAPIRequest apiRequestWithMethod:method
                                               path:path
                                         apiVersion:apiVersion
                                         parameters:parameters
                                       modelFactory:modelFactory];
    });

    describe(@"hash", ^{
      it(@"generates the same hash for an equivalent object", ^{
        [[theValue([request1 hash]) should] equal:theValue([request2 hash])];
      });

      it(@"generates different hashes if the method is different", ^{
        request2.method = @"POST";

        [[theValue([request1 hash]) shouldNot] equal:theValue([request2 hash])];
      });

      it(@"generates different hashes if the path is different", ^{
        request2.path = @"/newpath";

        [[theValue([request1 hash]) shouldNot] equal:theValue([request2 hash])];
      });

      it(@"generates different hashes if the apiVersion is different", ^{
        request2.apiVersion = @"newVersion";

        [[theValue([request1 hash]) shouldNot] equal:theValue([request2 hash])];
      });

      it(@"generates different hashes if the parameters are different", ^{
        request2.parameters = @{@"test2" : @2};

        [[theValue([request1 hash]) shouldNot] equal:theValue([request2 hash])];
      });
    });

    describe(@"isEqual:", ^{
      it(@"is true for an equivalent object", ^{
        [[request1 should] equal:request2];
      });

      it(@"is true for an equivalent object - reflexively", ^{
        [[request2 should] equal:request1];
      });

      it(@"is false if the methods are different", ^{
        request2.method = @"POST";

        [[request1 shouldNot] equal:request2];
      });

      it(@"is false if the paths are different", ^{
        request2.path = @"/newpath";

        [[request1 shouldNot] equal:request2];
      });

      it(@"is false if the API versions are different", ^{
        request2.apiVersion = @"newVersion";

        [[request1 shouldNot] equal:request2];
      });

      it(@"is false if the parameters are different", ^{
        request2.parameters = @{@"test2" : @2};

        [[request1 shouldNot] equal:request2];
      });
    });
  });
});

SPEC_END
