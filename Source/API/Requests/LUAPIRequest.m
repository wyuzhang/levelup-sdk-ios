/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
  return [[self alloc] initWithMethod:method path:path apiVersion:apiVersion parameters:parameters
                         modelFactory:modelFactory];
}

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            apiVersion:(NSString *)apiVersion
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory
                    retryResponseCodes:(NSArray *)retryResponseCodes
                     retryTimeInterval:(NSTimeInterval)retryTimeInterval {
  return [[self alloc] initWithMethod:method path:path apiVersion:apiVersion parameters:parameters
                         modelFactory:modelFactory retryResponseCodes:retryResponseCodes
                    retryTimeInterval:retryTimeInterval];
}

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                   URL:(NSURL *)URL
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory {
  return [[self alloc] initWithMethod:method URL:URL parameters:parameters modelFactory:modelFactory];
}

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                   URL:(NSURL *)URL
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory
                    retryResponseCodes:(NSArray *)retryResponseCodes
                     retryTimeInterval:(NSTimeInterval)retryTimeInterval {
  return [[self alloc] initWithMethod:method URL:URL parameters:parameters modelFactory:modelFactory
                   retryResponseCodes:retryResponseCodes retryTimeInterval:retryTimeInterval];
}

- (id)initWithMethod:(NSString *)method
                 URL:(NSURL *)URL
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory {
  return [self initWithMethod:method URL:URL parameters:parameters modelFactory:modelFactory retryResponseCodes:nil
            retryTimeInterval:0];
}

- (id)initWithMethod:(NSString *)method
                 URL:(NSURL *)URL
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory
  retryResponseCodes:(NSArray *)retryResponseCodes
   retryTimeInterval:(NSTimeInterval)retryTimeInterval {
  return [self initWithMethod:method path:nil apiVersion:nil URL:URL parameters:parameters
                 modelFactory:modelFactory retryResponseCodes:retryResponseCodes retryTimeInterval:retryTimeInterval];
}

- (id)initWithMethod:(NSString *)method
                path:(NSString *)path
          apiVersion:(NSString *)apiVersion
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory {
  return [self initWithMethod:method path:path apiVersion:apiVersion parameters:parameters modelFactory:modelFactory
           retryResponseCodes:nil retryTimeInterval:0];
}

- (id)initWithMethod:(NSString *)method
                path:(NSString *)path
          apiVersion:(NSString *)apiVersion
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory
  retryResponseCodes:(NSArray *)retryResponseCodes
   retryTimeInterval:(NSTimeInterval)retryTimeInterval {
  return [self initWithMethod:method path:path apiVersion:apiVersion URL:nil parameters:parameters
                 modelFactory:modelFactory retryResponseCodes:retryResponseCodes retryTimeInterval:retryTimeInterval];
}

- (id)initWithMethod:(NSString *)method
                path:(NSString *)path
          apiVersion:(NSString *)apiVersion
                 URL:(NSURL *)URL
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory
  retryResponseCodes:(NSArray *)retryResponseCodes
   retryTimeInterval:(NSTimeInterval)retryTimeInterval {
  self = [super init];
  if (self) {
    _method = method;
    _path = path;
    _apiVersion = apiVersion;
    _URL = URL;
    _parameters = parameters;
    _modelFactory = modelFactory;
    _retryResponseCodes = retryResponseCodes;
    _retryTimeInterval = retryTimeInterval;
  }

  return self;
}

#pragma mark - Public Methods

- (NSURL *)URL {
  return [self URLRequest].URL;
}

- (NSMutableURLRequest *)URLRequest {
  NSMutableURLRequest *URLRequest;

  if (_URL) {
    URLRequest = [[LUAPIClient sharedClient] requestWithMethod:self.method
                                                           URL:_URL
                                                    parameters:self.parameters];
  } else {
    NSString *pathWithVersion = [NSString stringWithFormat:@"%@/%@", self.apiVersion, self.path];
    URLRequest = [[LUAPIClient sharedClient] requestWithMethod:self.method
                                                          path:pathWithVersion
                                                    parameters:self.parameters];
  }

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
  if (otherObject && [otherObject isKindOfClass:[LUAPIRequest class]]) {
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
