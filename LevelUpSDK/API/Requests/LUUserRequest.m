#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUUser.h"
#import "LUUserRequest.h"

@implementation LUUserRequest

#pragma mark -
#pragma mark Public Methods

+ (LUAPIRequest *)connectToFacebookWithAccessToken:(NSString *)facebookAccessToken {
  NSString *path = [NSString stringWithFormat:@"users/%@/facebook_connections", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"facebook_access_token" : facebookAccessToken}];
}

+ (LUAPIRequest *)createUser:(LUUser *)user {
  NSDictionary *params = @{@"client_id" : [LUAPIClient sharedClient].levelUpClientId, @"user" : user.parameters};

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:@"users" parameters:params];
}

+ (LUAPIRequest *)disconnectFromFacebook {
  NSString *path = [NSString stringWithFormat:@"users/%@/facebook_connections", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"DELETE" path:path parameters:nil];
}

+ (LUAPIRequest *)getCurrentUser {
  NSString *path = [NSString stringWithFormat:@"users/%@", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

+ (LUAPIRequest *)removeCauseAffiliation {
  return [LUAPIRequest apiRequestWithMethod:@"DELETE" path:@"cause_affiliation" parameters:nil];
}

+ (LUAPIRequest *)resetPasswordWithEmail:(NSString *)email {
  return [LUAPIRequest apiRequestWithMethod:@"POST" path:@"users/forgot_password" parameters:@{@"user" : @{@"email" : email}}];
}

+ (LUAPIRequest *)setCauseId:(NSNumber *)causeId {
  return [LUAPIRequest apiRequestWithMethod:@"POST" path:@"cause_affiliation" parameters:@{@"cause_id" : causeId}];
}

+ (LUAPIRequest *)updateUser:(LUUser *)user {
  NSString *path = [NSString stringWithFormat:@"users/%@", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"PUT" path:path parameters:@{@"user" : user.parameters}];
}

@end
