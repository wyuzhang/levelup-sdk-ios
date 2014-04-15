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
  [parameters lu_setSafeValue:[LUAPIClient sharedClient].apiKey forKey:@"api_key"];
  [parameters lu_setSafeValue:[LUDeviceIdentifier deviceIdentifier] forKey:@"device_identifier"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"access_tokens"
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"access_token": parameters}
                               modelFactory:[LUAccessTokenJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateDowngradedAccessTokenWithPermissions:(NSArray *)permissions {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"access_tokens/downgrades"
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"access_token": @{@"permission_keynames": permissions}}
                               modelFactory:[LUAccessTokenJSONFactory factory]];
}

@end
