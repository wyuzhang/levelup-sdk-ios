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

#import "NSError+LUAdditions.h"

@implementation NSError (LUAdditions)

+ (NSError *)lu_carrierAccountErrorWithCode:(LUCarrierAccountErrorCode)code description:(NSString *)description {
  return [self lu_errorWithDomain:LUCarrierAccountErrorDomain errorCode:code description:description];
}

+ (NSError *)lu_deepLinkAuthErrorWithCode:(LUDeepLinkAuthErrorCode)code description:(NSString *)description {
  return [self lu_errorWithDomain:LUDeepLinkAuthErrorDomain errorCode:code description:description];
}

#pragma mark - Private Methods

+ (NSError *)lu_errorWithDomain:(NSString *)domain errorCode:(NSInteger)code description:(NSString *)description {
  return [NSError errorWithDomain:domain
                             code:code
                         userInfo:@{NSLocalizedDescriptionKey: description}];
}

@end
