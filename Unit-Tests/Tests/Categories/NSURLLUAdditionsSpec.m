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
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(NSURLLUAdditionsSpec)

describe(@"NSURL", ^{
  NSString *imageQueryParameters = @"density=2&height=212&width=320";

  beforeEach(^{
    [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];

    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
  });

  describe(@"lu_imageURLForCampaignWithID:", ^{
    context(@"when the campaignID is nil", ^{
      specify(^{
        [[NSURL lu_imageURLForCampaignWithID:nil] shouldBeNil];
      });
    });

    context(@"when the campaignID is not nil", ^{
      NSNumber *campaignID = @1;

      it(@"returns a URL with to the campaign's image with image parameters added", ^{
        NSURL *expectedURL = [NSURL URLWithString:[@"v14/campaigns/1/image?" stringByAppendingString:imageQueryParameters]
                                    relativeToURL:[LUAPIClient sharedClient].baseURL];

        [[[NSURL lu_imageURLForCampaignWithID:campaignID] should] equal:expectedURL];
      });
    });
  });

  describe(@"lu_imageURLForImageWithBase:", ^{
    context(@"when the base is nil", ^{
      specify(^{
        [[NSURL lu_imageURLForImageWithBase:nil] shouldBeNil];
      });
    });

    context(@"when the base is not nil", ^{
      NSURL *baseURL = [NSURL URLWithString:@"http://www.example.com/path/to/image"];

      it(@"returns the base URL with image parameters added", ^{
        NSURL *expectedURL = [NSURL URLWithString:[@"http://www.example.com/path/to/image?" stringByAppendingString:imageQueryParameters]];

        [[[NSURL lu_imageURLForImageWithBase:baseURL] should] equal:expectedURL];
      });
    });
  });

  describe(@"lu_imageURLForLocationWithID:", ^{
    context(@"when the locationID is nil", ^{
      specify(^{
        [[NSURL lu_imageURLForLocationWithID:nil] shouldBeNil];
      });
    });

    context(@"when the locationID is not nil", ^{
      NSNumber *locationID = @1;

      it(@"returns a URL with to the location's image with image parameters added", ^{
        NSURL *expectedURL = [NSURL URLWithString:[@"v14/locations/1/image?" stringByAppendingString:imageQueryParameters]
                                    relativeToURL:[LUAPIClient sharedClient].baseURL];

        [[[NSURL lu_imageURLForLocationWithID:locationID] should] equal:expectedURL];
      });
    });
  });

  describe(@"lu_URLWithScheme:host:path:queryParameters:", ^{
    NSString *scheme = @"example";
    NSString *host = @"host";
    NSString *path = @"/path";
    NSDictionary *params = @{@"key1": @"value1", @"key2": @"value2"};

    NSURL *url = [NSURL lu_URLWithScheme:scheme host:host path:path queryParameters:params];

    it(@"returns a URL with the correct scheme", ^{
      [[[url scheme] should] equal:scheme];
    });

    it(@"returns a URL with the correct host", ^{
      [[[url host] should] equal:host];
    });

    it(@"returns a URL with the correct path", ^{
      [[[url path] should] equal:path];
    });

    it(@"returns a URL with the correct query string", ^{
      NSArray *queryParams = [[url query] componentsSeparatedByString:@"&"];
      [[queryParams should] containObjects:@"key1=value1", @"key2=value2", nil];
    });
  });

  describe(@"lu_pathAndQueryWithoutAPIVersion", ^{
    it(@"returns the URL's path and query parameters", ^{
      NSString *path = @"path/to/resource?a=1&b=2";
      NSURL *URL = [NSURL URLWithString:[@"http://www.example.com/" stringByAppendingString:path]];

      [[[URL lu_pathAndQueryWithoutAPIVersion] should] equal:path];
    });

    context(@"when the URL has no query parameters", ^{
      it(@"doesn't return any query parameters", ^{
        NSString *path = @"path/to/resource";
        NSURL *URL = [NSURL URLWithString:[@"http://www.example.com/" stringByAppendingString:path]];

        [[[URL lu_pathAndQueryWithoutAPIVersion] should] equal:path];
      });
    });

    context(@"when the path starts with a version number", ^{
      it(@"returns the path and parameters without the version", ^{
        NSString *path = @"path/to/resource?a=1&b=2";
        NSURL *URL = [NSURL URLWithString:[@"http://www.example.com/v13/" stringByAppendingString:path]];

        [[[URL lu_pathAndQueryWithoutAPIVersion] should] equal:path];
      });
    });
  });

  describe(@"lu_queryDictionary", ^{
    it(@"parses the query into a dictionary", ^{
      NSURL *url = [NSURL URLWithString:@"http://example.com/path?field=value&a=1"];

      [[[url lu_queryDictionary] should] equal:@{@"field": @"value", @"a": @"1"}];
    });

    it(@"uses a value of '' when a value is missing", ^{
      NSURL *url = [NSURL URLWithString:@"http://example.com/path?field=value&a"];

      [[[url lu_queryDictionary] should] equal:@{@"field": @"value", @"a": @""}];
    });

    it(@"converts fields ending in '[]' into arrays", ^{
      NSURL *url = [NSURL URLWithString:@"http://example.com/path?field[]=1&field[]=2"];

      [[[url lu_queryDictionary] should] equal:@{@"field": @[@"1", @"2"]}];
    });

    it(@"decodes fields and values", ^{
      NSURL *url = [NSURL URLWithString:@"http://example.com/path?field%2B=value%3D"];

      [[[url lu_queryDictionary] should] equal:@{@"field+": @"value="}];
    });
  });
});

SPEC_END
