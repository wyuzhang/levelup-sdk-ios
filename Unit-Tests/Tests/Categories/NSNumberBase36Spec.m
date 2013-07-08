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
