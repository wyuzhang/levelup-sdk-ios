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

#import "LUDeepLinkAuthRequest.h"
#import "LUDeepLinkAuthResponse.h"
#import "LUMockKeychainAccess.h"
#import "LUOneTimePad.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LUDeepLinkResponseIntegrationSpec)

describe(@"Deep Link Auth responses", ^{
  NSString *accessToken = @"access-token";
  __block NSURL *responseURL;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    [UIApplication stub:@selector(sharedApplication) andReturn:[UIApplication mock]];
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[[LUMockKeychainAccess alloc] init]];

    LUOneTimePad *oneTimePad = [LUOneTimePad saveNewOneTimePad];

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
