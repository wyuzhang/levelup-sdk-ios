// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAccessTokenJSONFactory.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUDeviceIdentifier.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "LUUserParameterBuilder.h"
#import "LUUserRequestFactory.h"

@implementation LUUserRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCurrentUser {
  return [self requestForUserWithID:[LUAPIClient sharedClient].currentUserID];
}

+ (LUAPIRequest *)requestForUserWithID:(NSNumber *)userID {
  NSString *path = [NSString stringWithFormat:@"users/%@", userID];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUUserJSONFactory factory]];
}

+ (LUAPIRequest *)requestToConnectToFacebookWithAccessToken:(NSString *)facebookAccessToken {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"facebook_connection"
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"user" : @{@"facebook_access_token" : facebookAccessToken}}
                               modelFactory:nil];
}

+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"client_id"] = [LUAPIClient sharedClient].apiKey;
  params[@"user"] = [LUUserParameterBuilder parametersForUser:user];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"users"
                                 apiVersion:LUAPIVersion14
                                 parameters:params
                               modelFactory:[LUUserJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateUserWithFacebookAccessToken:(NSString *)facebookAccessToken {
  if (facebookAccessToken.length == 0) return nil;

  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"client_id"] = [LUAPIClient sharedClient].apiKey;
  params[@"user"] = [NSMutableDictionary dictionary];

  if ([LUDeviceIdentifier deviceIdentifier]) {
    params[@"user"][@"device_identifier"] = [LUDeviceIdentifier deviceIdentifier];
  }

  params[@"user"][@"facebook_access_token"] = facebookAccessToken;

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"users"
                                 apiVersion:LUAPIVersion14
                                 parameters:params
                               modelFactory:[LUUserJSONFactory factory]];
}

+ (LUAPIRequest *)requestToDisconnectFromFacebook {
  return [LUAPIRequest apiRequestWithMethod:@"DELETE"
                                       path:@"facebook_connection"
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:nil];
}

+ (LUAPIRequest *)requestToResetPasswordWithEmail:(NSString *)email {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"passwords"
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"email" : email}
                               modelFactory:nil];
}

+ (LUAPIRequest *)requestToUpdateUser:(LUUser *)user {
  NSString *path = [NSString stringWithFormat:@"users/%@", [LUAPIClient sharedClient].currentUserID];

  return [LUAPIRequest apiRequestWithMethod:@"PUT"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"user" : [LUUserParameterBuilder parametersForUser:user]}
                               modelFactory:[LUUserJSONFactory factory]];
}

@end
