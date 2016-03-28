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

#import "LUAPIModel.h"

@class LUMonetaryValue;
@class LUOrderAheadOrderConveyance;

@interface LUOrderAheadCompletedOrder : LUAPIModel

@property (nonatomic, strong, readonly) LUOrderAheadOrderConveyance *conveyance;
@property (nonatomic, strong, readonly) LUMonetaryValue *discount;
@property (nonatomic, copy, readonly) NSString *instructions;
@property (nonatomic, copy, readonly) NSNumber *orderLocationID;
@property (nonatomic, copy, readonly) NSString *orderNumber;
@property (nonatomic, strong, readonly) NSDate *readyAt;
@property (nonatomic, strong, readonly) LUMonetaryValue *total;

- (instancetype)initWithConveyance:(LUOrderAheadOrderConveyance *)conveyance
                          discount:(LUMonetaryValue *)discount
                      instructions:(NSString *)instructions
                   orderLocationID:(NSNumber *)orderLocationID
                       orderNumber:(NSString *)orderNumber
                           readyAt:(NSDate *)readyAt
                             total:(LUMonetaryValue *)total;

@end
