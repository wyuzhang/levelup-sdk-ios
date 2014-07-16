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

#import "NSString+HTMLStripping.h"

SPEC_BEGIN(NSStringHTMLStrippingSpec)

describe(@"NSString", ^{
  // Public Methods

  describe(@"lu_stringByStrippingHTML", ^{
    it(@"returns the string with HTML stripped out", ^{
      NSString *htmlString = @"<p>A test string with a <a href=\"#\">link</a>.</p>";
      NSString *expected = @"A test string with a link.";

      [[[htmlString lu_stringByStrippingHTML] should] equal:expected];
    });
  });
});

SPEC_END
