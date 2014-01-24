// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIError.h"
#import "LUAPIErrorBuilder.h"
#import "LUConstants.h"

NSError *errorWithHTTPStatusCode(NSInteger statusCode) {
  NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"http://example.com"]
                                                            statusCode:statusCode
                                                           HTTPVersion:@"HTTP/1.1"
                                                          headerFields:nil];

  return [NSError errorWithDomain:AFNetworkingErrorDomain
                             code:NSURLErrorBadServerResponse
                         userInfo:@{AFNetworkingOperationFailingURLResponseErrorKey : response}];
}

SPEC_BEGIN(LUAPIErrorBuilderSpec)

describe(@"LUAPIErrorBuilder", ^{
  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"test"];
  });

  describe(@"error:withMessagesFromJSON:", ^{
    context(@"when the network is not reachable", ^{
      NSError *error = [NSError errorWithDomain:@"TestErrorDomain" code:0 userInfo:nil];

      beforeEach(^{
        [[LUAPIClient sharedClient] stub:@selector(networkReachabilityStatus)
                               andReturn:theValue(AFNetworkReachabilityStatusNotReachable)];
      });

      it(@"returns an LUAPIErrorNetwork error", ^{
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

        [[result.domain should] equal:LUAPIErrorDomain];
        [[theValue(result.code) should] equal:theValue(LUAPIErrorNetwork)];
      });
    });

    context(@"when a JSON error is passed in", ^{
      NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                           code:NSPropertyListReadCorruptError
                                       userInfo:nil];

      it(@"returns an LUAPIErrorParsing error", ^{
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

        [[result.domain should] equal:LUAPIErrorDomain];
        [[theValue(result.code) should] equal:theValue(LUAPIErrorParsing)];
      });
    });

    context(@"when the error contains an HTTP response with code 401", ^{
      NSError *error = errorWithHTTPStatusCode(401);

      it(@"returns an LUAPIErrorLoginRequired error", ^{
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

        [[result.domain should] equal:LUAPIErrorDomain];
        [[theValue(result.code) should] equal:theValue(LUAPIErrorLoginRequired)];
      });
    });

    context(@"when the error contains an HTTP response with code 501", ^{
      NSError *error = errorWithHTTPStatusCode(501);

      it(@"returns an LUAPIErrorUpgrade error", ^{
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

        [[result.domain should] equal:LUAPIErrorDomain];
        [[theValue(result.code) should] equal:theValue(LUAPIErrorUpgrade)];
      });
    });

    context(@"when the error contains an HTTP response with code 503", ^{
      NSError *error = errorWithHTTPStatusCode(503);

      it(@"returns an LUAPIErrorMaintenance error", ^{
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

        [[result.domain should] equal:LUAPIErrorDomain];
        [[theValue(result.code) should] equal:theValue(LUAPIErrorMaintenance)];
      });
    });

    context(@"when the error contains an unmatched HTTP response", ^{
      NSError *error = errorWithHTTPStatusCode(500);

      it(@"returns an LUAPIErrorServer error", ^{
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

        [[result.domain should] equal:LUAPIErrorDomain];
        [[theValue(result.code) should] equal:theValue(LUAPIErrorServer)];
      });
    });

    context(@"when an unmatched error is passed in", ^{
      NSError *error = [NSError errorWithDomain:@"TestErrorDomain" code:0 userInfo:nil];

      it(@"returns an LUAPIErrorServer error", ^{
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

        [[result.domain should] equal:LUAPIErrorDomain];
        [[theValue(result.code) should] equal:theValue(LUAPIErrorServer)];
      });
    });

    context(@"when the JSON is not nil", ^{
      NSError *error = errorWithHTTPStatusCode(500);
      NSDictionary *JSON = @{@"name" : @"John Doe"};

      it(@"adds the JSON to the userInfo", ^{
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

        [[result.userInfo[LUAPIErrorKeyJSONResponse] should] equal:JSON];
      });

      context(@"when the JSON includes an error_description", ^{
        NSError *error = errorWithHTTPStatusCode(500);
        NSString *errorMessage = @"error message";
        NSDictionary *JSON = @{@"error_description" : errorMessage};

        it(@"adds it to the userInfo", ^{
          NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

          [[result.userInfo[LUAPIErrorKeyErrorMessage] should] equal:errorMessage];
        });
      });

      context(@"when the JSON includes an error", ^{
        NSError *error = errorWithHTTPStatusCode(500);
        NSString *errorMessage = @"error message";
        NSDictionary *JSON = @{@"error" : errorMessage};

        it(@"adds it to the userInfo", ^{
          NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

          [[result.userInfo[LUAPIErrorKeyErrorMessage] should] equal:errorMessage];
        });
      });

      context(@"when the JSON includes an error_description and an error", ^{
        it(@"adds the error_description to the userInfo", ^{
          NSDictionary *JSON = @{@"error" : @"error message", @"error_description" : @"error_description message"};
          NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

          [[result.userInfo[LUAPIErrorKeyErrorMessage] should] equal:JSON[@"error_description"]];
        });
      });

      context(@"when the JSON contains an array of v14 errors", ^{
        NSError *error = errorWithHTTPStatusCode(500);

        NSDictionary *fullJSONObject = @{
          @"message" : @"error message",
          @"object" : @"user",
          @"property" : @"first_name"
        };

        NSDictionary *fullJSONObject2 = @{
          @"message" : @"second message",
          @"object" : @"location",
          @"property" : @"name"
        };

        NSArray *JSON = @[@{@"error" : fullJSONObject}, @{@"error" : fullJSONObject2}];

        it(@"parses the errors and adds them to the userInfo", ^{
          NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

          NSArray *errors = result.userInfo[LUAPIErrorKeyAPIErrors];

          [[errors should] haveCountOf:2];

          [[errors[0] should] beKindOfClass:[LUAPIError class]];
          [[[errors[0] message] should] equal:JSON[0][@"error"][@"message"]];
          [[[errors[0] object] should] equal:JSON[0][@"error"][@"object"]];
          [[[errors[0] property] should] equal:JSON[0][@"error"][@"property"]];

          [[errors[1] should] beKindOfClass:[LUAPIError class]];
          [[[errors[1] message] should] equal:JSON[1][@"error"][@"message"]];
          [[[errors[1] object] should] equal:JSON[1][@"error"][@"object"]];
          [[[errors[1] property] should] equal:JSON[1][@"error"][@"property"]];
        });

        it(@"sets the first error's message in the userInfo", ^{
          NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

          [[result.userInfo[LUAPIErrorKeyErrorMessage] should] equal:JSON[0][@"error"][@"message"]];
        });
      });
    });
  });
});

SPEC_END
