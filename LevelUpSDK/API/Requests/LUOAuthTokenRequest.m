#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUOAuthToken.h"
#import "LUOAuthTokenRequest.h"
#import "LUParameterSerializer.h"

@implementation LUOAuthTokenRequest

+ (LUAPIRequest *)createOAuthToken:(LUOAuthToken *)oauthToken {
  NSDictionary *parameters = [LUParameterSerializer nonBlankParametersForModel:oauthToken
                                                                    attributes:@[@"clientId", @"deviceIdentifier", @"facebookAccessToken", @"grantType", @"password", @"username"]];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:@"oauth/access_token" parameters:parameters];
}

@end
