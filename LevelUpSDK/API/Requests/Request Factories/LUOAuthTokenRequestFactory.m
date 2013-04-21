#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUDeviceIdentifier.h"
#import "LUOAuthTokenJSONFactory.h"
#import "LUOAuthTokenRequestFactory.h"

@implementation LUOAuthTokenRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password {
  return [self requestWithAdditionalParameters:@{
    @"grant_type" : @"password",
    @"username" : email,
    @"password" : password
  }];
}

+ (LUAPIRequest *)requestToLoginWithFacebookAccessToken:(NSString *)facebookAccessToken {
  return [self requestWithAdditionalParameters:@{
    @"grant_type" : @"facebook",
    @"facebook_access_token" : facebookAccessToken
  }];
}

#pragma mark - Private Methods

+ (LUAPIRequest *)requestWithAdditionalParameters:(NSDictionary *)additionalParameters {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:additionalParameters];
  parameters[@"client_id"] = [LUAPIClient sharedClient].apiKey;
  parameters[@"device_identifier"] = [LUDeviceIdentifier deviceIdentifier];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"oauth/access_token"
                                 parameters:parameters
                               modelFactory:[LUOAuthTokenJSONFactory factory]];
}

@end
