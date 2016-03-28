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

typedef NS_ENUM(NSInteger, LUOrderAheadOrderState) {
  LUOrderAheadOrderStateUnknown,
  LUOrderAheadOrderStateCanceled,
  LUOrderAheadOrderStateCharging,
  LUOrderAheadOrderStateCompleted,
  LUOrderAheadOrderStateInvalid,
  LUOrderAheadOrderStateRejected,
  LUOrderAheadOrderStateSubmitted,
  LUOrderAheadOrderStateSubmitting,
  LUOrderAheadOrderStateValid,
  LUOrderAheadOrderStateValidating
};

@interface LUOrderAheadOrderStateParser : NSObject

+ (LUOrderAheadOrderState)stateForString:(NSString *)stateString;
+ (NSString *)stringForState:(LUOrderAheadOrderState)state;

@end
