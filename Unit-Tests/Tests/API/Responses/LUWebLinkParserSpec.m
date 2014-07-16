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
