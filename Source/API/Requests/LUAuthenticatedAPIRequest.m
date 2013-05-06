#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"

@implementation LUAuthenticatedAPIRequest

- (id)initWithMethod:(NSString *)method path:(NSString *)path apiVersion:(NSString *)apiVersion parameters:(NSDictionary *)parameters modelFactory:(LUAbstractJSONModelFactory *)modelFactory {
  NSMutableDictionary *parametersWithAccessToken = [NSMutableDictionary dictionary];

  if ([LUAPIClient sharedClient].accessToken) {
    parametersWithAccessToken[@"access_token"] = [LUAPIClient sharedClient].accessToken;
  }

  if (parameters) {
    [parametersWithAccessToken addEntriesFromDictionary:parameters];
  }

  return [super initWithMethod:method path:path apiVersion:apiVersion parameters:[NSDictionary dictionaryWithDictionary:parametersWithAccessToken] modelFactory:modelFactory];
}

@end
