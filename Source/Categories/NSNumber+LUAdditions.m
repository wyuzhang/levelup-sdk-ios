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

#import "NSNumber+LUAdditions.h"

@implementation NSNumber (LUAdditions)

- (NSDecimalNumber *)lu_decimalNumber {
  return [NSDecimalNumber decimalNumberWithDecimal:self.decimalValue];
}

- (BOOL)lu_isGreaterThan:(NSNumber *)number {
  return [self lu_safeCompare:number] == NSOrderedDescending;
}

- (BOOL)lu_isGreaterThanOrEqualTo:(NSNumber *)number {
  return [self lu_isGreaterThan:number] || [self isEqualToNumber:number];
}

- (BOOL)lu_isLessThan:(NSNumber *)number {
  return [self lu_safeCompare:number] == NSOrderedAscending;
}

- (BOOL)lu_isLessThanOrEqualTo:(NSNumber *)number {
  return [self lu_isLessThan:number] || [self isEqualToNumber:number];
}

- (BOOL)lu_isPositiveNumber {
  return [self lu_isGreaterThan:@0];
}

- (NSComparisonResult)lu_safeCompare:(NSNumber *)number {
  if (number) {
    return [self compare:number];
  }

  return NSOrderedAscending;
}

- (NSString *)lu_stringWithOrdinal {
  NSArray *suffixes = @[@"th", @"st", @"nd", @"rd", @"th", @"th", @"th", @"th", @"th", @"th"];
  int i = [self intValue];

  switch (i % 100) {
    case 11:
    case 12:
    case 13:
      return [NSString stringWithFormat:@"%dth", i];
    default:
      return [NSString stringWithFormat:@"%d%@", i, suffixes[i % 10]];
  }
}

@end
