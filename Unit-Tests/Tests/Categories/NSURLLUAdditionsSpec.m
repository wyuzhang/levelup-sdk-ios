#import "NSURL+LUAdditions.h"

SPEC_BEGIN(NSURLLUAdditionsSpec)

describe(@"NSURL", ^{
  NSString *imageQueryParameters = @"density=2&height=212&width=320";

  beforeEach(^{
    [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];
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
});

SPEC_END
