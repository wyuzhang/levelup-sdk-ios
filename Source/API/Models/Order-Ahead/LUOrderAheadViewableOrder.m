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

#import "LUOrderAheadViewableOrder.h"

@implementation LUOrderAheadViewableOrder

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithCompletionURL:(NSURL *)completionURL
                             discount:(LUMonetaryValue *)discount
                           serviceFee:(LUMonetaryValue *)serviceFee
                   soonestAvailableAt:(NSDate *)soonestAvailableAt
                                spend:(LUMonetaryValue *)spend
                                state:(LUOrderAheadOrderState)state
                                  tax:(LUMonetaryValue *)tax
                                  tip:(LUMonetaryValue *)tip
                                total:(LUMonetaryValue *)total
                                 UUID:(NSString *)UUID {
  self = [super init];
  if (!self) return nil;

  _completionURL = completionURL;
  _discount = discount;
  _serviceFee = serviceFee;
  _soonestAvailableAt = soonestAvailableAt;
  _spend = spend;
  _state = state;
  _tax = tax;
  _tip = tip;
  _total = total;
  _UUID = UUID;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadViewableOrder [address=%p, completionURL=%@, discount=%@, "
          "serviceFee=%@, soonestAvailableAt=%@, spend=%@, state=%@, tax=%@, tip=%@, "
          "total=%@, UUID=%@]", self, self.completionURL, self.discount, self.serviceFee, self.soonestAvailableAt,
          self.spend, [LUOrderAheadOrderStateParser stringForState:self.state], self.tax, self.tip, self.total,
          self.UUID];
}

@end
