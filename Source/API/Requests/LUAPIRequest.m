// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAbstractJSONModelFactory.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"

NSString * const LUAPIVersion13 = @"v13";
NSString * const LUAPIVersion14 = @"v14";
NSString * const LUAPIVersion15 = @"v15";

@implementation LUAPIRequest

#pragma mark - Object Lifecycle Methods

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            apiVersion:(NSString *)apiVersion
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory {
  return [[self alloc] initWithMethod:method path:path apiVersion:apiVersion parameters:parameters modelFactory:modelFactory];
}

- (id)initWithMethod:(NSString *)method
                path:(NSString *)path
          apiVersion:(NSString *)apiVersion
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory {
  self = [super init];
  if (self) {
    _apiVersion = apiVersion;
    _modelFactory = modelFactory;
    _method = method;
    _path = path;
    _parameters = parameters;
  }

  return self;
}

#pragma mark - Public Methods

- (NSURL *)URL {
  return [self URLRequest].URL;
}

- (NSMutableURLRequest *)URLRequest {
  NSString *pathWithVersion = [NSString stringWithFormat:@"%@/%@", self.apiVersion, self.path];
  NSMutableURLRequest *URLRequest = [[LUAPIClient sharedClient] requestWithMethod:self.method
                                                                             path:pathWithVersion
                                                                       parameters:self.parameters];

  if ([LUAPIClient sharedClient].accessToken) {
    NSString *authorization = [NSString stringWithFormat:@"token %@", [LUAPIClient sharedClient].accessToken];
    [URLRequest addValue:authorization forHTTPHeaderField:@"Authorization"];
  }

  return URLRequest;
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
  if (self.apiVersion) {
    total += [self.apiVersion hash] * 17;
  }
  if (self.parameters) {
    total += [[self.parameters description] hash] * 19;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUAPIRequest class]]) {
    LUAPIRequest *otherApiRequest = (LUAPIRequest *)otherObject;

    BOOL methodEqual = ((!otherApiRequest.method && !self.method) ||
                        (otherApiRequest.method && self.method &&
                         [otherApiRequest.method isEqualToString:self.method]));

    BOOL apiVersionEqual = ((!otherApiRequest.apiVersion && !self.apiVersion) ||
                            (otherApiRequest.apiVersion && self.apiVersion &&
                             [otherApiRequest.apiVersion isEqualToString:self.apiVersion]));

    BOOL pathEqual = ((!otherApiRequest.path && !self.path) ||
                      (otherApiRequest.path && self.path &&
                       [otherApiRequest.path isEqualToString:self.path]));

    BOOL parametersEqual = ((!otherApiRequest.parameters && !self.parameters) ||
                             (otherApiRequest.parameters && self.parameters &&
                              [otherApiRequest.parameters isEqualToDictionary:self.parameters]));

    return methodEqual && apiVersionEqual && pathEqual && parametersEqual;
  }

  return NO;
}

@end
