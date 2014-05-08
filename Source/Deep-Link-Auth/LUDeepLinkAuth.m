// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUConstants.h"
#import "LUDeepLinkAuth.h"
#import "LUDeepLinkAuthInstallAlert.h"
#import "LUDeepLinkAuthRequest.h"
#import "LUDeepLinkAuthResponse.h"
#import "NSURL+LUAdditions.h"

@implementation LUDeepLinkAuth

#pragma mark - Public Methods

+ (void)authorizeWithPermissions:(NSArray *)permissions returnURLScheme:(NSString *)returnURLScheme {
  LUDeepLinkAuthRequest *request = [LUDeepLinkAuthRequest requestWithPermissions:permissions
                                                                 returnURLScheme:returnURLScheme];

  NSError *validationError = [request validateURL];
  if (validationError) {
    [self handleAuthorizationError:validationError];
    return;
  }

  [[UIApplication sharedApplication] openURL:[request URL]];
}

+ (BOOL)handleOpenURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication {
  if (![LUDeepLinkAuthResponse isDeepLinkAuthResponseURL:URL]) {
    return NO;
  }

  LUDeepLinkAuthResponse *response = [LUDeepLinkAuthResponse responseWithURL:URL
                                                           sourceApplication:sourceApplication];

  NSError *validationError = [response validate];
  if (validationError) {
    [self postErrorNotificationWithError:validationError];
  } else {
    [self postSuccessNotificationWithAccessToken:[response decodedAccessToken]];
  }

  return YES;
}

+ (BOOL)isDeepLinkAuthAppInstalled {
  NSURL *deepLinkAuthURL = [NSURL lu_URLWithScheme:[LUAPIClient sharedClient].deepLinkAuthURLScheme
                                              host:LUDeepLinkAuthRequestHost
                                              path:@"/"
                                   queryParameters:nil];

  return [[UIApplication sharedApplication] canOpenURL:deepLinkAuthURL];
}

#pragma mark - Private Methods

+ (void)handleAuthorizationError:(NSError *)error {
  if ([LUDeepLinkAuthInstallAlert shouldShowForError:error]) {
    [LUDeepLinkAuthInstallAlert showAlert];
  } else {
    [self postErrorNotificationWithError:error];
  }
}

+ (void)postErrorNotificationWithError:(NSError *)error {
  [[NSNotificationCenter defaultCenter] postNotificationName:LUDeepLinkAuthErrorNotification
                                                      object:self
                                                    userInfo:@{LUDeepLinkAuthNotificationErrorKey: error}];
}

+ (void)postSuccessNotificationWithAccessToken:(NSString *)accessToken {
  [[NSNotificationCenter defaultCenter] postNotificationName:LUDeepLinkAuthSuccessNotification
                                                      object:self
                                                    userInfo:@{LUDeepLinkAuthNotificationAccessTokenKey: accessToken}];
}

@end
