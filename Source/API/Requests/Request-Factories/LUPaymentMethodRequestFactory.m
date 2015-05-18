/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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
#import "LUPaymentMethodJSONFactory.h"
#import "LUPaymentMethodRequestFactory.h"

@implementation LUPaymentMethodRequestFactory

+ (LUAPIRequest *)requestForPaymentMethod {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"payment_method"
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUPaymentMethodJSONFactory factory]];
}

+ (LUAPIRequest *)requestToDeactivatePaymentMethod {
  return [LUAPIRequest apiRequestWithMethod:@"DELETE"
                                       path:@"payment_method"
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:nil];
}

@end
