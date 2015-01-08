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

#import <OHHTTPStubs/OHHTTPStubs.h>

@interface LUAPIStub : NSObject

@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, copy) NSString *HTTPMethod;
@property (nonatomic, strong) id requestBodyJSON;
@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, copy) NSData *responseData;
@property (nonatomic, copy) NSDictionary *responseHeaders;
@property (nonatomic, copy) NSString *responseType;
@property (nonatomic, copy) NSURL *URL;

+ (LUAPIStub *)apiStubForVersion:(NSString *)apiVersion
                            path:(NSString *)path
                      HTTPMethod:(NSString *)HTTPMethod
                   authenticated:(BOOL)authenticated
                    responseData:(NSData *)responseData;
+ (LUAPIStub *)stubForWebURL:(NSURL *)URL withBody:(NSString *)body;
+ (LUAPIStub *)stubForWebURL:(NSURL *)URL withPlainTextResponseString:(NSString *)responseString;
- (BOOL)matchesRequest:(NSURLRequest *)request;
- (OHHTTPStubsResponse *)response;
- (id)responseJSON;

@end
