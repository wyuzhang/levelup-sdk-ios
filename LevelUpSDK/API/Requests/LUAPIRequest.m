#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LURootKeyModelBuilder.h"

@implementation LUAPIRequest

#pragma mark - Object Lifecycle Methods

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters {
  return [[self alloc] initWithMethod:method path:path parameters:parameters includeAccessToken:YES];
}

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters
                    includeAccessToken:(BOOL)includeAccessToken {
  return [[self alloc] initWithMethod:method path:path parameters:parameters includeAccessToken:includeAccessToken];
}

- (id)initWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters includeAccessToken:(BOOL)includeAccessToken {
  self = [super init];
  if (self) {
    _includeAccessToken = includeAccessToken;
    _modelBuilder = [LURootKeyModelBuilder builder];
    _method = method;
    _path = path;
    _parameters = parameters;
  }

  return self;
}

#pragma mark - Public Methods

- (NSURLRequest *)urlRequest {
  return [[LUAPIClient sharedClient] requestWithMethod:self.method path:self.path parameters:[self parametersWithAccessToken]];
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.method) {
    total += [self.method hash] * 11;
  }
  if (self.path) {
    total += [self.path hash] * 13;
  }
  if (self.parameters) {
    total += [[self.parameters description] hash] * 17;
  }

  total += [@(self.includeAccessToken) hash] * 19;

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUAPIRequest class]]) {
    LUAPIRequest *otherApiRequest = (LUAPIRequest *)otherObject;

    BOOL methodEqual = ((!otherApiRequest.method && !self.method) ||
                        (otherApiRequest.method && self.method &&
                         [otherApiRequest.method isEqualToString:self.method]));

    BOOL pathEqual = ((!otherApiRequest.path && !self.path) ||
                      (otherApiRequest.path && self.path &&
                       [otherApiRequest.path isEqualToString:self.path]));

    BOOL parametersEqual = ((!otherApiRequest.parameters && !self.parameters) ||
                             (otherApiRequest.parameters && self.parameters &&
                              [otherApiRequest.parameters isEqualToDictionary:self.parameters]));

    BOOL includeAccessTokensEqual = otherApiRequest.includeAccessToken == self.includeAccessToken;

    return methodEqual && pathEqual && parametersEqual && includeAccessTokensEqual;
  }

  return NO;
}

#pragma mark - Private Methods

- (NSDictionary *)parametersWithAccessToken {
  NSMutableDictionary *parametersWithAccessToken = [NSMutableDictionary dictionary];

  if (self.includeAccessToken && [LUAPIClient sharedClient].accessToken) {
    parametersWithAccessToken[@"access_token"] = [LUAPIClient sharedClient].accessToken;
  }

  if (self.parameters) {
    [parametersWithAccessToken addEntriesFromDictionary:self.parameters];
  }

  return parametersWithAccessToken;
}

@end
