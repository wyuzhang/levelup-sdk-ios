#import "NSDictionary+SafetyAdditions.h"

SPEC_BEGIN(NSDictionarySafetyAdditionsSpec)

describe(@"NSDictionary Safety Additions", ^{

  describe(@"safeValueForKey:", ^{
    it(@"returns the value for the key provided", ^{
      NSDictionary *dict = @{@"foo" : @"bar"};
      NSString *foo = [dict safeValueForKey:@"foo"];
      [[foo should] equal:@"bar"];
    });

    it(@"returns nil if the value for the key is NSNull", ^{
      NSDictionary *dict = @{@"foo" : [NSNull null]};
      id foo = [dict safeValueForKey:@"foo"];
      [foo shouldBeNil];
    });
  });

  describe(@"setSafeValue:forKey:", ^{
    __block NSMutableDictionary *dict;

    beforeEach(^{
      dict = [NSMutableDictionary dictionary];
    });

    it(@"sets the value for the key provided", ^{
      [dict setSafeValue:@"bar" forKey:@"foo"];
      NSString *foo = [dict valueForKey:@"foo"];
      [[foo should] equal:@"bar"];
    });

    it(@"sets the value to NSNull if the value is nil", ^{
      [dict setSafeValue:nil forKey:@"foo"];
      id foo = [dict valueForKey:@"foo"];
      [[foo should] equal:[NSNull null]];
    });
  });
});

SPEC_END
