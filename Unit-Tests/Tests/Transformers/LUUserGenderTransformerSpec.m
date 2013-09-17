#import "LUUserGenderTransformer.h"

SPEC_BEGIN(LUUserGenderTransformerSpec)

describe(@"LUUserGenderTransformer", ^{
  __block NSValueTransformer *transformer;

  beforeAll(^{
    [NSValueTransformer setValueTransformer:[[LUUserGenderTransformer alloc] init] forName:LUUserGenderTransformerName];
    transformer = [NSValueTransformer valueTransformerForName:LUUserGenderTransformerName];
  });

  describe(@"transformValue:", ^{
    it(@"returns the proper gender string", ^{
      NSString *gender = [transformer transformedValue:@(LUGenderMale)];
      [[gender should] equal:@"Male"];
    });
  });

  describe(@"reverseTransformedValue:", ^{
    it(@"returns an NSNumber representation of the proper enumerated value for the gender string", ^{
      NSNumber *gender = [transformer reverseTransformedValue:@"Male"];
      [[gender should] equal:@(LUGenderMale)];
    });

    it(@"is case insensitive", ^{
      NSNumber *gender = [transformer reverseTransformedValue:@"male"];
      [[gender should] equal:@(LUGenderMale)];
    });
  });
});

SPEC_END
