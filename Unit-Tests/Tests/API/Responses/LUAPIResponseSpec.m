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

#import "LUAPIResponse.h"
#import "LUWebLinkParser.h"

SPEC_BEGIN(LUAPIResponseSpec)

describe(@"LUAPIResponse", ^{
  describe(@"nextPageURL", ^{
    it(@"returns a parsed next page URL from the responses 'Link' header", ^{
      NSString *testLinkHeader = @"<http://example.com>; rel=\"next\"";

      NSHTTPURLResponse *HTTPURLResponse = [NSHTTPURLResponse mock];
      [HTTPURLResponse stub:@selector(allHeaderFields) andReturn:@{@"Link" : testLinkHeader}];

      LUWebLinkParser *webLinkParser = [LUWebLinkParser mock];
      [LUWebLinkParser stub:@selector(alloc) andReturn:webLinkParser];
      [webLinkParser stub:@selector(initWithHeaderValue:) andReturn:webLinkParser withArguments:testLinkHeader, nil];

      NSURL *nextPageURL = [NSURL URLWithString:@"http://example.com"];
      [[webLinkParser should] receive:@selector(nextURL) andReturn:nextPageURL];

      LUAPIResponse *response = [[LUAPIResponse alloc] initWithHTTPURLResponse:HTTPURLResponse];
      [[[response nextPageURL] should] equal:nextPageURL];
    });
  });
});

SPEC_END
