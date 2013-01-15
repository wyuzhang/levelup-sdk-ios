#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUParameterSerializer.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "LUUserRequest.h"

@implementation LUUserRequest

#pragma mark -
#pragma mark Public Methods

+ (LUAPIRequest *)connectToFacebookWithAccessToken:(NSString *)facebookAccessToken {
  NSString *path = [NSString stringWithFormat:@"users/%@/facebook_connections", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"facebook_access_token" : facebookAccessToken}];
}

+ (LUAPIRequest *)createUser:(LUUser *)user {
  NSDictionary *params = @{@"client_id" : [LUAPIClient sharedClient].apiKey, @"user" : [self parametersForUser:user]};

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

  return [LUAPIRequest apiRequestWithMethod:@"PUT" path:path parameters:@{@"user" : [self parametersForUser:user]}];
}

#pragma mark - Private Methods

+ (NSDictionary *)parametersForUser:(LUUser *)user {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];

  [params addEntriesFromDictionary:
   [LUParameterSerializer nonBlankParametersForModel:user attributes:@[@"bornAt", @"customAttributes",
    @"deviceIdentifier", @"divisionId", @"email", @"employer", @"firstName", @"gender", @"lastName", @"lat", @"lng",
    @"percentDonation", @"promotionCode", @"subscribed", @"termsAcceptedAt"]]];

  if (user.newPassword.length > 0) {
    params[@"new_password"] = user.newPassword;
    params[@"new_password_confirmation"] = user.newPassword;
  }

  if (user.userAddresses) {
    [user.userAddresses enumerateObjectsUsingBlock:^(LUUserAddress *address, NSUInteger idx, BOOL *stop) {
      params[[NSString stringWithFormat:@"user_addresses_attributes[%d]", idx]] =
      [LUParameterSerializer parametersForModel:address attributes:@[@"addressType", @"extendedAddress",
       @"modelId", @"locality", @"postalCode", @"region", @"streetAddress"]];
    }];
  }
  
  return params;
}

@end
