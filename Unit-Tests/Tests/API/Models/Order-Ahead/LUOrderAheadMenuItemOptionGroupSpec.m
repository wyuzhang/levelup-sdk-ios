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

#import "LUOrderAheadMenuItemOption+Fixtures.h"
#import "LUOrderAheadMenuItemOptionGroup+Fixtures.h"

SPEC_BEGIN(LUOrderAheadMenuItemOptionGroupSpec)

describe(@"LUOrderAheadMenuItemOptionGroup", ^{
  __block LUOrderAheadMenuItemOptionGroup *optionGroup;

  beforeEach(^{
    optionGroup = [LUOrderAheadMenuItemOptionGroup fixtureForAppetizerSizeOptionGroup];
  });

  it(@"is an LUAPIModel", ^{
    [[[LUOrderAheadMenuItemOptionGroup class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  describe(@"isValidForSelectedOptionCount:", ^{
    beforeEach(^{
      optionGroup = [LUOrderAheadMenuItemOptionGroup fixtureForToppingsOptionGroup];
    });

    it(@"returns YES when the count is within the option group's minimum and maximum selection count & NO"
      "otherwise", ^{
      [[theValue([optionGroup isValidForSelectedOptionCount:@0]) should] beNo];
      [[theValue([optionGroup isValidForSelectedOptionCount:@1]) should] beYes];
      [[theValue([optionGroup isValidForSelectedOptionCount:@2]) should] beYes];
      [[theValue([optionGroup isValidForSelectedOptionCount:@3]) should] beYes];
      [[theValue([optionGroup isValidForSelectedOptionCount:@4]) should] beNo];
    });
  });

  describe(@"optionsWithIDs:", ^{
    it(@"returns the options with the given IDs", ^{
      LUOrderAheadMenuItemOption *option1 = [LUOrderAheadMenuItemOption fixtureForSmallOption];
      LUOrderAheadMenuItemOption *option2 = [LUOrderAheadMenuItemOption fixtureForLargeOption];
      [[[optionGroup optionsWithIDs:@[option1.optionID, option2.optionID]] should] equal:@[option1, option2]];
    });
  });

  describe(@"priceOfDefaultOptions", ^{
    it(@"totals the price of the default options of the option group, adding $0.00 for options that should be free", ^{
      [[[optionGroup priceOfDefaultOptions] should] equal:[LUMonetaryValue monetaryValueWithUSCents:@99]];
    });
  });

  describe(@"priceOfOptionsWithIDs:", ^{
    it(@"totals the price of the options with the given IDs, adding $0.00 for options options not in the option group,"
    " and options that should be free,", ^{
      LUMonetaryValue *price = [optionGroup priceOfOptionsWithIDs:@[@1, @2, @3, @4, @5]];

      [[price should] equal:[LUMonetaryValue monetaryValueWithUSCents:@298]];
    });
  });

  describe(@"selectionType", ^{
    beforeEach(^{
      optionGroup = [LUOrderAheadMenuItemOptionGroup fixtureForFillingOptionGroup];
    });

    context(@"when option group matches LUUIOrderAheadMenuItemOptionGroupSelectionTypeAny", ^{
      it(@"returns LUUIOrderAheadMenuItemOptionGroupSelectionTypeAny", ^{
        [[theValue(optionGroup.selectionType) should]
          equal:theValue(LUUIOrderAheadMenuItemOptionGroupSelectionTypeAny)];
      });
    });

    context(@"when option group matches LUUIOrderAheadMenuItemOptionGroupSelectionTypeAtLeast", ^{
      beforeEach(^{
        optionGroup = [LUOrderAheadMenuItemOptionGroup fixtureForNachoComboOptionGroup];
      });

      it(@"returns LUUIOrderAheadMenuItemOptionGroupSelectionTypeAtLeast", ^{
        [[theValue(optionGroup.selectionType) should]
          equal:theValue(LUUIOrderAheadMenuItemOptionGroupSelectionTypeAtLeast)];
      });
    });

    context(@"when option group matches LUUIOrderAheadMenuItemOptionGroupSelectionTypeBetween", ^{
      beforeEach(^{
        optionGroup = [LUOrderAheadMenuItemOptionGroup fixtureForToppingsOptionGroup];
      });

      it(@"returns LUUIOrderAheadMenuItemOptionGroupSelectionTypeBetween", ^{
        [[theValue(optionGroup.selectionType) should]
          equal:theValue(LUUIOrderAheadMenuItemOptionGroupSelectionTypeBetween)];
      });
    });

    context(@"when option group matches LUUIOrderAheadMenuItemOptionGroupSelectionTypeExactlyOne", ^{
      beforeEach(^{
        optionGroup = [LUOrderAheadMenuItemOptionGroup fixtureForAppetizerSizeOptionGroup];
      });

      it(@"returns LUUIOrderAheadMenuItemOptionGroupSelectionTypeExactlyOne", ^{
        [[theValue(optionGroup.selectionType) should]
          equal:theValue(LUUIOrderAheadMenuItemOptionGroupSelectionTypeExactlyOne)];
      });
    });

    context(@"when option group matches LUUIOrderAheadMenuItemOptionGroupSelectionTypeExactlyOverOne", ^{
      beforeEach(^{
        optionGroup = [LUOrderAheadMenuItemOptionGroup fixtureForSalsaOptionGroup];
      });

      it(@"returns LUUIOrderAheadMenuItemOptionGroupSelectionTypeExactlyOverOne", ^{
        [[theValue(optionGroup.selectionType) should]
          equal:theValue(LUUIOrderAheadMenuItemOptionGroupSelectionTypeExactlyOverOne)];
      });
    });

    context(@"when option group matches LUUIOrderAheadMenuItemOptionGroupSelectionTypeUpTo", ^{
      beforeEach(^{
        optionGroup = [LUOrderAheadMenuItemOptionGroup fixtureForTortillaOptionGroup];
      });

      it(@"returns LUUIOrderAheadMenuItemOptionGroupSelectionTypeUpTo", ^{
        [[theValue(optionGroup.selectionType) should]
          equal:theValue(LUUIOrderAheadMenuItemOptionGroupSelectionTypeUpTo)];
      });
    });
  });
});

SPEC_END
