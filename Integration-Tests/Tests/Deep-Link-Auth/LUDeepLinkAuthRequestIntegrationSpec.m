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

SPEC_BEGIN(LUDeepLinkRequestIntegrationSpec)

describe(@"Deep Link Auth requests", ^{
  NSArray *permissions = @[@"create_orders", @"read_user_basic_info"];

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    [UIApplication stub:@selector(sharedApplication) andReturn:[UIApplication mock]];
    [LUDeepLinkAuth stub:@selector(isDeepLinkAuthAppInstalled) andReturn:theValue(YES)];
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[[LUMockKeychainAccess alloc] init]];
  });

  context(@"a successful request", ^{
    NSString *returnURLScheme = @"test";
    __block NSURL *URL;

    beforeEach(^{
      [[UIApplication sharedApplication] stub:@selector(canOpenURL:) andReturn:theValue(YES)];
      [[UIApplication sharedApplication] stub:@selector(openURL:)];

      KWCaptureSpy *spy = [[UIApplication sharedApplication] captureArgument:@selector(openURL:) atIndex:0];

      [LUDeepLinkAuth authorizeWithPermissions:permissions returnURLScheme:returnURLScheme];

      URL = spy.argument;
    });

    it(@"opens a properly configured URL to the correct Deep Link Auth app", ^{
      [[[URL scheme] should] equal:[LUAPIClient sharedClient].deepLinkAuthURLScheme];
      [[[URL host] should] equal:LUDeepLinkAuthRequestHost];

      NSDictionary *params = [URL lu_queryDictionary];
      [[params[LUDeepLinkAuthAppIDURLParam] should] equal:[LUAPIClient sharedClient].appID];
      [[[LUOneTimePad oneTimePadWithBase64EncodedString:params[LUDeepLinkAuthOneTimePadURLParam]] should] equal:[LUOneTimePad loadOneTimePad]];
      [[params[LUDeepLinkAuthPermissionsURLParam] should] equal:permissions];
      [[params[LUDeepLinkAuthReturnURLSchemeURLParam] should] equal:returnURLScheme];
    });
  });

  context(@"a request with an error", ^{
    NSString *returnURLScheme = nil;

    it(@"doesn't open a URL", ^{
      [[[UIApplication sharedApplication] shouldNot] receive:@selector(openURL:)];

      [LUDeepLinkAuth authorizeWithPermissions:permissions returnURLScheme:returnURLScheme];
    });

    it(@"posts a LUDeepLinkAuthErrorNotification", ^{
      [[[NSNotificationCenter defaultCenter] should] receive:@selector(postNotificationName:object:userInfo:)
                                               withArguments:LUDeepLinkAuthErrorNotification, any(), any()];

      [LUDeepLinkAuth authorizeWithPermissions:permissions returnURLScheme:returnURLScheme];
    });
  });
});

SPEC_END
