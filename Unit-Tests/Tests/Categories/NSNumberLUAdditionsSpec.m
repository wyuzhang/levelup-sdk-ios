#import "NSNumber+LUAdditions.h"

SPEC_BEGIN(NSNumberLUAdditionsSpec)

describe(@"NSNumber", ^{
  describe(@"lu_decimalNumber", ^{
    it(@"returns an NSDecimalNumber version of this NSNumber that can be used for math operations", ^{
      [[[[@1 lu_decimalNumber] class] should] equal:[NSDecimalNumber class]];
      NSDecimalNumber *firstDecimalNumber = [@1 lu_decimalNumber];
      NSDecimalNumber *secondDecimalNumber = [@1 lu_decimalNumber];
      [[[firstDecimalNumber decimalNumberByAdding:secondDecimalNumber] should] equal:[@2 lu_decimalNumber]];
    });
  });

  describe(@"lu_isGreaterThan:", ^{
    it(@"determines if a number is greater than another number", ^{
      [[theValue([@1 lu_isGreaterThan:@2]) should] beNo];
      [[theValue([@1 lu_isGreaterThan:@1]) should] beNo];
      [[theValue([@1 lu_isGreaterThan:@0]) should] beYes];
    });
  });

  describe(@"lu_isGreaterThanOrEqualTo:", ^{
    it(@"determines if a number is greater than or equal to another number", ^{
      [[theValue([@1 lu_isGreaterThanOrEqualTo:@2]) should] beNo];
      [[theValue([@1 lu_isGreaterThanOrEqualTo:@1]) should] beYes];
      [[theValue([@1 lu_isGreaterThanOrEqualTo:@0]) should] beYes];
    });
  });

  describe(@"lu_isLessThan:", ^{
    it(@"determines if a number is less than another number", ^{
      [[theValue([@1 lu_isLessThan:@2]) should] beYes];
      [[theValue([@1 lu_isLessThan:@1]) should] beNo];
      [[theValue([@1 lu_isLessThan:@0]) should] beNo];
    });
  });

  describe(@"lu_isGreaterThanOrEqualTo:", ^{
    it(@"determines if a number is less than or equal to another number", ^{
      [[theValue([@1 lu_isLessThanOrEqualTo:@2]) should] beYes];
      [[theValue([@1 lu_isLessThanOrEqualTo:@1]) should] beYes];
      [[theValue([@1 lu_isLessThanOrEqualTo:@0]) should] beNo];
    });
  });

  describe(@"lu_isPositiveNumber", ^{
    it(@"determines if a number is positive", ^{
      [[theValue([@1 lu_isPositiveNumber]) should] beYes];
      [[theValue([@0 lu_isPositiveNumber]) should] beNo];
      [[theValue([@-1 lu_isPositiveNumber]) should] beNo];
    });
  });

  describe(@"lu_stringWithOrdinal", ^{
    __block NSNumber *number;

    context(@"when the number ends in 0", ^{
      beforeEach(^{
        number = @20;
      });

      it(@"affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"20th"];
      });
    });

    context(@"when the number ends in 1", ^{
      beforeEach(^{
        number = @21;
      });

      it(@"affixes 'st'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"21st"];
      });
    });

    context(@"when the number ends in 2", ^{
      beforeEach(^{
        number = @22;
      });

      it(@"affixes 'nd'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"22nd"];
      });
    });

    context(@"when the number ends in 3", ^{
      beforeEach(^{
        number = @23;
      });

      it(@"affixes 'rd'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"23rd"];
      });
    });

    context(@"when the number ends in 4", ^{
      beforeEach(^{
        number = @24;
      });

      it(@"affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"24th"];
      });
    });

    context(@"when the number ends in 5", ^{
      beforeEach(^{
        number = @25;
      });

      it(@"affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"25th"];
      });
    });

    context(@"when the number ends in 6", ^{
      beforeEach(^{
        number = @26;
      });

      it(@"affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"26th"];
      });
    });

    context(@"when the number ends in 7", ^{
      beforeEach(^{
        number = @27;
      });

      it(@"affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"27th"];
      });
    });

    context(@"when the number ends in 8", ^{
      beforeEach(^{
        number = @28;
      });

      it(@"affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"28th"];
      });
    });

    context(@"when the number ends in 9", ^{
      beforeEach(^{
        number = @29;
      });

      it(@"affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"29th"];
      });
    });

    context(@"when the number is 11", ^{
      beforeEach(^{
        number = @11;
      });

      it(@"overrides the default and affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"11th"];
      });
    });

    context(@"when the number is 12", ^{
      beforeEach(^{
        number = @12;
      });

      it(@"overrides the default and affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"12th"];
      });
    });

    context(@"when the number is 13", ^{
      beforeEach(^{
        number = @13;
      });

      it(@"overrides the default and affixes 'th'", ^{
        [[[number lu_stringWithOrdinal] should] equal:@"13th"];
      });
    });
  });
});

SPEC_END
