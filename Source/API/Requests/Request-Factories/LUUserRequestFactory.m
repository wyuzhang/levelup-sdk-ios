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
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"users"
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUUserJSONFactory factory]];
}

+ (LUAPIRequest *)requestForUserWithID:(NSNumber *)userID {
  NSString *path = [NSString stringWithFormat:@"users/%@", userID];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUUserJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"api_key"] = [LUAPIClient sharedClient].apiKey;
  params[@"user"] = [LUUserParameterBuilder parametersForUser:user];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"users"
                                 apiVersion:LUAPIVersion14
                                 parameters:params
                               modelFactory:[LUUserJSONFactory factory]];
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
