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
