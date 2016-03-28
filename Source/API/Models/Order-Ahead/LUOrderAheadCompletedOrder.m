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

#import "LUOrderAheadCompletedOrder.h"

@implementation LUOrderAheadCompletedOrder

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithConveyance:(LUOrderAheadOrderConveyance *)conveyance
                          discount:(LUMonetaryValue *)discount
                      instructions:(NSString *)instructions
                   orderLocationID:(NSNumber *)orderLocationID
                       orderNumber:(NSString *)orderNumber
                           readyAt:(NSDate *)readyAt
                             total:(LUMonetaryValue *)total {
  self = [super init];
  if (!self) return nil;

  _conveyance = conveyance;
  _discount = discount;
  _instructions = instructions;
  _orderLocationID = orderLocationID;
  _orderNumber = orderNumber;
  _readyAt = readyAt;
  _total = total;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadCompletedOrder [address=%p, conveyance=%@, discount=%@, "
                                    "instructions=%@, orderLocationID=%@, orderNumber=%@, readyAt=%@, total=%@",
                                    self, self.conveyance, self.discount, self.instructions, self.orderLocationID,
                                    self.orderNumber, self.readyAt, self.total];
}

@end
