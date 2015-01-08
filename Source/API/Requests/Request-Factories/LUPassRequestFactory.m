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

#import "LUAPIRequest.h"
#import "LUPassRequestFactory.h"

@implementation LUPassRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForAppPass {
  return [self requestForPassWithParameters:nil];
}

+ (LUAPIRequest *)requestForPassWithMerchantID:(NSNumber *)merchantID {
  NSDictionary *parameters;
  if (merchantID) {
    parameters = @{@"merchant_id": merchantID};
  }

  return [self requestForPassWithParameters:parameters];
}

#pragma mark - Private Methods

+ (LUAPIRequest *)requestForPassWithParameters:(NSDictionary *)parameters {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"pass"
                                 apiVersion:LUAPIVersion15
                                 parameters:parameters
                               modelFactory:nil
                         retryResponseCodes:@[@202]
                          retryTimeInterval:0.5];
}

@end
