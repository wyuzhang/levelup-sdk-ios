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

  beforeEach(^{
    [LUAPIClient setupWithAPIKey:@"anApiKey" developmentMode:YES];
  });

  it(@"is a LUAPIRequest", ^{
    LUAuthenticatedAPIRequest *request = [[LUAuthenticatedAPIRequest alloc] initWithMethod:method
                                                                                      path:path
                                                                                apiVersion:apiVersion
                                                                                parameters:parameters
                                                                              modelFactory:modelFactory];

    [[request should] beKindOfClass:[LUAPIRequest class]];
  });

  describe(@"initWithMethod:path:parameters:modelFactory", ^{
    NSString *accessToken = @"access-token";

    context(@"when an access token is set", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = accessToken;
      });

      it(@"adds the access token to the parameters", ^{
        LUAuthenticatedAPIRequest *request = [[LUAuthenticatedAPIRequest alloc] initWithMethod:method
                                                                                          path:path
                                                                                    apiVersion:apiVersion
                                                                                    parameters:parameters
                                                                                  modelFactory:modelFactory];

        [[request.parameters[@"access_token"] should] equal:accessToken];
        [[request.parameters[@"test"] should] equal:parameters[@"test"]];
      });
    });

    context(@"when an access token is not set", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = nil;
      });

      it(@"sets the parameters without an access token", ^{
        LUAuthenticatedAPIRequest *request = [[LUAuthenticatedAPIRequest alloc] initWithMethod:method
                                                                                          path:path
                                                                                    apiVersion:apiVersion
                                                                                    parameters:parameters
                                                                                  modelFactory:modelFactory];

        [[request.parameters should] equal:parameters];
        [request.parameters[@"access_token"] shouldBeNil];
      });
    });
  });
});

SPEC_END
