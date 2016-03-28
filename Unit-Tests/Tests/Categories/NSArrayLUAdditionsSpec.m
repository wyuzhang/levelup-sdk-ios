/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
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

#import "NSArray+LUAdditions.h"

SPEC_BEGIN(NSArrayLUAdditionsSpec)
NSArray *testArray = @[@1, @2, @3];

describe(@"NSArray", ^{
  describe(@"lu_firstObject", ^{
    context(@"when the array is empty", ^{
      it(@"is nil", ^{
        [[@[] lu_firstObject] shouldBeNil];
      });
    });

    context(@"when is array is not empty", ^{
      it(@"is the first object", ^{
        [[[testArray lu_firstObject] should] equal:@1];
      });
    });
  });

  describe(@"lu_filteredArrayWithBlock:", ^{
    it(@"runs filteredArrayWithPredicate: with the given block on the array, returning the resulting array", ^{
      NSArray *numbersGreaterThanTwo =
        [testArray lu_filteredArrayWithBlock:^BOOL(NSNumber *number) {
          return [number integerValue] > 2;
        }];

      [[numbersGreaterThanTwo should] equal:@[@3]];
    });
  });

  describe(@"lu_mappedArrayWithBlock:", ^{
    it(@"runs the block for each element in the array, returning a new array with the results", ^{
      NSArray *numbersToStrings = [testArray lu_mappedArrayWithBlock:^(id obj) {
        return [obj stringValue];
      }];

      [[numbersToStrings should] equal:@[@"1", @"2", @"3"]];
    });
  });

  describe(@"lu_subarrayWithStartIndex:", ^{
    it(@"returns a sub array with elements ranging from the start index to the end of this array", ^{
      [[[@[@1, @2, @3] lu_subarrayWithStartIndex:0] should] equal:@[@1, @2, @3]];
      [[[@[@1, @2, @3] lu_subarrayWithStartIndex:1] should] equal:@[@2, @3]];
      [[[@[@1, @2, @3] lu_subarrayWithStartIndex:2] should] equal:@[@3]];
      [[[@[@1, @2, @3] lu_subarrayWithStartIndex:3] should] equal:@[]];
    });
  });
});

SPEC_END
