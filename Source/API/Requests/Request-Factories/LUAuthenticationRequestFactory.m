// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAccessTokenJSONFactory.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAuthenticationRequestFactory.h"
#import "LUDeviceIdentifier.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUAuthenticationRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:email forKey:@"username"];
  [parameters lu_setSafeValue:password forKey:@"password"];

  return [self requestWithAdditionalParameters:parameters];
}

+ (LUAPIRequest *)requestToLoginWithFacebookAccessToken:(NSString *)facebookAccessToken {
  if (!facebookAccessToken) facebookAccessToken = @"";

  return [self requestWithAdditionalParameters:@{
    @"facebook_access_token" : facebookAccessToken
  }];
}

#pragma mark - Private Methods

+ (LUAPIRequest *)requestWithAdditionalParameters:(NSDictionary *)additionalParameters {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:additionalParameters];
  [parameters lu_setSafeValue:[LUAPIClient sharedClient].apiKey forKey:@"client_id"];
  [parameters lu_setSafeValue:[LUDeviceIdentifier deviceIdentifier] forKey:@"device_identifier"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"access_tokens"
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"access_token" : parameters}
                               modelFactory:[LUAccessTokenJSONFactory factory]];
}

@end
