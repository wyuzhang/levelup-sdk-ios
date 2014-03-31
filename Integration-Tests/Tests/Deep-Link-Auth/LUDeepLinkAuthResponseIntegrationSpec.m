#import "LUDeepLinkAuthRequest.h"
#import "LUDeepLinkAuthResponse.h"
#import "LUOneTimePad.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LUDeepLinkResponseIntegrationSpec)

describe(@"Deep Link Auth responses", ^{
  NSString *accessToken = @"access-token";
  __block NSURL *responseURL;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    [UIApplication stub:@selector(sharedApplication) andReturn:[UIApplication mock]];

    LUOneTimePad *oneTimePad = [LUOneTimePad loadOneTimePad];

    responseURL = [NSURL lu_URLWithScheme:@"testapp"
                                     host:LUDeepLinkAuthResponseHost
                                     path:@"/"
                          queryParameters:@{
                                            LUDeepLinkAuthPaddedAccessTokenURLParam: [oneTimePad encodeString:accessToken],
                                            LUDeepLinkAuthPermissionAcceptedURLParam: @"1"
                                          }];
  });

  context(@"a successful response", ^{
    __block NSString *sourceApplication;

    beforeEach(^{
      sourceApplication = [LUAPIClient sharedClient].deepLinkAuthBundleID;
    });

    it(@"is handled", ^{
      [[theValue([LUDeepLinkAuth handleOpenURL:responseURL sourceApplication:sourceApplication]) should] beYes];
    });

    it(@"posts a LUDeepLinkAuthSuccessNotification containing the access token", ^{
      [[[NSNotificationCenter defaultCenter] should] receive:@selector(postNotificationName:object:userInfo:)
                                               withArguments:LUDeepLinkAuthSuccessNotification, any(), @{LUDeepLinkAuthNotificationAccessTokenKey: accessToken}];

      [LUDeepLinkAuth handleOpenURL:responseURL sourceApplication:sourceApplication];
    });
  });

  context(@"a request with an error", ^{
    __block NSString *sourceApplication;

    beforeEach(^{
      sourceApplication = @"com.example.invalid";
    });

    it(@"is handled", ^{
      [[theValue([LUDeepLinkAuth handleOpenURL:responseURL sourceApplication:sourceApplication]) should] beYes];
    });

    it(@"posts a LUDeepLinkAuthErrorNotification", ^{
      [[[NSNotificationCenter defaultCenter] should] receive:@selector(postNotificationName:object:userInfo:)
                                               withArguments:LUDeepLinkAuthErrorNotification, any(), any()];

      [LUDeepLinkAuth handleOpenURL:responseURL sourceApplication:sourceApplication];
    });
  });
});

SPEC_END
