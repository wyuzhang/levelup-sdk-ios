// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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
