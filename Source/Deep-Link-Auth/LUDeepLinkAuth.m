// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUConstants.h"
#import "LUDeepLinkAuth.h"
#import "LUDeepLinkAuthRequest.h"
#import "LUDeepLinkAuthResponse.h"

@implementation LUDeepLinkAuth

#pragma mark - Public Methods

+ (void)authorizeWithPermissions:(NSArray *)permissions returnURLScheme:(NSString *)returnURLScheme {
  LUDeepLinkAuthRequest *request = [LUDeepLinkAuthRequest requestWithPermissions:permissions
                                                                 returnURLScheme:returnURLScheme];

  NSError *validationError = [request validateURL];
  if (validationError) {
    [self postErrorNotificationWithError:validationError];
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

#pragma mark - Private Methods

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
