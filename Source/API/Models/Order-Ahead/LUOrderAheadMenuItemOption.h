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

@interface LUOrderAheadMenuItemOption : LUAPIModel

@property (nonatomic, assign, readonly) NSUInteger displayOrder;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSNumber *optionID;
@property (nonatomic, copy, readonly) LUMonetaryValue *price;

- (instancetype)initWithDisplayOrder:(NSUInteger)displayOrder
                                name:(NSString *)name
                            optionID:(NSNumber *)optionID
                               price:(LUMonetaryValue *)price;

@end
