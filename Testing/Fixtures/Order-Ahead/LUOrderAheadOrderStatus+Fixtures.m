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

#import "LUOrderAheadOrderStatus+Fixtures.h"

@implementation LUOrderAheadOrderStatus (Fixtures)

+ (LUOrderAheadOrderStatus *)fixture {
  return [self fixtureForStartedNewOrder];
}

+ (LUOrderAheadOrderStatus *)fixtureForCompletedOrder {
  NSURL *orderURL = [NSURL URLWithString:@"https://api.staging-levelup.com/v15/order_ahead/orders/9h8g7f6e5d4c3b2a1"];

  return [[LUOrderAheadOrderStatus alloc] initWithOrderURL:orderURL
                                                     state:LUOrderAheadOrderStateSubmitting
                                                      UUID:@"9h8g7f6e5d4c3b2a1"];
}

+ (LUOrderAheadOrderStatus *)fixtureForStartedNewOrder {
  NSURL *orderURL = [NSURL URLWithString:@"https://api.staging-levelup.com/v15/order_ahead/orders/1a2b3c4d5e6f7g8h9i"];

  return [[LUOrderAheadOrderStatus alloc] initWithOrderURL:orderURL
                                                     state:LUOrderAheadOrderStateValidating
                                                      UUID:@"1a2b3c4d5e6f7g8h9i"];
}

@end
