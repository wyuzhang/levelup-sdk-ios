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

#import "LUAPIClient.h"
#import "LUAPIStub.h"

@implementation LUAPIStub

#pragma mark - Object Creation

- (id)init {
  self = [super init];
  if (!self) return nil;

  _responseCode = 200;

  return self;
}

+ (LUAPIStub *)apiStubForVersion:(NSString *)apiVersion
                            path:(NSString *)path
                      HTTPMethod:(NSString *)HTTPMethod
                   authenticated:(BOOL)authenticated
                    responseData:(NSData *)responseData {
  LUAPIStub *stub = [[LUAPIStub alloc] init];
  stub.authenticated = authenticated;
  stub.HTTPMethod = HTTPMethod;
  stub.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@", [LUAPIClient sharedClient].baseURL, apiVersion, path]];
  stub.responseData = responseData;
  stub.responseType = @"application/json";

  return stub;
}

+ (LUAPIStub *)stubForWebURL:(NSURL *)URL withBody:(NSString *)body {
  LUAPIStub *stub = [[LUAPIStub alloc] init];
  stub.URL = URL;
  stub.HTTPMethod = @"GET";
  stub.responseData = [[NSString stringWithFormat:@"<html><body>%@</body></html>", body] dataUsingEncoding:NSUTF8StringEncoding];
  stub.responseType = @"text/html";
  return stub;
}

+ (LUAPIStub *)stubForWebURL:(NSURL *)URL withPlainTextResponseString:(NSString *)responseString {
  LUAPIStub *stub = [[LUAPIStub alloc] init];
  stub.URL = URL;
  stub.HTTPMethod = @"GET";
  stub.responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
  stub.responseType = @"text/plain";
  return stub;
}

#pragma mark - Public Methods

- (BOOL)matchesRequest:(NSURLRequest *)request {
  if (![request.URL isEqual:[self URL]]) {
    return NO;
  }

  if (self.authenticated && ![request allHTTPHeaderFields][@"Authorization"]) {
    return NO;
  }

  if (self.HTTPMethod && ![request.HTTPMethod isEqualToString:self.HTTPMethod]) {
    return NO;
  }

  if (self.requestBodyJSON) {
    NSError *error;
    id requestJSON = [NSJSONSerialization JSONObjectWithData:[request HTTPBody] options:0 error:&error];
    if (!error && ![requestJSON isEqual:self.requestBodyJSON]) {
      return NO;
    }
  }

  return YES;
}

- (OHHTTPStubsResponse *)response {
  NSMutableDictionary *headers = [NSMutableDictionary dictionary];
  headers[@"Server"] = @"LevelUp";

  if (self.responseType) {
    headers[@"Content-Type"] = self.responseType;
  }

  [headers addEntriesFromDictionary:self.responseHeaders];

  return [OHHTTPStubsResponse responseWithData:self.responseData
                                    statusCode:(int)self.responseCode
                                  responseTime:0
                                       headers:headers];
}

- (NSDictionary *)responseJSON {
  return [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUAPIStub [URL=%@, HTTPMethod=%@]", self.URL, self.HTTPMethod];
}

- (BOOL)isEqual:(id)otherObject {
  if (otherObject && [otherObject isKindOfClass:[LUAPIStub class]]) {
    LUAPIStub *otherApiStub = (LUAPIStub *)otherObject;

    BOOL urlRequestEqual = [self.URL isEqual:otherApiStub.URL];
    BOOL authenticatedEqual = self.authenticated == otherApiStub.authenticated;
    BOOL httpMethodEqual = [self.HTTPMethod isEqualToString:otherApiStub.HTTPMethod];
    BOOL requestBodyJSONEqual = (!self.requestBodyJSON && !otherApiStub.requestBodyJSON) ||
                                 [self.requestBodyJSON isEqual:otherApiStub.requestBodyJSON];
    return urlRequestEqual && authenticatedEqual && httpMethodEqual && requestBodyJSONEqual;
  }

  return NO;
}

@end
