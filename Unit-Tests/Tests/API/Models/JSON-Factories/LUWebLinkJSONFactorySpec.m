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

#import "LUWebLinkJSONFactory.h"

SPEC_BEGIN(LUWebLinkJSONFactorySpec)

describe(@"LUWebLinkJSONFactory", ^{
  __block LUWebLinkJSONFactory *factory;

  beforeEach(^{
    factory = [LUWebLinkJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULocation", ^{
      NSDictionary *JSON = @{
        @"ios_deeplink_url" : @"example://",
        @"title": @"Example",
        @"web_link_type_id": @1,
        @"web_url": @"http://example.com"
      };
      LUWebLink *webLink = [factory createFromAttributes:JSON];

      [[webLink.deepLinkURL should] equal:[NSURL URLWithString:@"example://"]];
      [[webLink.title should] equal:@"Example"];
      [[webLink.webLinkTypeID should] equal:@1];
      [[webLink.webURL should] equal:[NSURL URLWithString:@"http://example.com"]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'web_link'", ^{
      [[[factory rootKey] should] equal:@"web_link"];
    });
  });
});

SPEC_END
