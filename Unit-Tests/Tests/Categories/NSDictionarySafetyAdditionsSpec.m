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

#import "NSDictionary+SafetyAdditions.h"

SPEC_BEGIN(NSDictionarySafetyAdditionsSpec)

describe(@"NSDictionary Safety Additions", ^{

  describe(@"lu_safeValueForKey:", ^{
    it(@"returns the value for the key provided", ^{
      NSDictionary *dict = @{@"foo" : @"bar"};
      NSString *foo = [dict lu_safeValueForKey:@"foo"];
      [[foo should] equal:@"bar"];
    });

    it(@"returns nil if the value for the key is NSNull", ^{
      NSDictionary *dict = @{@"foo" : [NSNull null]};
      id foo = [dict lu_safeValueForKey:@"foo"];
      [foo shouldBeNil];
    });
  });

  describe(@"lu_setSafeValue:forKey:", ^{
    __block NSMutableDictionary *dict;

    beforeEach(^{
      dict = [NSMutableDictionary dictionary];
    });

    it(@"sets the value for the key provided", ^{
      [dict lu_setSafeValue:@"bar" forKey:@"foo"];
      NSString *foo = [dict valueForKey:@"foo"];
      [[foo should] equal:@"bar"];
    });

    it(@"sets the value to NSNull if the value is nil", ^{
      [dict lu_setSafeValue:nil forKey:@"foo"];
      id foo = [dict valueForKey:@"foo"];
      [[foo should] equal:[NSNull null]];
    });
  });
});

SPEC_END
