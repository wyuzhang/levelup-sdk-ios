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

@class LUAbstractJSONModelFactory;

extern NSString * const LUAPIVersion13;
extern NSString * const LUAPIVersion14;
extern NSString * const LUAPIVersion15;

/**
 `LUAPIRequest` represents a request to the LevelUp API. To perform a request, an `LUAPIRequest`
 instance is passed to the `performRequest:success:failure` method of `LUAPIClient`. `LUAPIRequest`
 instances should usually be created by request builders.
 */
@interface LUAPIRequest : NSObject

/**
 The version of the LevelUp API to use for this request.
 */
@property (nonatomic, copy) NSString *apiVersion;

/**
 The HTTP method of the request: "GET", "POST", "PUT", or "DELETE".
 */
@property (nonatomic, copy) NSString *method;

/**
 An `LUAbstractJSONModelFactory` to parse the JSON response.
 */
@property (nonatomic, strong) LUAbstractJSONModelFactory *modelFactory;

/**
 The path component of the URL of the request.
 */
@property (nonatomic, copy) NSString *path;

/**
 An `NSDictionary` of values to be passed as parameters.
 */
@property (nonatomic, copy) NSDictionary *parameters;

/**
 An `NSArray` of `NSNumber` response codes which, if received, will cause the request
 to be repeated by the `LUAPIClient` every retryTimeInterval, until a successful response is received.
 The response codes must be defined as acceptable by http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
 */
@property (nonatomic, copy) NSArray *retryResponseCodes;

/**
 Duration in seconds until a request is repeated.
 */
@property (nonatomic, assign) NSTimeInterval retryTimeInterval;

/**
 An `NSURL` instance for this API request.
 */
@property (nonatomic, strong) NSURL *URL;

/**
 Returns an `LUAPIRequest` with the specified method, path and parameters. An authentication token
 will automatically be included in the request if one is set on the `LUAPIClient`.

 @param method An HTTP method: "GET", "POST", "PUT", or "DELETE".
 @param path The path of the API request, e.g. "/users".
 @param apiVersion The version of the API to use.
 @param parameters A dictionary of parameters to include with this request, or nil if the request
 has no parameters.
 @param modelFactory An instance of `LUAbstractJSONModelFactory` which will parse the response.
 */
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            apiVersion:(NSString *)apiVersion
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory;

/**
 Returns an `LUAPIRequest` with the specified method, path and parameters. An authentication token
 will automatically be included in the request if one is set on the `LUAPIClient`.

 @param method An HTTP method: "GET", "POST", "PUT", or "DELETE".
 @param path The path of the API request, e.g. "/users".
 @param apiVersion The version of the API to use.
 @param parameters A dictionary of parameters to include with this request, or nil if the request
 has no parameters.
 @param modelFactory An instance of `LUAbstractJSONModelFactory` which will parse the response.
 @param retryResponseCodes An `NSArray` of response codes which, if received, will cause the request
 to be repeated by the `LUAPIClient` every retryTimeInterval, until a successful response is received.
 @param retryTimeInterval Duration in seconds until a request is repeated.
 */
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            apiVersion:(NSString *)apiVersion
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory
                    retryResponseCodes:(NSArray *)retryResponseCodes
                     retryTimeInterval:(NSTimeInterval)retryTimeInterval;

/**
 Returns an `LUAPIRequest` with the specified method, URL and response model factory. An authentication token
 will automatically be included in the request if one is set on the `LUAPIClient`.

 @param method An HTTP method: "GET", "POST", "PUT", or "DELETE".
 @param URL The URL of the API including the base URL, e.g. an NSURL with absoluteString
 "https://api.thelevelup.com/v15/users/1".
 @param parameters A dictionary of parameters to include with this request, or nil if the request
 has no parameters.
 @param modelFactory An instance of `LUAbstractJSONModelFactory` which will parse the response.
 */
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                   URL:(NSURL *)URL
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory;

/**
 Returns an `LUAPIRequest` with the specified method, URL and response model factory. An authentication token
 will automatically be included in the request if one is set on the `LUAPIClient`.

 @param method An HTTP method: "GET", "POST", "PUT", or "DELETE".
 @param URL The URL of the API including the base URL, e.g. an NSURL with absoluteString
 "https://api.thelevelup.com/v15/users/1".
 @param parameters A dictionary of parameters to include with this request, or nil if the request
 has no parameters.
 @param modelFactory An instance of `LUAbstractJSONModelFactory` which will parse the response.
 @param retryResponseCodes An `NSArray` of response codes which, if received, will cause the request
 to be repeated by the `LUAPIClient` every retryTimeInterval, until a successful response is received.
 @param retryTimeInterval Duration in seconds until a request is repeated.
 */
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                   URL:(NSURL *)URL
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory
                    retryResponseCodes:(NSArray *)retryResponseCodes
                     retryTimeInterval:(NSTimeInterval)retryTimeInterval;

/**
 Returns an `NSMutableURLRequest` instance for this API request.
 */
- (NSMutableURLRequest *)URLRequest;

- (id)initWithMethod:(NSString *)method
                path:(NSString *)path
          apiVersion:(NSString *)apiVersion
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory;

- (id)initWithMethod:(NSString *)method
                path:(NSString *)path
          apiVersion:(NSString *)apiVersion
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory
  retryResponseCodes:(NSArray *)retryResponseCodes
   retryTimeInterval:(NSTimeInterval)retryTimeInterval;

- (id)initWithMethod:(NSString *)method
                 URL:(NSURL *)URL
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory;

- (id)initWithMethod:(NSString *)method
                 URL:(NSURL *)URL
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory
  retryResponseCodes:(NSArray *)retryResponseCodes
   retryTimeInterval:(NSTimeInterval)retryTimeInterval;

@end
