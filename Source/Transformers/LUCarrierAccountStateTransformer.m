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

#import "LUCarrierAccount.h"
#import "LUCarrierAccountStateTransformer.h"

@interface LUCarrierAccountStateTransformer ()

@property (nonatomic, strong) NSDictionary *reverseStateMap;
@property (nonatomic, strong) NSMapTable *stateMap;

@end

NSString * const LUCarrierAccountStateTransformerName = @"LUCarrierAccountStateTransformerName";

@implementation LUCarrierAccountStateTransformer

+ (Class)transformedValueClass {
  return [NSString class];
}

- (id)reverseTransformedValue:(id)value {
  return [self.reverseStateMap objectForKey:[value lowercaseString]];
}

- (id)transformedValue:(id)value {
  return [[self.stateMap objectForKey:value] lowercaseString];
}

#pragma mark - Getters

- (NSDictionary *)reverseStateMap {
  if (_reverseStateMap) return _reverseStateMap;
  NSArray *keys = [[self.stateMap dictionaryRepresentation] allValues];
  NSArray *values = [[self.stateMap dictionaryRepresentation] allKeys];
  _reverseStateMap = [NSDictionary dictionaryWithObjects:values forKeys:keys];
  return _reverseStateMap;
}

- (NSMapTable *)stateMap {
  if (_stateMap) return _stateMap;
  _stateMap = [[NSMapTable alloc] init];
  [_stateMap setObject:@"identifying" forKey:@(LUCarrierAccountStateIdentifying)];
  [_stateMap setObject:@"identified" forKey:@(LUCarrierAccountStateIdentified)];
  [_stateMap setObject:@"checking_eligibility" forKey:@(LUCarrierAccountStateCheckingEligibility)];
  [_stateMap setObject:@"active" forKey:@(LUCarrierAccountStateActive)];
  [_stateMap setObject:@"inactive" forKey:@(LUCarrierAccountStateInactive)];
  return _stateMap;
}

@end
