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
#import "LUOrderAheadOrderStateParser.h"

@class LUMonetaryValue;

@interface LUOrderAheadViewableOrder : LUAPIModel

@property (nonatomic, copy, readonly) NSURL *completionURL;
@property (nonatomic, strong, readonly) LUMonetaryValue *discount;
@property (nonatomic, strong, readonly) LUMonetaryValue *serviceFee;
@property (nonatomic, strong, readonly) NSDate *soonestAvailableAt;
@property (nonatomic, strong, readonly) LUMonetaryValue *spend;
@property (nonatomic, assign, readonly) LUOrderAheadOrderState state;
@property (nonatomic, strong, readonly) LUMonetaryValue *tax;
@property (nonatomic, strong, readonly) LUMonetaryValue *tip;
@property (nonatomic, strong, readonly) LUMonetaryValue *total;
@property (nonatomic, copy, readonly) NSString *UUID;

- (instancetype)initWithCompletionURL:(NSURL *)completionURL
                             discount:(LUMonetaryValue *)discount
                           serviceFee:(LUMonetaryValue *)serviceFee
                   soonestAvailableAt:(NSDate *)soonestAvailableDate
                                spend:(LUMonetaryValue *)spend
                                state:(LUOrderAheadOrderState)state
                                  tax:(LUMonetaryValue *)tax
                                  tip:(LUMonetaryValue *)tip
                                total:(LUMonetaryValue *)total
                                 UUID:(NSString *)UUID;

@end
