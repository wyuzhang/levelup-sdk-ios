#import "LUAccessTokenJSONFactory.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAuthenticationRequestFactory.h"
#import "LUDeviceIdentifier.h"

@implementation LUAuthenticationRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password {
  return [self requestWithAdditionalParameters:@{
    @"username" : email,
    @"password" : password
  }];
}

+ (LUAPIRequest *)requestToLoginWithFacebookAccessToken:(NSString *)facebookAccessToken {
  return [self requestWithAdditionalParameters:@{
    @"facebook_access_token" : facebookAccessToken
  }];
}

#pragma mark - Private Methods

+ (LUAPIRequest *)requestWithAdditionalParameters:(NSDictionary *)additionalParameters {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:additionalParameters];
  parameters[@"client_id"] = [LUAPIClient sharedClient].apiKey;
  parameters[@"device_identifier"] = [LUDeviceIdentifier deviceIdentifier];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"access_tokens"
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"access_token" : parameters}
                               modelFactory:[LUAccessTokenJSONFactory factory]];
}

@end
