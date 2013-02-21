#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUOAuthTokenModelBuilder.h"
#import "LUUser.h"
#import "LUUserParameterBuilder.h"
#import "LUUserRequestBuilder.h"

@implementation LUUserRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCurrentUser {
  NSString *path = [NSString stringWithFormat:@"users/%@", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

+ (LUAPIRequest *)requestToConnectToFacebookWithAccessToken:(NSString *)facebookAccessToken {
  NSString *path = [NSString stringWithFormat:@"users/%@/facebook_connections", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"facebook_access_token" : facebookAccessToken}];
}

+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"client_id"] = [LUAPIClient sharedClient].apiKey;
  params[@"user"] = [LUUserParameterBuilder parametersForUser:user];

  LUAPIRequest *request = [LUAPIRequest apiRequestWithMethod:@"POST" path:@"users" parameters:params];
  request.modelBuilder = [LUOAuthTokenModelBuilder builder];
  return request;
}

+ (LUAPIRequest *)requestToDisconnectFromFacebook {
  NSString *path = [NSString stringWithFormat:@"users/%@/facebook_connections", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"DELETE" path:path parameters:nil];
}

+ (LUAPIRequest *)requestToRemoveCauseAffiliation {
  return [LUAPIRequest apiRequestWithMethod:@"DELETE" path:@"cause_affiliation" parameters:nil];
}

+ (LUAPIRequest *)requestToResetPasswordWithEmail:(NSString *)email {
  return [LUAPIRequest apiRequestWithMethod:@"POST" path:@"users/forgot_password" parameters:@{@"user" : @{@"email" : email}}];
}

+ (LUAPIRequest *)requestToSetCauseId:(NSNumber *)causeId {
  return [LUAPIRequest apiRequestWithMethod:@"POST" path:@"cause_affiliation" parameters:@{@"cause_id" : causeId}];
}

+ (LUAPIRequest *)requestToUpdateUser:(LUUser *)user {
  NSString *path = [NSString stringWithFormat:@"users/%@", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"PUT" path:path parameters:@{@"user" : [LUUserParameterBuilder parametersForUser:user]}];
}

@end
