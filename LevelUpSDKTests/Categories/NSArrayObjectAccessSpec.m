#import "NSArray+ObjectAccess.h"

SPEC_BEGIN(NSArrayObjectAccessSpec)

describe(@"NSArray", ^{
  describe(@"firstObject", ^{
    context(@"when the array is empty", ^{
      NSArray *array = [NSArray array];

      it(@"is nil", ^{
        [[array firstObject] shouldBeNil];
      });
    });

    context(@"when is array is not empty", ^{
      NSArray *array = @[@1, @2, @3];

      it(@"is the first object", ^{
        [[[array firstObject] should] equal:@1];
      });
    });
  });
});

SPEC_END
