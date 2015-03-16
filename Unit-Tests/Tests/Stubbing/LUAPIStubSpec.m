/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

SPEC_BEGIN(LUAPIStubSpec)

describe(@"LUAPIStubbing", ^{
  __block LUAPIStub *apiStub;
  NSString *apiVersion = LUAPIVersion15;
  BOOL authenticated = false;
  NSString *bodyHTML = @"<p>Test</p>";
  NSString *httpMethod = @"GET";
  __block LUAPIStub *otherStub;
  NSString *path = @"test";
  __block NSURLRequest *request;
  NSData *responseDataHTML = [@"<html><body><p>Test</p></body></html>" dataUsingEncoding:NSUTF8StringEncoding];
  NSData *responseDataJSON = [@"{\"ok\":true}" dataUsingEncoding:NSUTF8StringEncoding];
  NSString *responseString = @"<html><body><p>Test</p></body></html>";
  NSURL *webURL = [NSURL URLWithString:@"https://www.test.com"];

  beforeEach(^{
    [[LUAPIStubbing sharedInstance] disableNetConnect];
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[LUKeychainAccess nullMock]];
    [LUAPIClient setupWithAppID:@"1" APIKey:@"anApiKey" developmentMode:NO];
    apiStub = [LUAPIStub apiStubForVersion:apiVersion
                                      path:path
                                HTTPMethod:httpMethod
                             authenticated:authenticated
                              responseData:responseDataHTML];
    otherStub = [LUAPIStub apiStubForVersion:apiVersion
                                      path:path
                                HTTPMethod:httpMethod
                             authenticated:authenticated
                              responseData:responseDataHTML];
  });

  describe(@"init", ^{
    it(@"defaults to a 200 response code", ^{
      [[theValue(apiStub.responseCode) should] equal:theValue(200)];
    });
  });

  describe(@"apiStubForVersion:path:HTTPMethod:authenticated:responseData:", ^{
    it(@"creates a stub with the given parameters", ^{
      [[apiStub.URL should] equal:[NSURL URLWithString:@"https://api.thelevelup.com/v15/test"]];
      [[apiStub.HTTPMethod should] equal:httpMethod];
      [[theValue(apiStub.authenticated) should] equal:theValue(authenticated)];
      [[apiStub.responseData should] equal:responseDataHTML];
    });
  });

  describe(@"stubForWebURL:withBody:", ^{
    it(@"creates a web url stub with the given parameters", ^{
      LUAPIStub *stub = [LUAPIStub stubForWebURL:webURL withBody:bodyHTML];

      [[stub.URL should] equal:webURL];
      [[stub.HTTPMethod should] equal:@"GET"];
      [[stub.responseData should] equal:responseDataHTML];
      [[stub.responseType should] equal:@"text/html"];
    });
  });

  describe(@"stubForWebURL:withPlainTextResponseString:", ^{
    it(@"creates a web url stub with the given parameters", ^{
      LUAPIStub *stub = [LUAPIStub stubForWebURL:webURL withPlainTextResponseString:responseString];

      [[stub.URL should] equal:webURL];
      [[stub.HTTPMethod should] equal:@"GET"];
      [[stub.responseData should] equal:responseDataHTML];
      [[stub.responseType should] equal:@"text/plain"];
    });
  });

  describe(@"matchesRequest:", ^{
    context(@"when the given request matches the stub", ^{
      beforeEach(^{
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.thelevelup.com/v15/test"]];
      });

      it(@"returns YES", ^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.thelevelup.com/v15/test"]];
        BOOL result = [apiStub matchesRequest:request];

        [[theValue(result) should] beYes];
      });
    });

    context(@"when the given request doesn't match the stub", ^{
      beforeEach(^{
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.thelevelup.com/v15/fail"]];
      });

      it(@"returns NO", ^{
        BOOL result = [apiStub matchesRequest:request];

        [[theValue(result) should] beNo];
      });
    });
  });

  describe(@"response", ^{
    it(@"creates a stub response", ^{
      OHHTTPStubsResponse *stubResponse = [apiStub response];

      [[stubResponse.httpHeaders[@"Server"] should] equal:@"LevelUp"];
      [[theValue(stubResponse.responseTime) should] equal:theValue(0)];
      [[theValue(stubResponse.statusCode) should] equal:theValue(200)];
      [[stubResponse.responseData should] equal:responseDataHTML];
    });
  });

  describe(@"responseJSON", ^{
    beforeEach(^{
      apiStub.responseData = responseDataJSON;
    });

    it(@"creates a stub response json", ^{
      NSDictionary *stubResponseJSON = [apiStub responseJSON];
      [[stubResponseJSON should] equal:@{@"ok" : @YES}];
    });
  });

  describe(@"isEqual:", ^{
    it(@"is true for an equivalent object", ^{
      [[apiStub should] equal:otherStub];
    });

    it(@"is true for an equivalent object - reflexively", ^{
      [[otherStub should] equal:apiStub];
    });

    it(@"is false if the methods are different", ^{
      otherStub.HTTPMethod = @"POST";

      [[apiStub shouldNot] equal:otherStub];
    });

    it(@"is false if the paths are different", ^{
      otherStub.URL = [NSURL URLWithString:@"/newpath"];

      [[apiStub shouldNot] equal:otherStub];
    });

    it(@"is false if the parameters are different", ^{
      otherStub.requestBodyJSON = @{@"test2" : @2};

      [[apiStub shouldNot] equal:otherStub];
    });
  });
});

SPEC_END
