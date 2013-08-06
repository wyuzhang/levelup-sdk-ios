#import "LUWebLinkParser.h"

SPEC_BEGIN(LUWebLinkParserSpec)

describe(@"LUWebLinkParser", ^{
  describe(@"nextURL", ^{
    context(@"failing header values", ^{
      context(@"when the header value is nil", ^{
        it(@"is nil", ^{
          LUWebLinkParser *webLinkParser = [[LUWebLinkParser alloc] initWithHeaderValue:nil];

          [webLinkParser.nextURL shouldBeNil];
        });
      });

      context(@"when the header value is an empty string", ^{
        it(@"is nil", ^{
          LUWebLinkParser *webLinkParser = [[LUWebLinkParser alloc] initWithHeaderValue:@""];

          [webLinkParser.nextURL shouldBeNil];
        });
      });

      context(@"when the header value is malformed", ^{
        it(@"is nil", ^{
          LUWebLinkParser *webLinkParser = [[LUWebLinkParser alloc] initWithHeaderValue:@"bad header value"];

          [webLinkParser.nextURL shouldBeNil];
        });
      });

      context(@"when the header value has a URL with no relation types", ^{
        it(@"is nil", ^{
          LUWebLinkParser *webLinkParser = [[LUWebLinkParser alloc] initWithHeaderValue:@"<http://example.com>"];

          [webLinkParser.nextURL shouldBeNil];
        });
      });

      context(@"when the header value has a URL without a 'next' relation type", ^{
        it(@"is nil", ^{
          LUWebLinkParser *webLinkParser = [[LUWebLinkParser alloc] initWithHeaderValue:@"<http://example.com>; rel=\"prev\""];

          [webLinkParser.nextURL shouldBeNil];
        });
      });
    });

    context(@"successful header values", ^{
      context(@"when the header value has a URL with a 'next' relation type", ^{
        it(@"returns the URL", ^{
          LUWebLinkParser *webLinkParser = [[LUWebLinkParser alloc] initWithHeaderValue:@"<http://example.com>; rel=\"next\""];

          [[webLinkParser.nextURL should] equal:[NSURL URLWithString:@"http://example.com"]];
        });
      });

      context(@"when the header value has a URL with multiple relation types including 'next'", ^{
        it(@"returns the URL", ^{
          LUWebLinkParser *webLinkParser = [[LUWebLinkParser alloc] initWithHeaderValue:@"<http://example.com>; rel=\"next\"; rel=\"foo\""];

          [[webLinkParser.nextURL should] equal:[NSURL URLWithString:@"http://example.com"]];
        });
      });

      context(@"when the header value has a URL with a 'next' relation type and other params", ^{
        it(@"returns the URL", ^{
          LUWebLinkParser *webLinkParser = [[LUWebLinkParser alloc] initWithHeaderValue:@"<http://example.com>; rel=\"next\"; title=\"Next Page\""];

          [[webLinkParser.nextURL should] equal:[NSURL URLWithString:@"http://example.com"]];
        });
      });
    });
  });
});

SPEC_END
