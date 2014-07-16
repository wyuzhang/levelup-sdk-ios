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

#import "NSNumber+Base36.h"

SPEC_BEGIN(NSNumberBase36Spec)

describe(@"NSNumber", ^{
  // Public Methods

  describe(@"lu_base36Value", ^{
    it(@"returns the number as a base36 string", ^{
      NSNumber *number = @50;

      [[[number lu_base36Value] should] equal:@"1E"];
    });
  });
});

SPEC_END
