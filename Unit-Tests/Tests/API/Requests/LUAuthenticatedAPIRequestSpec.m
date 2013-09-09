// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAbstractJSONModelFactory.h"
#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"

SPEC_BEGIN(LUAuthenticatedAPIRequestSpec)

describe(@"LUAuthenticatedAPIRequest", ^{
  NSString *method = @"GET";
  NSString *path = @"/example";
  NSString *apiVersion = LUAPIVersion13;
  NSDictionary *parameters = @{@"test" : @1};
  LUAbstractJSONModelFactory *modelFactory = [LUAbstractJSONModelFactory mock];

  __block LUAuthenticatedAPIRequest *request;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"anApiKey" developmentMode:YES];

    request = [[LUAuthenticatedAPIRequest alloc] initWithMethod:method
                                                           path:path
                                                     apiVersion:apiVersion
                                                     parameters:parameters
                                                   modelFactory:modelFactory];
  });

  it(@"is a LUAPIRequest", ^{
    [[request should] beKindOfClass:[LUAPIRequest class]];
  });

  describe(@"urlRequest", ^{
    NSString *accessToken = @"access-token";

    context(@"when an access token is set", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = accessToken;
      });

      it(@"adds the access token to the Authorization header", ^{
        NSMutableURLRequest *urlRequest = [request URLRequest];

        NSString *expectedAuthorizationHeader = [NSString stringWithFormat:@"token %@", accessToken];
        [[[urlRequest allHTTPHeaderFields][@"Authorization"] should] equal:expectedAuthorizationHeader];
      });
    });

    context(@"when an access token is not set", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = nil;
      });

      it(@"doesn't add an Authorization header", ^{
        NSMutableURLRequest *urlRequest = [request URLRequest];

        [[urlRequest allHTTPHeaderFields][@"Authorization"] shouldBeNil];
      });
    });
  });
});

SPEC_END
