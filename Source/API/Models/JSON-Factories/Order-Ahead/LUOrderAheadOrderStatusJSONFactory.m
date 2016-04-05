/*
 * Copyright (C) 2016 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUOrderAheadOrderStatusJSONFactory.h"
#import "LUOrderAheadOrderStatus.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderAheadOrderStatusJSONFactory

#pragma mark - LUAbstractJSONModelFactory Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSURL *URL = [attributes lu_URLForKey:@"order_url"];
  LUOrderAheadOrderState state = [LUOrderAheadOrderStateParser stateForString:[attributes lu_stringForKey:@"state"]];
  NSString *UUID = [attributes lu_stringForKey:@"uuid"];

  return [[LUOrderAheadOrderStatus alloc] initWithOrderURL:URL state:state UUID:UUID];
}

- (NSString *)rootKey {
  return @"order";
}

@end
