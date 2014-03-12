// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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
