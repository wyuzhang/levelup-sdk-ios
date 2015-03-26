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

#import <AFNetworking/AFNetworking.h>
#import "LUAPIClient.h"
#import "LUConstants.h"
#import "LUOAuth2ViewController.h"
#import "NSURL+LUAdditions.h"

@implementation LUOAuth2ViewController

#pragma mark - Object Creation

- (instancetype)initWithDelegate:(id<LUOAuth2ViewControllerDelegate>)delegate
                           email:(NSString *)email
                     permissions:(NSArray *)permissions {
  NSParameterAssert(email.length > 0);
  NSParameterAssert(permissions.count > 0);

  self = [super initWithNibName:nil bundle:nil];
  if (!self) return nil;

  _delegate = delegate;
  _csrfToken = (int)arc4random();
  _email = email;
  _permissions = permissions;
  _webView = [[UIWebView alloc] initWithFrame:CGRectZero];

  return self;
}

- (void)dealloc {
  _webView.delegate = nil;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Connect To LevelUp";
  self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

  self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  self.webView.delegate = self;
  self.webView.frame = self.view.bounds;
  [self.view addSubview:self.webView];

  [self.webView loadRequest:[self startURLRequest]];
}

#pragma mark - Public Methods

- (UINavigationController *)navigationDialog {
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                         target:self
                                                                                         action:@selector(cancelWasPressed)];

  return [[UINavigationController alloc] initWithRootViewController:self];
}

#pragma mark - Event Methods

- (void)cancelWasPressed {
  [self.webView stopLoading];

  if ([self.delegate respondsToSelector:@selector(OAuth2ViewControllerWasCancelled:)]) {
    [self.delegate OAuth2ViewControllerWasCancelled:self];
  }
}

#pragma mark - UIWebViewDelegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
  NSDictionary *fragmentParameters = [request.URL lu_fragmentDictionary];

  if (fragmentParameters[@"access_token"]) {
    if ([fragmentParameters[@"state"] intValue] == self.csrfToken) {
      [self.delegate OAuth2ViewController:self didSucceedWithAccessToken:fragmentParameters[@"access_token"]];
    } else {
      [self.delegate OAuth2ViewController:self
                     didFailWithErrorCode:@"invalid_state"
                         errorDescription:@"State does not match response from server."];
    }

    return NO;
  } else if (fragmentParameters[@"error"]) {
    NSString *errorCode = fragmentParameters[@"error"];
    NSString *errorDescription = [fragmentParameters[@"error_description"] stringByReplacingOccurrencesOfString:@"+" withString:@" "];

    [self.delegate OAuth2ViewController:self didFailWithErrorCode:errorCode errorDescription:errorDescription];
    return NO;
  }

  return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  if ([self.delegate respondsToSelector:@selector(OAuth2ViewControllerDidFinishLoad:)]) {
    [self.delegate OAuth2ViewControllerDidFinishLoad:self];
  }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  if ([self.delegate respondsToSelector:@selector(OAuth2ViewControllerDidStartLoad:)]) {
    [self.delegate OAuth2ViewControllerDidStartLoad:self];
  }
}

#pragma mark - Private Methods

- (NSURLRequest *)startURLRequest {
  NSURL *baseURL;
  if ([LUAPIClient sharedClient].developmentMode) {
    baseURL = [NSURL URLWithString:LevelUpOAuth2BaseURLDevelopment];
  } else {
    baseURL = [NSURL URLWithString:LevelUpOAuth2BaseURLProduction];
  }

  NSString *URLString = [[NSURL URLWithString:@"oauth2/authorizations/new" relativeToURL:baseURL] absoluteString];

  NSDictionary *parameters = @{
    @"client_id": [LUAPIClient sharedClient].apiKey,
    @"embedded": @"true",
    @"login_hint": self.email,
    @"response_type": @"token",
    @"scope": [self.permissions componentsJoinedByString:@" "],
    @"state": @(self.csrfToken)
  };

  AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
  return [requestSerializer requestWithMethod:@"GET"
                                    URLString:URLString
                                   parameters:parameters
                                        error:nil];
}

@end
