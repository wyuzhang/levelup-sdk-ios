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

#import "LUConstants.h"
#import "LUDeepLinkAuthResponse.h"
#import "LUOneTimePad.h"
#import "NSData+LUAdditions.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LUDeepLinkAuthResponseSpec)

describe(@"LUDeepLinkAuthResponse", ^{
  __block LUDeepLinkAuthResponse *response;
  BOOL accepted = YES;
  LUOneTimePad *oneTimePad = [LUOneTimePad fixture];
  NSString *paddedAccessToken = @"abc123";
  __block NSString *sourceApplication;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    sourceApplication = [LUAPIClient sharedClient].deepLinkAuthBundleID;
    [LUOneTimePad stub:@selector(load) andReturn:oneTimePad];
  });

  // Object Lifecycle Methods

  describe(@"responseWithURL:sourceApplication:", ^{
    beforeEach(^{
      NSDictionary *params = @{
       LUDeepLinkAuthPaddedAccessTokenURLParam: paddedAccessToken,
       LUDeepLinkAuthPermissionAcceptedURLParam: @"1"
      };
      NSURL *URL = [NSURL lu_URLWithScheme:@"targetapp"
                                      host:LUDeepLinkAuthRequestHost
                                      path:@"/"
                           queryParameters:params];

      response = [LUDeepLinkAuthResponse responseWithURL:URL sourceApplication:sourceApplication];
    });

    it(@"pulls the accepted flag from the URL", ^{
      [[theValue(response.accepted) should] beYes];
    });

    it(@"pulls the padded access token from the URL", ^{
      [[response.paddedAccessToken should] equal:paddedAccessToken];
    });

    it(@"sets the source application", ^{
      [[response.sourceApplication should] equal:sourceApplication];
    });
  });

  // Public Methods

  describe(@"isDeepLinkAuthResponseURL:", ^{
    context(@"when the URL host is LUDeepLinkResponseHost", ^{
      NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"app://%@", LUDeepLinkAuthResponseHost]];

      specify(^{
        [[theValue([LUDeepLinkAuthResponse isDeepLinkAuthResponseURL:URL]) should] beYes];
      });
    });

    context(@"when the URL host is not LUDeepLinkResponseHost", ^{
      NSURL *URL = [NSURL URLWithString:@"app://badhost/"];

      specify(^{
        [[theValue([LUDeepLinkAuthResponse isDeepLinkAuthResponseURL:URL]) should] beNo];
      });
    });
  });

  describe(@"responseURLWithScheme:accepted:paddedAccessToken:", ^{
    NSString *scheme = @"testapp";
    NSURL *URL = [LUDeepLinkAuthResponse responseURLWithScheme:scheme accepted:accepted paddedAccessToken:paddedAccessToken];

    it(@"generates a URL with the given scheme", ^{
      [[[URL scheme] should] equal:scheme];
    });

    it(@"generates a URL with the response host", ^{
      [[[URL host] should] equal:LUDeepLinkAuthResponseHost];
    });

    it(@"generates a URL containing the padded access token as a parameter", ^{
      [[[URL lu_queryDictionary][LUDeepLinkAuthPaddedAccessTokenURLParam] should] equal:paddedAccessToken];
    });

    it(@"generates a URL containing the accepted state", ^{
      [[[URL lu_queryDictionary][LUDeepLinkAuthPermissionAcceptedURLParam] should] equal:@"1"];
    });
  });

  describe(@"decodedAccessToken", ^{
    beforeEach(^{
      response = [[LUDeepLinkAuthResponse alloc] initWithAccepted:accepted
                                                paddedAccessToken:paddedAccessToken
                                                sourceApplication:sourceApplication];
    });

    it(@"decodes the padded access token using a stored one-time pad", ^{
      LUOneTimePad *pad = [LUOneTimePad mock];
      NSString *accessToken = @"access-token";

      [LUOneTimePad stub:@selector(loadOneTimePad) andReturn:pad];
      [pad stub:@selector(decodeString:) andReturn:accessToken withArguments:paddedAccessToken];

      [[[response decodedAccessToken] should] equal:accessToken];
    });
  });

  describe(@"validate", ^{
    context(@"when the source application doesn't match the deepLinkAuthBundleID", ^{
      beforeEach(^{
        response = [[LUDeepLinkAuthResponse alloc] initWithAccepted:accepted
                                                            paddedAccessToken:paddedAccessToken
                                                            sourceApplication:@"com.example.badapp"];
      });

      it(@"returns an LUDeepLinkAuthErrorWrongSourceApplication error", ^{
        [[theValue([[response validate] code]) should] equal:theValue(LUDeepLinkAuthErrorWrongSourceApplication)];
      });
    });

    context(@"when the request wasn't accepted", ^{
      beforeEach(^{
        response = [[LUDeepLinkAuthResponse alloc] initWithAccepted:NO
                                                  paddedAccessToken:paddedAccessToken
                                                  sourceApplication:sourceApplication];
      });

      it(@"returns an LUDeepLinkAuthErrorRequestRejected error", ^{
        [[theValue([[response validate] code]) should] equal:theValue(LUDeepLinkAuthErrorRequestRejected)];
      });
    });

    context(@"when the padded access token cannot be decoded", ^{
      beforeEach(^{
        response = [[LUDeepLinkAuthResponse alloc] initWithAccepted:accepted
                                                  paddedAccessToken:nil
                                                  sourceApplication:sourceApplication];
      });

      it(@"returns an LUDeepLinkAuthErrorMalformedResponse error", ^{
        [[theValue([[response validate] code]) should] equal:theValue(LUDeepLinkAuthErrorMalformedResponse)];
      });
    });

    context(@"when all parameters are valid", ^{
      beforeEach(^{
        response = [[LUDeepLinkAuthResponse alloc] initWithAccepted:accepted
                                                  paddedAccessToken:paddedAccessToken
                                                  sourceApplication:sourceApplication];
        [response stub:@selector(decodedAccessToken) andReturn:@"access-token"];
      });

      it(@"returns nil", ^{
        [[[response validate] should] beNil];
      });
    });
  });
});

SPEC_END
