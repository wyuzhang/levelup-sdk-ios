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

describe(@"NSArray", ^{
  describe(@"lu_firstObject", ^{
    context(@"when the array is empty", ^{
      NSArray *array = [NSArray array];

      it(@"is nil", ^{
        [[array lu_firstObject] shouldBeNil];
      });
    });

    context(@"when is array is not empty", ^{
      NSArray *array = @[@1, @2, @3];

      it(@"is the first object", ^{
        [[[array lu_firstObject] should] equal:@1];
      });
    });
  });

  describe(@"mappedArrayWithBlock:", ^{
    it(@"runs the block for each element in the array, returning a new array with the results", ^{
      NSArray *numbers = @[@1, @2, @3];

      NSArray *numbersToStrings = [numbers lu_mappedArrayWithBlock:^(id obj) {
        return [obj stringValue];
      }];

      [[numbersToStrings should] equal:@[@"1", @"2", @"3"]];
    });
  });
});

SPEC_END
