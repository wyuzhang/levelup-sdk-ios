#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUOAuthToken.h"
#import "LUOAuthTokenRequest.h"

@implementation LUOAuthTokenRequest

+ (LUAPIRequest *)createOAuthToken:(LUOAuthToken *)oauthToken {
  return [LUAPIRequest apiRequestWithMethod:@"POST" path:@"oauth/access_token" parameters:oauthToken.parameters];
}

@end
