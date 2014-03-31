// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUDeepLinkAuth.h"
#import "LUDeepLinkAuthRequest.h"
#import "LUDeepLinkAuthResponse.h"
#import "NSError+LUAdditions.h"

SPEC_BEGIN(LUDeepLinkAuthSpec)

describe(@"LUDeepLinkAuth", ^{
  NSArray *permissions = @[@"create_orders", @"read_user_basic_info"];
  NSString *returnURLScheme = @"test";

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"test-api-key" developmentMode:YES];

    [UIApplication stub:@selector(sharedApplication) andReturn:[UIApplication nullMock]];
    [[UIApplication sharedApplication] stub:@selector(openURL:)];
  });

  describe(@"authorizeWithPermissions:returnURLScheme:", ^{
    __block LUDeepLinkAuthRequest *request;
    NSError *error = [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorPermissionsRequired
                                               description:@"permissions required"];

    beforeEach(^{
      [UIApplication stub:@selector(sharedApplication) andReturn:[UIApplication nullMock]];
      [[UIApplication sharedApplication] stub:@selector(openURL:)];

      request = [LUDeepLinkAuthRequest nullMock];
      [LUDeepLinkAuthRequest stub:@selector(requestWithPermissions:returnURLScheme:)
                        andReturn:request];
    });

    it(@"creates a request with the arguments", ^{
      [[LUDeepLinkAuthRequest should] receive:@selector(requestWithPermissions:returnURLScheme:)
                                withArguments:permissions, returnURLScheme];

      [LUDeepLinkAuth authorizeWithPermissions:permissions returnURLScheme:returnURLScheme];
    });

    context(@"when the request is invalid", ^{
      beforeEach(^{
        [request stub:@selector(validateURL) andReturn:error];
      });

      it(@"posts a LUDeepLinkAuthErrorNotification with the error", ^{
        [[[NSNotificationCenter defaultCenter] should] receive:@selector(postNotificationName:object:userInfo:)
                                                 withArguments:LUDeepLinkAuthErrorNotification, any(), @{LUDeepLinkAuthNotificationErrorKey: error}];

        [LUDeepLinkAuth authorizeWithPermissions:permissions returnURLScheme:returnURLScheme];
      });

      it(@"doesn't open a URL", ^{
        [[[UIApplication sharedApplication] shouldNot] receive:@selector(openURL:)];

        [LUDeepLinkAuth authorizeWithPermissions:permissions returnURLScheme:returnURLScheme];
      });
    });

    context(@"when the request is valid", ^{
      NSURL *URL = [NSURL URLWithString:@"example://"];

      beforeEach(^{
        [request stub:@selector(validateURL) andReturn:nil];
        [request stub:@selector(URL) andReturn:URL];
      });

      it(@"opens the request's URL", ^{
        [[[UIApplication sharedApplication] should] receive:@selector(openURL:) withArguments:URL];

        [LUDeepLinkAuth authorizeWithPermissions:permissions returnURLScheme:returnURLScheme];
      });

      it(@"doesn't post an LUDeepLinkAuthErrorNotification", ^{
        [[[NSNotificationCenter defaultCenter] shouldNot] receive:@selector(postNotificationName:object:userInfo:)
                                                    withArguments:LUDeepLinkAuthErrorNotification, any(), any()];

        [LUDeepLinkAuth authorizeWithPermissions:permissions returnURLScheme:returnURLScheme];
      });
    });
  });

  describe(@"handleOpenURL:sourceApplication:", ^{
    __block LUDeepLinkAuthResponse *response;

    NSURL *URL = [NSURL URLWithString:@"response:///"];
    NSString *sourceApplication = @"com.example.app";

    beforeEach(^{
      response = [LUDeepLinkAuthResponse nullMock];
      [LUDeepLinkAuthResponse stub:@selector(responseWithURL:sourceApplication:)
                         andReturn:response];
    });

    context(@"when the URL is not a Deep Link Auth response URL", ^{
      beforeEach(^{
        [LUDeepLinkAuthResponse stub:@selector(isDeepLinkAuthResponseURL:)
                           andReturn:theValue(NO)
                       withArguments:URL];
      });

      it(@"returns NO", ^{
        [[theValue([LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication]) should] beNo];
      });

      it(@"doesn't send any notifications", ^{
        [[[NSNotificationCenter defaultCenter] shouldNot] receive:@selector(postNotificationName:object:userInfo:)];

        [LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication];
      });
    });

    context(@"when the URL is a Deep Link Auth response URL", ^{
      NSString *decodedAccessToken = @"access-token";

      beforeEach(^{
        [response stub:@selector(decodedAccessToken) andReturn:decodedAccessToken];
        [LUDeepLinkAuthResponse stub:@selector(isDeepLinkAuthResponseURL:)
                           andReturn:theValue(YES)
                       withArguments:URL];
      });

      it(@"creates a response with the URL and source application", ^{
        [[LUDeepLinkAuthResponse should] receive:@selector(responseWithURL:sourceApplication:)
                                   withArguments:URL, sourceApplication, nil];

        [LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication];
      });

      context(@"when the response is invalid", ^{
        NSError *error = [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorPermissionsRequired
                                                   description:@"permissions required"];

        beforeEach(^{
          [response stub:@selector(validate) andReturn:error];
        });

        it(@"posts a LUDeepLinkAuthErrorNotification with the error", ^{
          [[[NSNotificationCenter defaultCenter] should] receive:@selector(postNotificationName:object:userInfo:)
                                                   withArguments:LUDeepLinkAuthErrorNotification, any(), @{LUDeepLinkAuthNotificationErrorKey: error}];

          [LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication];
        });

        it(@"doesn't post a LUDeepLinkAuthSuccessNotification", ^{
          [[[NSNotificationCenter defaultCenter] shouldNot] receive:@selector(postNotificationName:object:userInfo:)
                                                      withArguments:LUDeepLinkAuthSuccessNotification, any(), any()];

          [LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication];
        });

        it(@"returns YES", ^{
          [[theValue([LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication]) should] beYes];
        });
      });

      context(@"when the response is valid", ^{
        beforeEach(^{
          [response stub:@selector(validate) andReturn:nil];
        });

        it(@"doesn't post a LUDeepLinkAuthErrorNotification", ^{
          [[[NSNotificationCenter defaultCenter] shouldNot] receive:@selector(postNotificationName:object:userInfo:)
                                                      withArguments:LUDeepLinkAuthErrorNotification, any(), any()];

          [LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication];
        });

        it(@"posts a LUDeepLinkAuthSuccessNotification containing the decoded access token", ^{
          [[[NSNotificationCenter defaultCenter] should] receive:@selector(postNotificationName:object:userInfo:)
                                                   withArguments:LUDeepLinkAuthSuccessNotification, any(), @{LUDeepLinkAuthNotificationAccessTokenKey: decodedAccessToken}];

          [LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication];
        });

        it(@"returns YES", ^{
          [[theValue([LUDeepLinkAuth handleOpenURL:URL sourceApplication:sourceApplication]) should] beYes];
        });
      });
    });
  });
});

SPEC_END
