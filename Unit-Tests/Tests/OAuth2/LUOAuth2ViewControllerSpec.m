/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUOAuth2ViewController.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LUOAuth2ViewControllerSpec)

describe(@"LUOAuth2ViewController", ^{
  __block LUOAuth2ViewController *controller;
  __block NSObject<LUOAuth2ViewControllerDelegate> *delegate;
  NSString *email = @"test@example.com";
  NSArray *permissions = @[LUPermissionReadQRCode, LUPermissionReadUserBasicInfo];

  beforeEach(^{
    [[LUAPIStubbing sharedInstance] disableNetConnect];
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];

    delegate = [KWMock nullMockForProtocol:@protocol(LUOAuth2ViewControllerDelegate)];
    controller = [[LUOAuth2ViewController alloc] initWithDelegate:delegate
                                                            email:email
                                                      permissions:permissions];
  });

  // UIViewController Methods

  describe(@"viewDidLoad", ^{
    __block NSURL *webViewURL;

    beforeEach(^{
      [controller.webView stub:@selector(loadRequest:) withBlock:^id(NSArray *params) {
        webViewURL = [params[0] URL];
        return nil;
      }];
    });

    context(@"when developmentMode is off", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].developmentMode = NO;
      });

      it(@"loads a production request on the web view", ^{
        [controller viewDidLoad];

        [[webViewURL.host should] equal:@"www.thelevelup.com"];
      });
    });

    context(@"when developmentMode is on", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].developmentMode = YES;
      });

      it(@"loads a sandbox request on the web view", ^{
        [controller viewDidLoad];

        [[webViewURL.host should] equal:@"sandbox.thelevelup.com"];
      });
    });

    it(@"loads a new OAuth2 authorization on the web view", ^{
      [controller viewDidLoad];

      [[webViewURL.path should] equal:@"/oauth2/authorizations/new"];
    });

    it(@"loads a request on the web view with the expected query parameters", ^{
      [controller viewDidLoad];

      NSDictionary *params = [webViewURL lu_queryDictionary];
      [[params[@"client_id"] should] equal:@"api-key"];
      [[params[@"embedded"] should] equal:@"true"];
      [[params[@"login_hint"] should] equal:email];
      [[params[@"response_type"] should] equal:@"token"];
      [[params[@"scope"] should] equal:[NSString stringWithFormat:@"%@%%20%@", permissions[0], permissions[1]]];
      [[params[@"state"] should] equal:[@(controller.csrfToken) stringValue]];
    });
  });

  // Public Methods

  describe(@"navigationDialog", ^{
    __block UINavigationController *navController;
    __block UIBarButtonItem *rightBarButtonItem;

    beforeEach(^{
      navController = [controller navigationDialog];
      rightBarButtonItem = navController.navigationBar.topItem.rightBarButtonItem;
    });

    it(@"returns a UINavigationController with the controller as the root view controller", ^{
      [[[navController topViewController] should] equal:controller];
    });

    it(@"sets a Cancel button as the right bar button item", ^{
      [[rightBarButtonItem shouldNot] beNil];
    });

    context(@"when the Cancel button is selected", ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      it(@"stops loading the web view", ^{
        [[controller.webView should] receive:@selector(stopLoading)];

        [rightBarButtonItem.target performSelector:rightBarButtonItem.action];
      });

      it(@"notifies the delegate", ^{
        [[delegate should] receive:@selector(OAuth2ViewControllerWasCancelled:) withArguments:controller];

        [rightBarButtonItem.target performSelector:rightBarButtonItem.action];
      });
#pragma clang diagnostic pop
    });
  });

  // UIWebViewDelegate Methods

  describe(@"webView:shouldStartLoadWithRequest:navigationType:", ^{
    NSString *baseURLString = @"https://www.thelevelup.com/oauth2/fake_target";
    __block NSURL *URL;

    BOOL (^loadURL)(NSURL *) = ^(NSURL *URL) {
      return [controller webView:controller.webView shouldStartLoadWithRequest:[NSURLRequest requestWithURL:URL]
                  navigationType:UIWebViewNavigationTypeReload];
    };

    context(@"when the request contains an access token in the fragment", ^{
      NSString *accessToken = @"access-token";

      context(@"when the request contains a state that matches the CSRF token", ^{
        beforeEach(^{
          URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@#access_token=%@&state=%@",
                                      baseURLString, accessToken, [@(controller.csrfToken) stringValue]]];
        });

        it(@"notifies the delegate", ^{
          [[delegate should] receive:@selector(OAuth2ViewController:didSucceedWithAccessToken:)
                       withArguments:controller, accessToken, nil];

          loadURL(URL);
        });

        it(@"returns NO", ^{
          [[theValue(loadURL(URL)) should] beNo];
        });
      });

      context(@"when the request contains a state that doesn't match the CSRF token", ^{
        beforeEach(^{
          URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@#access_token=%@&state=%@",
                                      baseURLString, accessToken, [@(controller.csrfToken + 1) stringValue]]];
        });

        it(@"doesn't notify the delegate of success", ^{
          loadURL(URL);

          [[delegate shouldNot] receive:@selector(OAuth2ViewController:didSucceedWithAccessToken:)];
        });

        it(@"notifies the delegate of an error", ^{
          [[delegate should] receive:@selector(OAuth2ViewController:didFailWithErrorCode:errorDescription:)];

          loadURL(URL);
        });

        it(@"returns NO", ^{
          [[theValue(loadURL(URL)) should] beNo];
        });
      });
    });

    context(@"when the request contains an error in the fragment", ^{
      NSString *errorCode = @"invalid_scope";
      NSString *errorDescription = @"Scope is invalid";

      beforeEach(^{
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@#error=%@&error_description=%@",
                                    baseURLString, errorCode, [errorDescription stringByReplacingOccurrencesOfString:@" " withString:@"+"]]];
      });

      it(@"notifies the delegate", ^{
        [[delegate should] receive:@selector(OAuth2ViewController:didFailWithErrorCode:errorDescription:)
                     withArguments:controller, errorCode, errorDescription, nil];

        loadURL(URL);
      });

      it(@"returns NO", ^{
        [[theValue(loadURL(URL)) should] beNo];
      });
    });

    context(@"when the request doesn't contain an access token or an error", ^{
      it(@"returns YES", ^{
        [[theValue(loadURL([NSURL URLWithString:baseURLString])) should] beYes];
      });
    });
  });

  describe(@"webViewDidFinishLoad:", ^{
    it(@"notifies the delegate", ^{
      [[delegate should] receive:@selector(OAuth2ViewControllerDidFinishLoad:) withArguments:controller];

      [controller webViewDidFinishLoad:controller.webView];
    });
  });

  describe(@"webViewDidStartLoad:", ^{
    it(@"notifies the delegate", ^{
      [[delegate should] receive:@selector(OAuth2ViewControllerDidStartLoad:) withArguments:controller];

      [controller webViewDidStartLoad:controller.webView];
    });
  });
});

SPEC_END
