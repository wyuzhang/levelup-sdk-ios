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

#import "LUOrderAheadOrderStateParser.h"

@implementation LUOrderAheadOrderStateParser

+ (LUOrderAheadOrderState)stateForString:(NSString *)stateString {
  if ([stateString isEqual:@"canceled"]) {
    return LUOrderAheadOrderStateCanceled;
  } else if ([stateString isEqual:@"charging"]) {
    return LUOrderAheadOrderStateCharging;
  } else if ([stateString isEqual:@"completed"]) {
    return LUOrderAheadOrderStateCompleted;
  } else if ([stateString isEqual:@"invalid"]) {
    return LUOrderAheadOrderStateInvalid;
  } else if ([stateString isEqual:@"rejected"]) {
    return LUOrderAheadOrderStateRejected;
  } else if ([stateString isEqual:@"submitted"]) {
    return LUOrderAheadOrderStateSubmitted;
  } else if ([stateString isEqual:@"submitting"]) {
    return LUOrderAheadOrderStateSubmitting;
  } else if ([stateString isEqual:@"valid"]) {
    return LUOrderAheadOrderStateValid;
  } else if ([stateString isEqual:@"validating"]) {
    return LUOrderAheadOrderStateValidating;
  } else {
    return LUOrderAheadOrderStateUnknown;
  }
}

+ (NSString *)stringForState:(LUOrderAheadOrderState)state {
  switch (state) {
    case LUOrderAheadOrderStateUnknown:
      return @"unknown";
    case LUOrderAheadOrderStateCanceled:
      return @"canceled";
    case LUOrderAheadOrderStateCharging:
      return @"charging";
    case LUOrderAheadOrderStateCompleted:
      return @"completed";
    case LUOrderAheadOrderStateInvalid:
      return @"invalid";
    case LUOrderAheadOrderStateRejected:
      return @"rejected";
    case LUOrderAheadOrderStateSubmitted:
      return @"submitted";
    case LUOrderAheadOrderStateSubmitting:
      return @"submitting";
    case LUOrderAheadOrderStateValid:
      return @"valid";
    case LUOrderAheadOrderStateValidating:
      return @"validating";
  }
}

@end
